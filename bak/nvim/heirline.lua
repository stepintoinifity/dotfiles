if true then
	return {}
end
return {
	"rebelot/heirline.nvim",
	event = "UiEnter",
	-- commit = "fe7a8e8",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local utils = require("heirline.utils")
		local conditions = require("heirline.conditions")
		local M = {}

		local colors = {
			bright_bg = utils.get_highlight("Folded").bg,
			bright_fg = utils.get_highlight("Folded").fg,
			red = utils.get_highlight("DiagnosticError").fg,
			dark_red = utils.get_highlight("DiffDelete").bg,
			green = utils.get_highlight("String").fg,
			blue = utils.get_highlight("Function").fg,
			gray = utils.get_highlight("NonText").fg,
			orange = utils.get_highlight("Constant").fg,
			purple = utils.get_highlight("Statement").fg,
			cyan = utils.get_highlight("Special").fg,
			diag_warn = utils.get_highlight("DiagnosticWarn").fg,
			diag_error = utils.get_highlight("DiagnosticError").fg,
			diag_hint = utils.get_highlight("DiagnosticHint").fg,
			diag_info = utils.get_highlight("DiagnosticInfo").fg,
			git_del = utils.get_highlight("diffDeleted").fg,
			git_add = utils.get_highlight("diffAdded").fg,
			git_change = utils.get_highlight("diffChanged").fg,
		}

		M.colors = function()
			return colors
		end

		local Navic = {
			-- condition = function()
			-- 	return require("nvim-navic").is_available()
			-- end,
			static = {
				-- create a type highlight map
				type_hl = {
					File = "Directory",
					Module = "@include",
					Namespace = "@namespace",
					Package = "@include",
					Class = "@structure",
					Method = "@method",
					Property = "@property",
					Field = "@field",
					Constructor = "@constructor",
					Enum = "@field",
					Interface = "@type",
					Function = "@function",
					Variable = "@variable",
					Constant = "@constant",
					String = "@string",
					Number = "@number",
					Boolean = "@boolean",
					Array = "@field",
					Object = "@type",
					Key = "@keyword",
					Null = "@comment",
					EnumMember = "@field",
					Struct = "@structure",
					Event = "@keyword",
					Operator = "@operator",
					TypeParameter = "@type",
				},
				-- bit operation dark magic, see below...
				enc = function(line, col, winnr)
					return bit.bor(bit.lshift(line, 16), bit.lshift(col, 6), winnr)
				end,
				-- line: 16 bit (65535); col: 10 bit (1023); winnr: 6 bit (63)
				dec = function(c)
					local line = bit.rshift(c, 16)
					local col = bit.band(bit.rshift(c, 6), 1023)
					local winnr = bit.band(c, 63)
					return line, col, winnr
				end,
			},
			init = function(self)
				-- local data = require("nvim-navic").get_data() or {}
				local data = self.navic
				local children = {}
				-- create a child for each level
				for i, d in ipairs(data) do
					-- encode line and column numbers into a single integer
					local pos = self.enc(d.scope.start.line, d.scope.start.character, self.winnr)
					local child = {
						{
							provider = d.icon,
							hl = self.type_hl[d.type],
						},
						{
							-- escape `%`s (elixir) and buggy default separators
							provider = d.name:gsub("%%", "%%%%"):gsub("%s*->%s*", ""),
							-- highlight icon only or location name as well
							-- hl = self.type_hl[d.type],

							on_click = {
								-- pass the encoded position through minwid
								minwid = pos,
								callback = function(_, minwid)
									-- decode
									local line, col, winnr = self.dec(minwid)
									vim.api.nvim_win_set_cursor(vim.fn.win_getid(winnr), { line, col })
								end,
								name = "heirline_navic",
							},
						},
					}
					-- add a separator only if needed
					if #data > 1 and i < #data then
						table.insert(child, {
							provider = " > ",
							hl = { fg = "bright_fg" },
						})
					end
					table.insert(children, child)
				end
				-- instantiate the new child, overwriting the previous one
				self.child = self:new(children, 1)
			end,
			-- evaluate the children containing navic components
			provider = function(self)
				return self.child:eval()
			end,
			hl = { fg = "gray", bold = false },
			update = "CursorMoved",
		}

		Navic = {
			condition = function(self)
				local data = require("nvim-navic").get_data()
				if data ~= nil and #data > 0 then
					self.navic = data
					return true
				end
				return false
			end,
			utils.surround(
				{ "", "" },
				-- utils.get_highlight("TabLineSel").bg,
				utils.get_highlight("TabLine").bg,
				{ hl = { fg = colors.bright_fg, force = true }, Navic }
			),
		}

		M.WinBars = {
			-- A winbar for regular files
			Navic,
		}

		local TabLineOffset = {
			condition = function(self)
				local win = vim.api.nvim_tabpage_list_wins(0)[1]
				local bufnr = vim.api.nvim_win_get_buf(win)
				-- self.winid = win
				-- if vim.bo[bufnr].filetype == "NvimTree" then
				-- 	self.title = "NvimTree"
				-- 	return true
				-- 	-- elseif vim.bo[bufnr].filetype == "TagBar" then
				-- 	--     ...
				-- end
				if vim.bo[bufnr].filetype == "neo-tree" then
					self.title = "NeoTree"
					return true
					-- 	-- 	-- elseif vim.bo[bufnr].filetype == "TagBar" then
					-- 	-- 	--     ...
				end
				return false
			end,

			provider = function(self)
				local title = self.title
				local width = vim.api.nvim_win_get_width(self.winid)
				local pad = math.ceil((width - #title) / 2) - 1 -- -1 because of surround
				return string.rep(" ", pad) .. title .. string.rep(" ", pad)
			end,

			hl = function(self)
				if vim.api.nvim_get_current_win() == self.winid then
					return "TablineSel"
				end
			end,
			-- hl = function(self)
			--     if vim.api.nvim_get_current_win() == self.winid then
			--         return "TablineSel"
			--     else
			--         return "Tabline"
			--     end
			-- end,
		}

		TabLineOffset = {
			condition = function(self)
				local win = vim.api.nvim_tabpage_list_wins(0)[1]
				local bufnr = vim.api.nvim_win_get_buf(win)
				self.winid = win

				if vim.bo[bufnr].filetype == "neo-tree" then
					return true
				end
				return false
			end,
			utils.surround({ "", "" }, utils.get_highlight("TablineSel").bg, TabLineOffset),
		}

		local TablineBufnr = {
			provider = function(self)
				return tostring(self.bufnr) .. "."
			end,
			-- hl = "Comment" and { italic = false },
			hl = function()
				return { fg = "grey", italic = false }
			end,
		}

		local TablinePicker = { -- add buffer picker functionality to each buffer
			condition = function(self)
				return self._show_picker
			end,
			update = false,
			init = function(self)
				if self.label and vim.tbl_get(self._picker_labels, self.label) then
					return
				end
				local bufname = vim.api.nvim_buf_get_name(self.bufnr)
				bufname = vim.fn.fnamemodify(bufname, ":t")
				local label = bufname:sub(1, 1)
				local i = 2
				while self._picker_labels[label] do
					if i > #bufname then
						break
					end
					label = bufname:sub(i, i)
					i = i + 1
				end
				self._picker_labels[label] = self.bufnr
				self.label = label
			end,
			provider = function(self)
				return self.label .. " "
			end,
			hl = { fg = "orange", bold = true },
		}

		local FileIcon = {
			init = function(self)
				local filename = self.filename
				local extension = vim.fn.fnamemodify(filename, ":e")
				self.icon, self.icon_color =
					require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
			end,
			condition = function(self)
				return not self._show_picker
			end,
			provider = function(self)
				return self.icon and (self.icon .. " ")
			end,
			hl = function(self)
				return { fg = self.icon_color }
			end,
		}

		local TablineFileName = {
			provider = function(self)
				-- self.filename will be defined later, just keep looking at the example!
				local filename = self.filename
				filename = filename == "" and "[No Name]" or vim.fn.fnamemodify(filename, ":t")
				return filename
			end,
			hl = function()
				-- return { bold = self.is_active or self.is_visible, italic = false }
				return { bold = false, italic = false }
			end,
		}

		-- this looks exactly like the FileFlags component that we saw in
		-- #crash-course-part-ii-filename-and-friends, but we are indexing the bufnr explicitly
		-- also, we are adding a nice icon for terminal buffers.
		local TablineFileFlags = {
			{
				condition = function(self)
					return vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
				end,
				provider = "[+]",
				hl = { fg = "green" },
			},
			{
				condition = function(self)
					return not vim.api.nvim_get_option_value("modifiable", { buf = self.bufnr })
						or vim.api.nvim_get_option_value("readonly", { buf = self.bufnr })
				end,
				provider = function(self)
					if vim.api.nvim_get_option_value("buftype", { buf = self.bufnr }) == "terminal" then
						return "  "
					else
						-- return " "
						return " "
					end
				end,
				hl = { fg = "orange" },
			},
		}

		-- Here the filename block finally comes together
		local TablineFileNameBlock = {
			init = function(self)
				self.filename = vim.api.nvim_buf_get_name(self.bufnr)
			end,
			hl = function(self)
				-- if self.is_active then
				-- 	return "TabLineSel"
				-- 	-- why not?
				-- elseif not vim.api.nvim_buf_is_loaded(self.bufnr) then
				-- 	return { fg = "gray" }
				-- else
				-- 	-- return "gray"
				-- 	return "TabLine"
				-- end

				if self.is_active then
					return "TabLineSel"
				else
					return "TabLine"
				end
			end,
			on_click = {
				callback = function(_, minwid, _, button)
					if button == "m" then -- close on mouse middle click
						vim.schedule(function()
							vim.api.nvim_buf_delete(minwid, { force = false })
						end)
					else
						vim.api.nvim_win_set_buf(0, minwid)
					end
				end,
				minwid = function(self)
					return self.bufnr
				end,
				name = "heirline_tabline_buffer_callback",
			},
			TablineBufnr,
			TablinePicker,
			FileIcon, -- turns out the version defined in #crash-course-part-ii-filename-and-friends can be reutilized as is here!
			TablineFileName,
			TablineFileFlags,
		}

		-- a nice "x" button to close the buffer
		local TablineCloseButton = {
			condition = function(self)
				return not vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
			end,
			{ provider = " " },
			{
				-- provider = "",
				provider = "",
				hl = { fg = "gray" },
				on_click = {
					callback = function(_, minwid)
						vim.schedule(function()
							vim.api.nvim_buf_delete(minwid, { force = false })
							vim.cmd.redrawtabline()
						end)
					end,
					minwid = function(self)
						return self.bufnr
					end,
					name = "heirline_tabline_close_buffer_callback",
				},
			},
		}

		local TablineBufferBlock = utils.surround({ "", "" }, function(self)
			-- return utils.get_highlight("TabLineSel").bg
			if self.is_active then
				return utils.get_highlight("TabLineSel").bg
			else
				return utils.get_highlight("TabLine").bg
			end
		end, { TablineFileNameBlock, TablineCloseButton })

		-- initialize the buflist cache
		local buflist_cache = {}

		-- this is the default function used to retrieve buffers
		local get_bufs = function()
			return vim.tbl_filter(function(bufnr)
				return vim.api.nvim_get_option_value("buflisted", { buf = bufnr })
			end, vim.api.nvim_list_bufs())
		end

		-- setup an autocmd that updates the buflist_cache every time that buffers are added/removed
		vim.api.nvim_create_autocmd({ "VimEnter", "UIEnter", "BufAdd", "BufDelete" }, {
			callback = function()
				vim.schedule(function()
					local buffers = get_bufs()
					for i, v in ipairs(buffers) do
						buflist_cache[i] = v
					end
					for i = #buffers + 1, #buflist_cache do
						buflist_cache[i] = nil
					end

					-- check how many buffers we have and set showtabline accordingly
					if #buflist_cache > 1 then
						vim.o.showtabline = 2 -- always
					elseif vim.o.showtabline ~= 1 then -- don't reset the option if it's already at default value
						vim.o.showtabline = 1 -- only when #tabpages > 1
					end
				end)
			end,
		})

		local BufferLine = utils.make_buflist(
			TablineBufferBlock,
			{ provider = " ", hl = { fg = "gray" } },
			{ provider = " ", hl = { fg = "gray" } },
			-- { provider = "", hl = { fg = "gray" } },
			-- { provider = "", hl = { fg = "gray" } },
			-- out buf_func simply returns the buflist_cache
			function()
				return buflist_cache
			end,
			-- no cache, as we're handling everything ourselves
			false
		)

		local Tabpage = {
			provider = function(self)
				return "%" .. self.tabnr .. "T " .. self.tabpage .. " %T"
			end,
			hl = function(self)
				if not self.is_active then
					return "TabLine"
				else
					return "TabLineSel"
				end
			end,
		}

		local TabpageClose = {
			provider = "%999X  %X",
			hl = "TabLine",
		}

		local TabPages = {
			-- only show this component if there's 2 or more tabpages
			condition = function()
				return #vim.api.nvim_list_tabpages() >= 2
			end,
			{ provider = "%=" },
			utils.make_tablist(Tabpage),
			TabpageClose,
		}

		M.TabLine = {
			condition = function()
				local pattern = {
					filetype = { "alpha" },
					buftype = {},
				}
				return not conditions.buffer_matches(pattern)
			end,
			-- Padding,
			TabLineOffset,
			BufferLine,
			TabPages,
		}

		require("heirline").setup({
			winbar = M.WinBars,
			tabline = M.TabLine,
			opts = {
				colors = M.colors,
				disable_winbar_cb = function(args)
					return conditions.buffer_matches({
						buftype = { "nofile", "prompt", "help", "quickfix" },
						filetype = { "^git.*", "fugitive", "Trouble", "dashboard" },
					}, args.buf)
				end,
			},
		})

		vim.keymap.set("n", "<leader>bb", function()
			local tabline = require("heirline").tabline
			vim.cmd.redrawtabline()
			local buflist = vim.tbl_get(tabline, "_buflist", 1)
			if buflist then
				buflist._picker_labels = {}
				buflist._show_picker = true
				vim.cmd.redrawtabline()
				local char = vim.fn.getcharstr()
				local bufnr = buflist._picker_labels[char]
				if bufnr then
					vim.api.nvim_win_set_buf(0, bufnr)
				end
				buflist._show_picker = false
				vim.cmd.redrawtabline()
			end
		end, { desc = "Select buf" })

		local binarySearch = function(bufnr)
			local left = 1
			local right = #buflist_cache
			while left < right do
				local mid = left + math.floor((right - left) / 2)
				if buflist_cache[mid] > bufnr then
					right = mid - 1
				elseif buflist_cache[mid] < bufnr then
					left = mid + 1
				else
					return mid
				end
			end
			return left
		end

		vim.keymap.set("n", "<leader>bc", function()
			local bufnr = vim.api.nvim_get_current_buf()
			local len = #buflist_cache
			local index = binarySearch(bufnr)
			index = index + 1
			if index > len then
				index = len - 1
			end
			vim.api.nvim_buf_delete(bufnr, { force = false })
			if len > 1 then
				vim.api.nvim_win_set_buf(0, buflist_cache[index])
			end
			vim.cmd.redrawtabline()
		end, { desc = "Close current buf" })

		vim.keymap.set("n", "<leader>bo", function()
			local curbufnr = vim.api.nvim_get_current_buf()
			for _, bufnr in ipairs(buflist_cache) do
				if curbufnr ~= bufnr then
					vim.api.nvim_buf_delete(bufnr, { force = false })
				end
			end
			vim.cmd.redrawtabline()
		end, { desc = "Close other buf" })

		vim.keymap.set("n", "<leader>ba", function()
			for _, bufnr in ipairs(buflist_cache) do
				vim.api.nvim_buf_delete(bufnr, { force = false })
			end
			vim.cmd.redrawtabline()
		end, { desc = "Close all buf" })

		vim.keymap.set("n", "<leader>bl", function()
			local curbufnr = vim.api.nvim_get_current_buf()
			for _, bufnr in ipairs(buflist_cache) do
				if bufnr >= curbufnr then
					break
				end
				vim.api.nvim_buf_delete(bufnr, { force = false })
			end
			vim.cmd.redrawtabline()
		end, { desc = "Close left buf" })

		vim.keymap.set("n", "<leader>br", function()
			local curbufnr = vim.api.nvim_get_current_buf()
			for i = #buflist_cache, 1, -1 do
				if buflist_cache[i] <= curbufnr then
					break
				end
				vim.api.nvim_buf_delete(buflist_cache[i], { force = false })
			end
			vim.cmd.redrawtabline()
		end, { desc = "Close right buf" })
		vim.o.laststatus = 3
		vim.o.showtabline = 1
		vim.cmd([[au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]])
	end,
}
