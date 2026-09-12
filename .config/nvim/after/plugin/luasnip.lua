local ls = require("luasnip")
ls.config.set_config({ -- Setting LuaSnip config

  -- Enable autotriggered snippets
  enable_autosnippets = true,

  -- Use Tab (or some other key if you prefer) to trigger visual selection
  store_selection_keys = "<Tab>",
})

ls.add_snippets("cs", {
    ls.snippet({trig = "///", snippetType = "autosnippet" }, {
        ls.text_node({
            "/// <summary>",
            "/// "
        }),
        ls.insert_node(1),
        ls.text_node({
            "",
            "/// </summary>"
        }),
    }),
})
