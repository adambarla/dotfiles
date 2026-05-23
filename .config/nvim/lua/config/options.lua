vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smartindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 400

local transparent_groups = {
  "Normal",
  "NormalNC",
  "SignColumn",
  "EndOfBuffer",
  "NormalFloat",
  "FloatBorder",
  "TelescopeNormal",
  "TelescopeBorder",
  "TelescopePromptNormal",
  "TelescopePromptBorder",
  "TelescopeResultsNormal",
  "TelescopeResultsBorder",
  "TelescopePreviewNormal",
  "TelescopePreviewBorder",
}

local function apply_transparent_background()
  for _, group in ipairs(transparent_groups) do
    vim.api.nvim_set_hl(0, group, { bg = "NONE" })
  end
end

apply_transparent_background()

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = apply_transparent_background,
})
