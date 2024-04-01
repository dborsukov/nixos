return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    -- Snippet engine
    'dcampos/nvim-snippy',
    -- Pictograms
    'onsails/lspkind.nvim',
    -- Sources
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
  },
  config = function()
    local cmp = require('cmp')
    cmp.setup({
      completion = { completeopt = 'menu,menuone,noinsert' },
      snippet = {
        expand = function(args)
          require('snippy').expand_snippet(args.body)
        end,
      },
      sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
      },
      formatting = {
        format = require('lspkind').cmp_format({
          mode = 'symbol_text',
        }),
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
      }),
    })
  end,
}
