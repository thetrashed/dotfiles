local util = require("formatter.util")
local filetypes = "formatter.filetypes."
local defaults = require("formatter.defaults")

require("formatter").setup({
	logging = false,

	filetype = {
		lua = {
			require(filetypes .. "lua").stylua,

			function()
				if util.get_current_buffer_file_name() == "special.lua" then
					return nil
				end

				return {
					exe = "stylua",
					args = {
						"--search-parent-directories",
						"--stdin-filepath",
						util.escape_path(util.get_current_buffer_file_path()),
						"--",
						"-",
					},
					stdin = true,
				}
			end,
		},
		python = {
			require(filetypes .. "python").black,
			function()
				return {
					exe = "black",
					args = { "-q", "-" },
					stdin = true,
				}
			end,
		},
		c = {
			require(filetypes .. "c").clangformat,
			function()
				return {
					util.copyf(defaults.clangformat),
				}
			end,
		},
		cpp = {
			require(filetypes .. "cpp").clangformat,
			function()
				return {
					util.copyf(defaults.clangformat),
				}
			end,
		},
		css = {
			require(filetypes .. "css").prettier,
			function()
				return util.copyf(defaults.prettier)
			end,
		},
		html = {
			require(filetypes .. "html").prettier,
			function()
				return util.copyf(defaults.prettier)
			end,
		},
		javascript = {
			require(filetypes .. "javascript").prettier,
			function()
				return util.copyf(defaults.prettier)
			end,
		},
		typescript = {
			require(filetypes .. "typescript").prettier,
			function()
				return util.copyf(defaults.prettier)
			end,
		},
		rust = {
			require(filetypes .. "rust").rustfmt,
			function()
				return {
					exe = "rustfmt",
					args = {},
					stdin = true,
				}
			end,
		},
		latex = {
			require(filetypes .. "latex").latexindent,
			function()
				return util.copyf(defaults.latexindent)
			end,
		},
		toml = {
			require(filetypes .. "toml").taplo,
			function()
				return {
					exe = "taplo",
					args = { "fmt", "-" },
					stdin = true,
					try_node_modules = true,
				}
			end,
		},
		["*"] = { require(filetypes .. "any").remove_trailing_whitespace },
	},
})
