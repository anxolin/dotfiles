-- Colorscheme configuration
return {
  {
    "folke/tokyonight.nvim",
    lazy = false, -- load during startup
    priority = 1000, -- load before other plugins
    config = function()
      require("tokyonight").setup({
        style = "night", -- storm, moon, night, day
        transparent = false,
        terminal_colors = true,
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
        },
      })
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
}
