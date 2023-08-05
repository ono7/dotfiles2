local fn = vim.fn
local root_dir = fn.stdpath("data")
local install_path = root_dir .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	BS = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	vim.cmd("packadd packer.nvim")
end

--- plugins ---
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	print("packer not installed, something went wrong in my_pkg.lua")
	return
end

--- float window for packer
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

packer.startup(function(use)
	use("wbthomason/packer.nvim")
	use("tpope/vim-repeat") -- done
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdateSync" }) -- done
	use({
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup()
		end,
	}) -- done
	use("nvim-treesitter/playground")
	use("onsails/lspkind-nvim") -- done
	use("Glench/Vim-Jinja2-Syntax") -- done
	use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" }) -- done
	use("numtostr/FTerm.nvim") -- float term, might not need this... -- done

	--- utilities
	use({
		"numtostr/comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	}) -- done

	-- use("ThePrimeagen/harpoon")
	use("numtostr/navigator.nvim")
	use({
		"f-person/git-blame.nvim",
		config = function()
			vim.g.gitblame_enabled = 0
		end,
	}) -- done
	-- use("bluz71/vim-nightfly-colors")
	use({ "akinsho/bufferline.nvim", tag = "v3.*", requires = "nvim-tree/nvim-web-devicons" }) -- done
	-- use("EdenEast/nightfox.nvim")
	use("Shatur/neovim-ayu") -- done
	--- fuzzy find
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	})
	-- completion
	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		"jose-elias-alvarez/null-ls.nvim",
		"bfredl/nvim-miniyank",
		"kylechui/nvim-surround",
	})
	use("l3mon4d3/luasnip")
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp-signature-help",
		},
	})

	use({
		"kyazdani42/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup()
		end,
	})
	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
	})
	--- debugging
	use("mfussenegger/nvim-dap")
	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
	use("thehamsta/nvim-dap-virtual-text")
	use("nvim-telescope/telescope-dap.nvim")

	if BS then
		require("packer").sync()
	end
end)

-- vim.cmd([[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost pkg.lua source <afile> | PackerSync
--   augroup end
-- ]])
