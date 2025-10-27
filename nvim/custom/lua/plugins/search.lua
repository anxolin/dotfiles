-- Make linter happy
---@diagnostic disable-next-line: undefined-global
local vim = vim

return {
  -- Telescope: Fuzzy search
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8', -- See https://github.com/nvim-telescope/telescope.nvim/releases
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

      -- Add ctrl-p as alternative to <leader>ff
      vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Telescope find files' })
    end,
  }
}
