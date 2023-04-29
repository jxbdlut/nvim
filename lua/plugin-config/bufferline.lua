local uConfig = require("uConfig")
local uBufferLine = uConfig.bufferLine

if uBufferLine == nil or not uBufferLine.enable then
  return
end

local status, bufferline = pcall(require, "bufferline")
if not status then
  vim.notify("not found bufferline")
  return
end

-- bufferline 配置
-- https://github.com/akinsho/bufferline.nvim#configuration
bufferline.setup({
  options = {
    mode = "buffer",
    numbers = "ordinal",
    -- 关闭 Tab 的命令，这里使用 moll/vim-bbye 的 :Bdelete 命令
    close_command = "Bdelete! %d",
    right_mouse_command = "Bdelete! %d",
    -- 侧边栏配置
    -- 左侧让出 nvim-tree 的位置，显示文字 File Explorer
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "left",
      },
    },
    -- 使用 nvim 内置 LSP  后续课程会配置
    diagnostics = "nvim_lsp",
    -- 可选，显示 LSP 报错图标
    -- @diagnostic disable-next-line: unused-local
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local s = " "
      for e, n in pairs(diagnostics_dict) do
        local sym = e == "error" and " " or (e == "warning" and " " or "")
        s = s .. n .. sym
      end
      return s
    end,
  },
})

keymap("n", uBufferLine.go1, ":BufferLineGoToBuffer 1<CR>")
keymap("n", uBufferLine.go2, ":BufferLineGoToBuffer 2<CR>")
keymap("n", uBufferLine.go3, ":BufferLineGoToBuffer 3<CR>")
keymap("n", uBufferLine.go4, ":BufferLineGoToBuffer 4<CR>")
keymap("n", uBufferLine.go5, ":BufferLineGoToBuffer 5<CR>")
keymap("n", uBufferLine.go6, ":BufferLineGoToBuffer 6<CR>")
keymap("n", uBufferLine.go7, ":BufferLineGoToBuffer 7<CR>")
keymap("n", uBufferLine.go8, ":BufferLineGoToBuffer 8<CR>")
keymap("n", uBufferLine.go9, ":BufferLineGoToBuffer 9<CR>")

-- 左右Tab切换
keymap("n", uBufferLine.prev, ":BufferLineCyclePrev<CR>")
keymap("n", uBufferLine.next, ":BufferLineCycleNext<CR>")
-- "moll/vim-bbye" 关闭当前 buffer
keymap("n", uBufferLine.close, ":Bdelete!<CR>")
-- 关闭左/右侧标签页
keymap("n", uBufferLine.close_left, ":BufferLineCloseLeft<CR>")
keymap("n", uBufferLine.close_right, ":BufferLineCloseRight<CR>")
-- 关闭其他标签页
keymap("n", uBufferLine.close_others, ":BufferLineCloseRight<CR>:BufferLineCloseLeft<CR>")
-- 关闭选中标签页
keymap("n", uBufferLine.close_pick, ":BufferLinePickClose<CR>")
