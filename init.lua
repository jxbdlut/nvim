require("utils.global")
-- 基础设置
require("basic")
-- 快捷键绑定
require("keybindings")
-- Packer插件管理器
require("plugins")
-- 主题设置
require("colorscheme")
-- 自动命令
require("autocmds")

-- 内置LSP
require("lsp.setup")
-- 自动补全
require("cmp.setup")
-- 格式化
require("format.setup")
