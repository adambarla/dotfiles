return {
  {
    "pimalaya/himalaya-vim",
    cmd = {
      "Himalaya",
      "HimalayaAccounts",
      "HimalayaFolders",
      "HimalayaWrite",
    },
    keys = {
      { "<leader>mm", "<cmd>Himalaya<cr>", desc = "Open mail" },
      { "<leader>ma", "<cmd>HimalayaAccounts<cr>", desc = "Mail accounts" },
      { "<leader>mf", "<cmd>HimalayaFolders<cr>", desc = "Mail folders" },
      { "<leader>mw", "<cmd>HimalayaWrite<cr>", desc = "Write mail" },
    },
    init = function()
      vim.env.HIMALAYA_CONFIG = vim.fn.expand("~/.config/himalaya/config.toml")
      vim.g.himalaya_account_picker = "telescope"
      vim.g.himalaya_folder_picker = "telescope"
      vim.g.himalaya_folder_picker_telescope_preview = 0
    end,
  },
}
