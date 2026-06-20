-- ~/.config/nvim/luasnippets/cmake.lua
local ls = require 'luasnip'
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmt = require('luasnip.extras.fmt').fmt

return {
  -- Full CMakeLists.txt template
  s(
    'template',
    fmt(
      [[
cmake_minimum_required(VERSION {ver})
project({name} {lang})

set(CMAKE_{LANG}_STANDARD {std})
set(CMAKE_{LANG}_STANDARD_REQUIRED ON)

# gode compiler-flags til udvikling
add_compile_options(-Wall -Wextra -Wpedantic -O0 -g)

add_executable({target}
  {src}
)

target_include_directories({target} PRIVATE ${{CMAKE_SOURCE_DIR}}/include)
]],
      {
        ver = i(1, '3.16'),
        name = i(2, 'test'),
        lang = i(3, 'C'), -- "C" eller "CXX"
        LANG = f(function(args)
          return (args[1][1] or 'C'):upper()
        end, { 3 }),
        std = i(4, '11'), -- fx 11 (C) eller 20 (CXX)
        target = i(5, 'test'),
        src = i(6, 'src/main.c'),
      }
    )
  ),

  -- Quick add_executable snippet
  s(
    'addexe',
    fmt(
      [[
add_executable({target}
  {srcs}
)
]],
      {
        target = i(1, 'app'),
        srcs = i(2, 'src/main.c'),
      }
    )
  ),
}
