return {
  "echasnovski/mini.nvim",
  version = "*",
  config = function()
    require("mini.ai").setup()
    require("mini.surround").setup()
    require("mini.icons").setup()
    require("mini.pairs").setup()
    require("mini.files").setup()
    require("mini.operators").setup()
    require("mini.bracketed").setup()
  end,
}
