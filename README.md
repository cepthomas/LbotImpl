# LuaBagOfTricks Implementation

Tests and examples for [LuaBagOfTricks](https://github.com/cepthomas/LuaBagOfTricks.git).

## Interop 
Building and running interop requires access to LuaBagOfTricks in a folder named `LBOT` at the top level
of the repo. You can add it is a submodule, plain copy, or symlink as preferred.

`mklink /d some_path\NTerm\Script\LBOT other_path\LuaBagOfTricks'.

The intended way to use this is to simply copy one of the flavors directly, modify the spec file, run the code generator,
modify the host file(s), build the application in VS.

Each example has these elements:
- interop_spec.lua - defines your api
- gen_interop.cmd - typical code generation script
- script_xxx.lua - test/example scripts

These gen/build artifacts may also appear:
- err_dcode.lua - may be useful for debugging spec file errors
- log.txt - per the application

C flavor:
- C.sln/vcxproj - VS solution
- app.cpp - main application and callbacks
- luainterop.c/h - generated C <=> Lua interop code

C++/CLI flavor (also requires the C flavor):
- CppCli.sln, CppCli.csproj, Interop\Interop.vcxproj - VS solution
- App.cs - main application and events
- Interop\Interop.cpp/h - generated C# <=> C interop code
- Interop\luainterop.c/h - generated C <=> Lua interop code

C# flavor:
- Csh.sln/csproj - VS solution
- App.cs - main application and events
- Interop.cs - generated C# <=> KeraLuaEx interop code

The C++/CLI flavor also demonstrates how to use the debugger - see `script_test.lua`.

## test_lua

Some unit tests for LBOT Lua components.
