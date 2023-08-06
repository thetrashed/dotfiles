function ColorMyPencils(color)
	color = color or "spacecamp"
	vim.cmd.colorscheme(color)
end

ColorMyPencils("gruber-darker")
