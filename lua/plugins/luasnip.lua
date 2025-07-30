-- Luasnips
local luasnip = require("luasnip")

local snippet = luasnip.snippet
local text_node = luasnip.text_node
local insert_node = luasnip.insert_node
local function_node = luasnip.function_node
local types = require("luasnip.util.types")

-- Every unspecified option will be set to the default.
luasnip.config.set_config({
	history = true,
	updateevents = "TextChanged,TextChangedI",
	ext_opts = {
		[types.choiceNode] = {
			active = { virt_text = { { "choiceNode", "Comment" } } },
		},
	},
	-- treesitter-hl has 100, use something higher (default is 200).
	ext_base_prio = 300,
	ext_prio_increase = 1, -- minimal increase in priority.
	enable_autosnippets = true,
})

-- args is a table, where 1 is the text in Placeholder 1, 2 the text in
-- placeholder 2,...
local function copy(args)
	return args[1]
end

luasnip.add_snippets("python", {
	-- Main block
	snippet("main", {
		text_node({ 'if __name__ == "__main__":', "    " }),
	}),
	-- Function with return type
	snippet("def", {
		text_node({ "def " }),
		insert_node(1, "function_name"),
		text_node("("),
		insert_node(2, "arg1"),
		text_node({ ") -> " }),
		insert_node(3),
		text_node({ ":", "    " }),
		insert_node(4),
	}),
	-- Add constructor
	snippet("defi", {
		text_node({ "def __init__(self" }),
		insert_node(1),
		text_node({ ") -> None:", "" }),
		text_node({ '\t"""Initialize class instance."""', "" }),
		text_node({ "\t" }),
		insert_node(2),
		text_node({ "", "" }),
	}),
	-- Dataclass
	snippet("dcl", {
		text_node({ "@dataclass", "" }),
		text_node({ "class " }),
		insert_node(1, "ClassName"),
		text_node({ ":", "    " }),
		text_node({ '"""' }),
		insert_node(2, "Description"),
		text_node({ '."""', "" }),
		text_node({ "", "    " }),
		insert_node(3),
		text_node({ "", "" }),
	}),
	-- Class without inheritance and constructor
	snippet("cl", {
		text_node({ "class " }),
		insert_node(1, "ClassName"),
		text_node({ ":", "    " }),
		text_node({ '"""' }),
		insert_node(2, "Description"),
		text_node({ '."""', "" }),
		text_node({ "", "" }),
		text_node({ "    def __init__(self) -> None:", "        " }),
		text_node({ '"""Initialize class instance."""', "" }),
		text_node({ "\t\tsuper().__init__()", "" }),
		text_node({ "\t\t", "" }),
		insert_node(3),
		text_node({ "", "" }),
	}),
	-- Class with inheritance and constructor
	snippet("cli", {
		text_node({ "class " }),
		insert_node(1, "ClassName"),
		text_node("("),
		insert_node(2, "arg1"),
		text_node({ "):" }),
		text_node({ "", "" }),
		text_node({ '\t"""' }),
		insert_node(3),
		text_node({ '."""', "" }),
		text_node({ "", "" }),
		text_node({ "\tdef __init__(self) -> None:", "" }),
		text_node({ '\t\t"""Initialize class instance."""', "" }),
		text_node({ "\t\tsuper().__init__()", "" }),
		text_node({ "\t\t" }),
		insert_node(4),
		text_node({ "\t\t", "" }),
	}),
	-- Fast imports of common libraries
	snippet("num", {
		text_node({ "import numpy as np", "" }),
	}),
	snippet("pan", {
		text_node({ "import pandas as pd", "" }),
	}),
	-- Path utility
	snippet("osp", {
		text_node({ "os.path.join(" }),
		insert_node(1, "base_path"),
		text_node({ ", " }),
		insert_node(2, "sub_path"),
		text_node({ ")", "" }),
	}),
	-- Disabling Pylint
	snippet("pylint", {
		text_node({ " # pylint: disable=" }),
		insert_node(1, "error_code"),
	}),
	-- Disabling Coverage
	snippet("pylint", {
		text_node({ " # pragma: no cover" }),
	}),
	-- Disabling Bandit
	snippet("pylint", {
		text_node({ " # nosec" }),
	}),
	-- Disabling Flake8
	snippet("pylint", {
		text_node({ " # noqa:" }),
		insert_node(1, "error_code"),
	}),
	-- Get logger
	snippet("getl", {
		text_node({ "import logging", "" }),
		text_node({ "LOG = logging.getLogger(" }),
		insert_node(1, "__name__"),
		text_node({ ")", "" }),
	}),
	-- Log error
	snippet("le", {
		text_node({ "LOG.error(" }),
		insert_node(1, "e"),
		text_node({ ")", "" }),
	}),
	-- Log info
	snippet("li", {
		text_node({ "LOG.info(" }),
		insert_node(1, "msg"),
		text_node({ ")", "" }),
	}),
	-- Log warning
	snippet("lw", {
		text_node({ "LOG.warning(" }),
		insert_node(1, "msg"),
		text_node({ ")", "" }),
	}),
	-- Log debug
	snippet("ld", {
		text_node({ "LOG.debug(" }),
		insert_node(1, "msg"),
		text_node({ ")", "" }),
	}),
	-- Log critical
	snippet("ld", {
		text_node({ "LOG.critical(" }),
		insert_node(1, "msg"),
		text_node({ ")", "" }),
	}),
	-- Enumerate
	snippet("en", {
		text_node({ "for i, " }),
		insert_node(1, "val"),
		text_node({ " in enumerate(" }),
		insert_node(2, "items"),
		text_node({ "):", "" }),
		text_node({ "\t" }),
	}),
	-- List comprehension
	snippet("lcp", {
		text_node({ "[" }),
		insert_node(1, "elem"),
		text_node({ " for " }),
		insert_node(2, "val"),
		text_node({ " in " }),
		insert_node(3, "items"),
		text_node({ "]", "" }),
	}),
	-- Set comprehension
	snippet("scp", {
		text_node({ "{" }),
		insert_node(1, "elem"),
		text_node({ " for " }),
		insert_node(2, "val"),
		text_node({ " in " }),
		insert_node(3, "items"),
		text_node({ "}", "" }),
	}),
	-- Generator
	snippet("scp", {
		text_node({ "(" }),
		insert_node(1, "elem"),
		text_node({ " for " }),
		insert_node(2, "val"),
		text_node({ " in " }),
		insert_node(3, "items"),
		text_node({ ")", "" }),
	}),
	-- Dict comprehension
	snippet("dcp", {
		text_node({ "{" }),
		insert_node(1, "key"),
		text_node({ ": " }),
		insert_node(2, "value"),
		text_node({ " for " }),
		insert_node(3, "val"),
		text_node({ " in " }),
		insert_node(4, "items"),
		text_node({ "}", "" }),
	}),
	-- Lambda
	snippet("lam", {
		insert_node(1),
		text_node({ " = lambda " }),
		insert_node(2, "vars"),
		text_node({ ": " }),
		insert_node(3, "action"),
	}),
	-- Parser
	snippet("par", {
		text_node({ "parser = argparse.ArgumentParser()", "" }),
		text_node({ 'parser.add_argument("-' }),
		insert_node(1, "p"),
		text_node({ '", "--' }),
		insert_node(2, "param"),
		text_node({ '", default=' }),
		insert_node(3, "None"),
		text_node({ ', help="' }),
		insert_node(4, "Help text"),
		text_node({ '.")', "" }),
		insert_node(5),
		text_node({ "return parser", "" }),
	}),
	-- Add argument to the parser
	snippet("arg", {
		text_node({ 'parser.add_argument("-' }),
		insert_node(1, "p"),
		text_node({ '", "--' }),
		insert_node(2, "param"),
		text_node({ '", default=' }),
		insert_node(3, "None"),
		text_node({ ', help="' }),
		insert_node(4, "Help text"),
		text_node({ '.")', "" }),
	}),
	-- With statement using a context manager
	snippet("with", {
		text_node({ "with " }),
		insert_node(1, "ctx_manager"),
		text_node({ " as " }),
		insert_node(2, "alias"),
		text_node({ ":", "" }),
		text_node({ "\t" }),
		insert_node(3),
		text_node({ "", "" }),
	}),
	-- Mock function
	snippet("mock", {
		text_node({ "with mock.patch(", "" }),
		text_node({ "\t" }),
		insert_node(1, "module.function"),
		text_node({ ",", "" }),
		text_node({ "\treturn_value=" }),
		insert_node(2, "mocked_result"),
		text_node({ ",", "" }),
		text_node({ "):", "" }),
		text_node({ "\t" }),
		insert_node(3),
		text_node({ "", "" }),
	}),
	-- Mock dictionary
	snippet("mockd", {
		text_node({ "@mock.path.dict(", "" }),
		text_node({ "\t" }),
		insert_node(1, "os.environ"),
		text_node({ ",", "" }),
		text_node({ "\t{", "" }),
		text_node({ '\t\t"' }),
		insert_node(2, "key"),
		text_node({ '": ' }),
		insert_node(3, "val"),
		text_node({ "", "" }),
		text_node({ "\t}", "" }),
		text_node({ ")", "" }),
		insert_node(4),
	}),
	-- Parametric Pytest
	snippet("ptest", {
		text_node({ "@pytest.mark.parametrize(", "" }),
		text_node({ '\t"' }),
		insert_node(1, "input_args"),
		text_node({ ',expected",', "" }),
		text_node({ "\t[", "" }),
		text_node({ "\t\t(" }),
		insert_node(2, "case"),
		text_node({ ", " }),
		insert_node(3, "expected_result"),
		text_node({ "),", "" }),
		text_node({ "\t\tpytest.param(" }),
		function_node(copy, 2),
		text_node({ ", " }),
		function_node(copy, 3),
		text_node({ ", marks=pytest.mark.xfail()),", "" }),
		text_node({ "\t]", "" }),
		text_node({ ")", "" }),
		text_node({ "def test_" }),
		insert_node(4, "name"),
		text_node({ "(" }),
		function_node(copy, 1),
		text_node({ ", expected):", "" }),
		text_node({ '\t"""' }),
		insert_node(5, "Description"),
		text_node({ '."""', "" }),
		text_node({ "\t" }),
		insert_node(6),
		text_node({ "", "" }),
		text_node({ "\tassert(" }),
		function_node(copy, 1),
		text_node({ " == expected", "" }),
	}),
})
luasnip.add_snippets("yaml", {
	-- Avoid detached pipeline when in a MR
	snippet("nodet", {
		text_node({ ".avoid-detached-mr-pipeline: &no-detached-pipeline", "" }),
		text_node({ '  if: $CI_PIPELINE_SOURCE == "merge_request_event"', "" }),
		text_node({ "  when: never", "" }),
	}),
	-- Create a .gitlab-ci anchor
	snippet("anchor", {
		text_node({ "." }),
		insert_node(1, "name"),
		text_node({ ": &" }),
		insert_node(2, "alias"),
		text_node({ "", "" }),
		text_node({ "\t" }),
		insert_node(3),
		text_node({ "", "" }),
	}),
})

-- autotriggered snippets have to be defined in a separate table, luasnip.autosnippets.
luasnip.autosnippets = { all = { snippet("autotrigger", { text_node("autosnippet") }) } }

-- in a lua file: search lua-, then c-, then all-snippets.
luasnip.filetype_extend("lua", { "c" })
-- in a cpp file: search c-snippets, then all-snippets only (no cpp-snippets!!).
luasnip.filetype_set("cpp", { "c" })

-- You can also use lazy loading so you only get in memory snippets of languages you use
require("luasnip/loaders/from_vscode").lazy_load()
