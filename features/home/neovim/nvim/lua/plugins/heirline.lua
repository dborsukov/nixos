return {
  'rebelot/heirline.nvim',
  config = function()
    vim.o.cmdheight = 0
    vim.o.showcmdloc = 'statusline'

    local utils = require('heirline.utils')
    local conditions = require('heirline.conditions')

    local colors = {
      bright_bg = utils.get_highlight('Folded').bg,
      bright_fg = utils.get_highlight('Folded').fg,
      cyan = utils.get_highlight('Special').fg,
      gray = utils.get_highlight('NonText').fg,
      green = utils.get_highlight('String').fg,
      blue = utils.get_highlight('Function').fg,
      orange = utils.get_highlight('Constant').fg,
      red = utils.get_highlight('DiagnosticError').fg,
    }

    local Align = { provider = '%=' }
    local Space = { provider = ' ' }

    local ViMode = {
      init = function(self)
        self.mode = vim.fn.mode(1):sub(1, 1):lower()
      end,

      static = {
        modes = {
          i = { name = 'INSERT', color = 'green' },
          n = { name = 'NORMAL', color = 'red' },
          v = { name = 'VISUAL', color = 'cyan' },
          ['\22'] = { name = 'VISUAL', color = 'cyan' },
        },
      },

      provider = function(self)
        local mode = self.modes[self.mode]
        if mode then
          return ' ' .. mode.name .. ' '
        else
          return ' ?' .. self.mode .. '? '
        end
      end,

      hl = function(self)
        local mode = self.modes[self.mode]
        if mode then
          return { fg = 'bright_bg', bg = mode.color, bold = true }
        else
          return { fg = 'white', bg = 'black', bold = true }
        end
      end,

      update = {
        'ModeChanged',
        pattern = '*:*',
        callback = vim.schedule_wrap(function()
          vim.cmd('redrawstatus')
        end),
      },
    }

    local FileNameBlock = {
      init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
      end,
    }

    local FileName = {
      provider = function(self)
        local filename = vim.fn.fnamemodify(self.filename, ':.')
        if filename == '' then
          return '[No Name]'
        end
        if not conditions.width_percent_below(#filename, 0.25) then
          filename = vim.fn.pathshorten(filename)
        end
        return filename
      end,
      hl = { fg = utils.get_highlight('Directory').fg },
    }

    local FileFlags = {
      {
        condition = function()
          return vim.bo.modified
        end,
        provider = ' [+]',
        hl = { fg = 'green' },
      },
      {
        condition = function()
          return not vim.bo.modifiable or vim.bo.readonly
        end,
        provider = ' [ro]',
        hl = { fg = 'green' },
      },
    }

    FileNameBlock = utils.insert(FileNameBlock, FileName, FileFlags, { provider = '%<' })

    local Git = {
      condition = conditions.is_git_repo,

      init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
        self.head_exists = self.status_dict.head ~= ''
        self.has_changes = self.head_exists
          and (self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0)
        self.untracked = self.head_exists
          and (self.status_dict.added == nil or self.status_dict.removed == nil or self.status_dict.changed == nil)
      end,

      hl = { fg = 'orange' },

      {
        provider = function(self)
          if self.head_exists then
            return ' ' .. self.status_dict.head
          else
            return ' [No HEAD]'
          end
        end,
        hl = { bold = true },
      },
      {
        condition = function(self)
          return self.has_changes
        end,
        provider = '(',
        hl = { bold = true },
      },
      {
        condition = function(self)
          return self.untracked
        end,
        provider = 'untracked',
        hl = { fg = 'red', bold = true },
      },
      {
        provider = function(self)
          local count = self.status_dict.added or 0
          return count > 0 and ('+' .. count)
        end,
        hl = { fg = 'green' },
      },
      {
        provider = function(self)
          local count = self.status_dict.removed or 0
          return count > 0 and ('-' .. count)
        end,
        hl = { fg = 'red' },
      },
      {
        provider = function(self)
          local count = self.status_dict.changed or 0
          return count > 0 and ('~' .. count)
        end,
        hl = { fg = 'blue' },
      },
      {
        condition = function(self)
          return self.has_changes
        end,
        provider = ')',
        hl = { bold = true },
      },
    }

    local Diagnostics = {
      condition = conditions.has_diagnostics,

      init = function(self)
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
        self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
        self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
      end,

      update = { 'DiagnosticChanged', 'BufEnter' },

      {
        provider = '![',
      },
      {
        provider = function(self)
          return self.errors > 0 and 'e' .. self.errors
        end,
        hl = { fg = utils.get_highlight('DiagnosticError').fg, bold = true },
      },
      {
        provider = function(self)
          return self.warnings > 0 and 'w' .. self.warnings
        end,
        hl = { fg = utils.get_highlight('DiagnosticWarn').fg, bold = true },
      },
      {
        provider = function(self)
          return self.info > 0 and 'i' .. self.info
        end,
        hl = { fg = utils.get_highlight('DiagnosticInfo').fg, bold = true },
      },
      {
        provider = function(self)
          return self.hints > 0 and 'n' .. self.hints
        end,
        hl = { fg = utils.get_highlight('DiagnosticHint').fg, bold = true },
      },
      {
        provider = ']',
      },
    }

    local LSPActive = {
      condition = conditions.lsp_attached,
      update = { 'LspAttach', 'LspDetach' },
      provider = function()
        local names = {}
        for _, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
          table.insert(names, server.name)
        end
        return '[' .. table.concat(names, ' ') .. ']'
      end,
      hl = { fg = 'green', bold = true },
    }

    local MacroRec = {
      condition = function()
        return vim.o.cmdheight == 0 and vim.fn.reg_recording() ~= ''
      end,
      provider = function()
        return ' Recording ' .. "'" .. vim.fn.reg_recording() .. "'"
      end,
      hl = { fg = 'green', bold = true },
      update = {
        'RecordingEnter',
        'RecordingLeave',
      },
    }

    local Ruler = {
      provider = '%l:%2c',
    }

    require('heirline').setup({
      statusline = {
        ViMode,
        Space,
        FileNameBlock,
        Space,
        Git,
        Space,
        MacroRec,
        Align,
        Diagnostics,
        Space,
        LSPActive,
        Space,
        Ruler,
        Space,
        hl = { bg = 'bright_bg' },
      },
      opts = {
        colors = colors,
      },
    })
  end,
}
