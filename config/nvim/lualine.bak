require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'everforest',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {}
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = false,
    refresh = {
      statusline = 100,
      tabline = 100,
      winbar = 100
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics', 'lsp_status'},
    lualine_c = {
      {
	'buffers',
	show_filename_only = true,   -- Shows shortened relative path when set to false.
	hide_filename_extension = false,   -- Hide filename extension when set to true.
	show_modified_status = false, -- Shows indicator when the buffer is modified.

	mode = 3, -- 0: Shows buffer name
		  -- 1: Shows buffer index
		  -- 2: Shows buffer name + buffer index
		  -- 3: Shows buffer number
		  -- 4: Shows buffer name + buffer number

	max_length = vim.o.columns * 2 / 3, -- Maximum width of buffers component,
					    -- it can also be a function that returns
					    -- the value of `max_length` dynamically.
	filetype_names = {
	  TelescopePrompt = 'Telescope',
	  dashboard = 'Dashboard',
	  packer = 'Packer',
	  fzf = 'FZF',
	  alpha = 'Alpha',
	}, -- Shows specific buffer name for that filetype ( { `filetype` = `buffer_name`, ... } )

	-- Automatically updates active buffer color to match color of other components (will be overidden if buffers_color is set)
	use_mode_colors = true,

	-- buffers_color = {
	  -- Same values as the general color option can be used here.
	--   active = 'lualine_{section}_normal',     -- Color for active buffer.
	--   inactive = 'lualine_{section}_inactive', -- Color for inactive buffer.
	-- },

	symbols = {
	  modified = ' ●',      -- Text to show when the buffer is modified
	  alternate_file = '#', -- Text to show to identify the alternate file
	  directory =  '',     -- Text to show when the buffer is a directory
	},
      },
      {
	'filename',
	file_status = true,      -- Displays file status (readonly status, modified status)
	newfile_status = false,  -- Display new file status (new file means no write after created)
	path = 1,      -- 0: Just the filename
		       -- 1: Relative path
		       -- 2: Absolute path
		       -- 3: Absolute path, with tilde as the home directory
		       -- 4: Filename and parent dir, with tilde as the home directory

	shorting_target = 40,    -- Shortens path to leave 40 spaces in the window
				 -- for other components. (terrible name, any suggestions?)
	symbols = {
	  modified = '[+]',      -- Text to show when the file is modified.
	  readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
	  unnamed = '[No Name]', -- Text to show for unnamed buffers.
	  newfile = '[New]',     -- Text to show for newly created file before first write
	}
      },
    },

    -- lualine_x = {'encoding'},
    -- lualine_x = {
    --   {
    --     'filetype',
    --     colored = true,   -- Displays filetype icon in color if set to true
    --     icon_only = false, -- Display only an icon for filetype
    --     icon = { align = 'left' },  -- Display filetype icon on the right hand side
    --                                 -- icon =    {'X', align='right'}
    --                                 -- Icon string ^ in table is ignored in filetype component
    --   }
    -- },
    lualine_x = {},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

