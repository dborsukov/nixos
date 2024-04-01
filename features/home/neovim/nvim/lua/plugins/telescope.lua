return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  opts = {
    defaults = {
      mappings = {
        i = {
          ['<Esc>'] = 'close',
          ['<C-j>'] = 'move_selection_next',
          ['<Tab>'] = 'move_selection_next',
          ['<C-k>'] = 'move_selection_previous',
          ['<S-Tab>'] = 'move_selection_previous',
        },
      },
      layout_strategy = 'horizontal',
    },
    pickers = {
      oldfiles = {
        theme = 'dropdown',
      },
      find_files = {
        theme = 'dropdown',
      },
      command_history = {
        theme = 'dropdown',
      },
      help_tags = {
        theme = 'dropdown',
      },
    },
  },
}
