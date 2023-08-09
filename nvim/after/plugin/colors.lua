function ColorMyPencils(color)
	color = color or "spacecamp"
	vim.opt.background = "dark"
	vim.cmd.colorscheme(color)
end

ColorMyPencils("oxocarbon")
