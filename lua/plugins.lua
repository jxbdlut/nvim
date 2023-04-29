-- 自动安装 Packer.nvimplugin
-- 插件安装目录
-- ~/.local/share/nvim/site/pack/packer/
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local paccker_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
	vim.notify("installing Pakcer.nvim please wait a little ...")
	paccker_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		-- "https://gitcode.net/mirrors/wbthomason/packer.nvim",
		install_path,
	})

	-- https://github.com/wbthomason/packer.nvim/issues/750
	local rtp_addition = vim.fn.stdpath("data") .. "/site/pack/*/start/*"
	if not string.find(vim.o.runtimepath, rtp_addition) then
		vim.o.runtimepath = rtp_addition .. "," .. vim.o.runtimepath
	end
	vim.notify("Pakcer.nvim installed finished")
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	vim.notify("not found packer.nvim")
	return
end

packer.startup(function()
	-- packer can manage itself
	use("wbthomason/packer.nvim")

	-------------------------- plugins -------------------------------------------

	-- 启动时间分析
	use({ "dstein64/vim-startuptime", cmd = "StartupTime" })

	-- 中文help doc
	use({ "yianwillis/vimcdoc", event = "CmdLineEnter" })

	-- nvim-notify
	use({
		"rcarriga/nvim-notify",
		config = function()
			require("plugin-config.nvim-notify")
		end,
	})
	--------------------- colorschemes --------------------
	-- gruvbox theme
	use({
		"ellisonleao/gruvbox.nvim",
		requires = { "rktjmp/lush.nvim" },
	})
	-- nord theme
	use("shaunsingh/nord.nvim")
	-- zephyr-nvim
	use("glepnir/zephyr-nvim")
	-- tokyonight
	use("folke/tokyonight.nvim")

	------------------------------------------------------
	-- nvim-tree
	use({
		"nvim-tree/nvim-tree.lua",
		requires = "nvim-tree/nvim-web-devicons",
		config = function()
			require("plugin-config.nvim-tree")
		end,
	})

	-- bufferline
	use({
		"akinsho/bufferline.nvim",
		requires = { "nvim-tree/nvim-web-devicons", "moll/vim-bbye" },
		config = function()
			require("plugin-config.bufferline")
		end,
	})
	-- lualine
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("plugin-config.lualine")
		end,
	})

	use({
		"nvim-telescope/telescope.nvim",
		-- opt = true,
		-- cmd = "Telescope",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "LinArcX/telescope-env.nvim" },
			{ "nvim-telescope/telescope-ui-select.nvim" },
		},
		config = function()
			require("plugin-config.telescope")
		end,
	})

	-- dashboard-nvim
	use({
		"glepnir/dashboard-nvim",
		config = function()
			require("plugin-config.dashboard")
		end,
	})

	-- project
	use({
		"ahmedkhalf/project.nvim",
		config = function()
			require("plugin-config.project")
		end,
	})

	-- treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			-- require("nvim-treesitter.install").update({ with_sync = true })
		end,
		requires = {
			{ "p00f/nvim-ts-rainbow" },
			{ "JoosepAlviste/nvim-ts-context-commentstring" },
			{ "windwp/nvim-ts-autotag" },
			{ "nvim-treesitter/nvim-treesitter-refactor" },
			{ "nvim-treesitter/nvim-treesitter-textobjects" },
		},
		config = function()
			require("plugin-config.nvim-treesitter")
		end,
	})

	-- indent-blankline
	use({
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("plugin-config.indent-blankline")
		end,
	})

	-- nvim-autopairs
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("plugin-config.nvim-autopairs")
		end,
	})

	-- Comment
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("plugin-config.comment")
		end,
	})

	-- save session
	use({
		"rmagatti/auto-session",
		config = function()
			require("plugin-config.auto-session")
		end,
	})

	-- use("voldikss/vim-floaterm")
	-- toggleterm
	use({
		"akinsho/toggleterm.nvim",
		config = function()
			require("plugin-config.toggleterm")
		end,
	})

	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		setup = function()
			vim.g.mkdp_filetypes = { "markdown" }
			vim.g.mkdp_open_to_the_world = 1
			vim.g.mkdp_browser = ""
			vim.g.mkdp_echo_preview_url = 1
		end,
		ft = { "markdown" },
	})

	--------------------- LSP --------------------
	use("williamboman/mason.nvim")
	-- Lspconfig
	use({ "williamboman/mason-lspconfig.nvim" })
	use({ "neovim/nvim-lspconfig" })

	-- 补全引擎
	use("hrsh7th/nvim-cmp")
	-- snippet 引擎
	-- use("hrsh7th/vim-vsnip")
	-- Snippet 引擎
	use("L3MON4D3/LuaSnip")
	use("saadparwaiz1/cmp_luasnip")
	-- 补全源
	use("hrsh7th/cmp-vsnip")
	use("hrsh7th/cmp-nvim-lsp") -- { name = nvim_lsp }
	use("hrsh7th/cmp-buffer") -- { name = 'buffer' },
	use("hrsh7th/cmp-path") -- { name = 'path' }
	use("hrsh7th/cmp-cmdline") -- { name = 'cmdline' }
	use("hrsh7th/cmp-nvim-lsp-signature-help") -- { name = 'nvim_lsp_signature_help' }

	-- 常见编程语言代码段
	use("rafamadriz/friendly-snippets")

	-- UI增强
	use("onsails/lspkind-nvim")
	use("tami5/lspsaga.nvim")
	-- 代码格式化
	use("mhartington/formatter.nvim")
	use({ "jose-elias-alvarez/null-ls.nvim", requires = "nvim-lua/plenary.nvim" })

	-- Lua 增强
	use("folke/neodev.nvim")
	-- JSON 增强
	use("b0o/schemastore.nvim")
	-- Rust 增强
	use("simrat39/rust-tools.nvim")

	-- git
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("plugin-config.gitsigns")
		end,
	})
end)
