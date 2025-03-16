# LbotImpl

Tests and examples for [LuaBagOfTricks](https://github.com/cepthomas/LuaBagOfTricks.git) repo.

## Interop

Contains several flavors of how to embed Lua scripting in host languages:
- C: Bog standard using Lua C API.
- CppCli: Creates a .NET assembly for consumption by host.
- Csh: Call directly using [KeraLuaEx](https://github.com/cepthomas/KeraLuaEx.git) which exposes the Lua C API as .NET native methods.

Uses submodule [LuaBagOfTricks](https://github.com/cepthomas/LuaBagOfTricks.git). TODO1 like C:\Dev\Apps\Nebulua\docs\tech_notes.md

It's mostly a Windows project but parts would probably work elsewhere.

## Code Generation

What makes this interesting is that all the interop code is generated using some Lua template magic.

Generates C# and/or C code using `gen_interop.lua`, `interop_<flavor.lua>`, and a custom `interop_spec.lua`
file that describes the bidirectional api you need for your application.


```lua
C
M.config =
{
    lua_lib_name = "luainterop",    -- for require
}

CppCli
M.config =
{
    lua_lib_name = "luainterop",    -- for require
    host_lib_name = "HostInterop",  -- host filenames  => class_name
    host_namespace = "Interop"      -- host namespace
}
>>>
M.config =
{
    lua_lib_name = "luainterop",    -- for require
    class_name = "HostInterop",  -- host filenames  => class_name
    namespace = "CppCli"      -- host namespace
    add_refs = { "doodaa.h", },   -- for #include (optional)
}

Csh
M.config =
{
    lua_lib_name = "luainterop",            -- for require
    host_lib_name = "Interop",              -- host filenames
    host_namespace = "Interop",             -- host namespace
    add_refs = { "System.Diagnostics", },   -- for using (optional)
}
>>>
{
    lua_lib_name = "luainterop",            -- for require, also filename
    file_name = "Interop",              -- host filename
    namespace = "Csh",             -- host namespace
    class_name = "App",             -- host classname
    add_refs = { "System.Diagnostics", },   -- for using (optional)
}


```






`interop_spec.lua` is a plain Lua data file. It has two sections:
`M.config` specifies some names to be used for artifacts.

```lua
M.config =
{
    lua_lib_name = "luainterop",    -- for lua require statement, also generated filename
    namespace = "Csh",              -- .NET namespace (CppCli and Csh only)
    class_name = "App",             -- .NET class name (CppCli and Csh only)
    file_name = "Interop",          -- .NET file name (Csh only)
    add_refs = { "System.Xyz", },   -- (optional) using (Csh only)
    add_refs = { "my_stuff.h", },     -- (optional) #include (CppCli only)
}
```

The second section specifies the script functions the application can call, and vice versa:
```lua
------------------------ Host => Script ------------------------
M.script_funcs =
{
    {
        lua_func_name = "my_lua_func",
        host_func_name = "MyLuaFunc",
        required = "true",
        description = "Tell me something good.",
        args =
        {
            { name = "arg_one", type = "S", description = "some strings" },
            { name = "arg_two", type = "I", description = "a nice integer" },
        },
        ret = { type = "T", description = "a returned thing" }
    },
}

------------------------ Script => Host ------------------------
M.host_funcs =
{
    {
        lua_func_name = "log",
        host_func_name = "Log",
        description = "Script wants to log something.",
        args =
        {
            { name = "level", type = "I", description = "Log level" },
            { name = "msg", type = "S", description = "Log message" },
        },
        ret = { type = "I", description = "Unused" }
    },
}
```

This is turned into the flavors of interop code using something a command like:
```
lua gen_interop.lua -csh input_dir\interop_spec.lua output_dir
```

Currently the supported data types are limited to boolean, integer, number, string.
The Csh flavor has an experimental table implementation.

The intended way to use this is to copy one of the flavors directly, modify the spec file, run the code generator,
modify the host file(s), build the application in VS.
I could have gotten fancier with the code/app generation but this seems more than adequate for something that
will have minimal changes after settling down.

## The Flavors

Each flavor has these elements:
- interop_spec.lua - defines your api
- gen_interop.cmd - typical code generation script
- script_xxx.lua - test/example scripts

These may also appear:
- err_dcode.lua - may be useful for debugging spec file errors
- log.txt - per the application

### C

- C.sln/vcxproj - VS solution
- app.cpp - main application and callbacks
- luainterop.c/h - generated C <=> Lua interop code

### C++/CLI

This also requires the C generated code.

- CppCli.sln, CppCli.csproj, Interop.vcxproj - VS solution
- App.cs - main application and events
- Interop.cpp/h - generated C# <=> C interop code
- luainterop.c/h - generated C <=> Lua interop code

### C#   

- Csh.sln/csproj - VS solution
- App.cs - main application and events
- Interop.cs - generated C# <=> KeraLuaEx interop code


## test_lua

Some unit tests for LBOT components.
