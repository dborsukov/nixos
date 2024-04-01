return {
  'echasnovski/mini.nvim',
  priority = 1000,
  config = function()
    require('mini.align').setup()
    require('mini.comment').setup()
    require('mini.pairs').setup()
    local ok, palette = pcall(require, 'misc.palette')
    if ok then
      require('mini.base16').setup({ palette = palette })
    end
  end,
}
