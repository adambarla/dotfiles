return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
    },
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
      { "<leader>e", "<cmd>Telescope file_browser<cr>", desc = "File browser" },
    },
    config = function()
      local telescope = require("telescope")

      telescope.setup({
        extensions = {
          file_browser = {
            hijack_netrw = true,
          },
        },
      })

      telescope.load_extension("file_browser")
    end,
  },
}
