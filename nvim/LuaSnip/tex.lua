local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local get_visual = function(args, parent)
	if #parent.snippet.env.LS_SELECT_RAW > 0 then
		return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
	else -- If LS_SELECT_RAW is empty, return a blank insert node
		return sn(nil, i(1))
	end
end

local in_mathzone = function()
	return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

return {
	s(
		{ trig = "braket", dscr = "Braket" },
		fmta("\\left\\langle <> \\middle| <> \\right\\rangle", {
			i(1),
			i(2),
		}, { condition = in_mathzone })
	),
	s(
		{ trig = "ket", dscr = "Ket (braket notation)" },
		fmt([[\left| {1} \right\rangle]], {
			i(1),
		}, { condition = in_mathzone })
	),
	s(
		{ trig = "bra", dscr = "Bra (braket notation)" },
		fmt([[\left\langle {1} \right|]], {
			i(1),
		}, { condition = in_mathzone })
	),
	s(
		{ trig = "pdx", dscr = "Adds partial differential operator" },
		fmta("\\frac{\\partial <>}{\\partial <>}", {
			i(1),
			i(2),
		}),
		{ condition = in_mathzone }
	),

	s(
		{ trig = "ff", dscr = 'Expands "ff" into "\frac{}{}"' },
		fmta("\\frac{<>}{<>}", {
			i(1), -- insert node 1
			i(2), -- insert node 2
		}),
		{ condition = in_mathzone }
	),

	s(
		{ trig = "diffx", dscr = "Add the differential operator w.r.t. x" },
		fmta("\\frac{d<>}{dx}", {
			i(1),
		}),
		{ condition = in_mathzone }
	),

	s(
		{ trig = "difft", dscr = "Add the differential operator w.r.t. x" },
		fmta("\\frac{d<>}{dt}", {
			i(1),
		}),
		{ condition = in_mathzone }
	),

	s(
		{ trig = "integral", dscr = "Add integral operator" },
		fmta("\\int_{<>}^{<>}", {
			i(1),
			i(2),
		}),
		{ condition = in_mathzone }
	),

	s({ trig = "intff", snippetType = "autosnippet" }, {
		t("\\int_{-\\infty}^{\\infty}"),
	}, { condition = in_mathzone }),

	s(
		{ trig = "mm", dscr = "Inline math" },
		fmta("<>$<>$", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		})
	),

	s({ trig = "paren", dscr = "Add parentheses" }, fmta("\\left(<>\\right)", i(1)), { condition = in_mathzone }),

	s(
		{ trig = "sb", dscr = "Easy subscripts" },
		fmta("<>_{<>}", {
			i(1),
			i(2),
		}),
		{ condition = in_mathzone }
	),

	s(
		{ trig = "sp", dscr = "Easy superscripts" },
		fmta("<>^{<>}", {
			i(1),
			i(2),
		}),
		{ condition = in_mathzone }
	),

	s({ trig = "bm", dscr = "Bold math" }, fmta("\\mathbf{<>}", i(1)), { condition = in_mathzone }),

	s({ trig = "rm", dscr = "Roman style math" }, fmta("\\mathrm{<>}", i(1)), { condition = in_mathzone }),

	s(
		{ trig = "sm", dscr = "Summation symbol" },
		fmta("\\sum_{<>}^{<>}", {
			i(1),
			i(2),
		}),
		{ condition = in_mathzone }
	),

	-- Environments
	s(
		{ trig = "lmm", dscr = 'Expands "lmm" into aligned math environment' },
		fmta(
			[[
            $$\begin{aligned}
                <>
            \end{aligned}$$
            ]],
			{ i(1) }
		)
	),

	s(
		{ trig = "eq", regTrig = true, wordTrig = false, dscr = 'Expands "eq" into an equation environment' },
		fmta("$$<>$$", i(1))
	),

	s(
		{ trig = "new", dscr = "A generic envrinment in math modes" },
		fmta(
			[[
        \begin{<>}
            <>
        \end{<>}
        ]],
			{
				i(1),
				i(2),
				rep(1),
			}
		),
		{ condition = in_mathzone }
	),

	s(
		{ trig = "abs", dscr = 'Absolute value "\\left|#\\right|"' },
		fmta("\\left|<>\\right|", {
			i(1),
		}),
		{ condition = in_mathzone }
	),

	-- Greek symbols
	s({ trig = ";a", snippetType = "autosnippet" }, {
		t("\\alpha"),
	}),
	s({ trig = ";b", snippetType = "autosnippet" }, {
		t("\\beta"),
	}),
	s({ trig = ";l", snippetType = "autosnippet" }, {
		t("\\lambda"),
	}),
	s({ trig = ";D", snippetType = "autosnippet" }, {
		t("\\Delta"),
	}),
	s({ trig = ";d", snippetType = "autosnippet" }, {
		t("\\delta"),
	}),
	s({ trig = ";e", snippetType = "autosnippet" }, {
		t("\\epsilon"),
	}),
	s({ trig = ";i", snippetType = "autosnippet" }, {
		t("\\pi"),
	}),
	s({ trig = ";g", snippetType = "autosnippet" }, {
		t("\\gamma"),
	}),
	s({ trig = ";ps", snippetType = "autosnippet" }, {
		t("\\psi"),
	}),
	s({ trig = ";ph", snippetType = "autosnippet" }, {
		t("\\phi"),
	}),
	s({ trig = ";t", snippetType = "autosnippet" }, {
		t("\\tau"),
	}),
	s({ trig = ";fn", snippetType = "autosnippet" }, {
		t("\\eta"),
	}),
}
