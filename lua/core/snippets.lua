-- ~/.config/nvim/snippets/cpp_benchmark.lua
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

ls.add_snippets("cpp", {
	s(
		"benchn",
		fmt(
			[[
    {{
      const int N = {};
      double total_time = 0.0;
      for (int i = 0; i < N; ++i) {{
        auto start = std::chrono::high_resolution_clock::now();
        {}
        auto end = std::chrono::high_resolution_clock::now();
        std::chrono::duration<double> elapsed = end - start;
        total_time += elapsed.count();
      }}
      std::cout << "{} avg time over " << N << " runs: "
                << (total_time / N) << " seconds." << "\n";
    }}
  ]],
			{
				i(1, "10"), -- 运行次数
				i(2, "function_to_test();"), -- 被测函数
				i(3, "function_to_test"), -- 函数名字符串
			}
		)
	),
})
