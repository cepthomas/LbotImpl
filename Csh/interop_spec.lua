-- Specifies the generated interop code.


local M = {}

M.config =
-- {
--     lua_lib_name = "luainterop",            -- for require
--     host_lib_name = "Interop",              -- host filenames
--     host_namespace = "Csh",                 -- host namespace
--     add_refs = { "System.Diagnostics", },   -- for using (optional)
-- }
{
    lua_lib_name = "luainterop",            -- for require, also filename
    file_name = "Interop",              -- host filename
    namespace = "Csh",             -- host namespace
    class_name = "App",             -- host classname
    add_refs = { "System.Diagnostics", },   -- for using (optional)
}

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
            {
                name = "arg_one",
                type = "S",
                description = "some strings"
            },
            {
                name = "arg_two",
                type = "I",
                description = "a nice integer"
            },
            {
                name = "arg_three",
                type = "T",
            },
        },
        ret =
        {
            type = "T",
            description = "a returned thing"
        }
    },

    {
        lua_func_name = "my_lua_func2",
        host_func_name = "MyLuaFunc2",
        required = "true",
        description = "wooga wooga",
        args =
        {
            {
                name = "arg_one",
                type = "B",
                description = "aaa bbb ccc"
            },
        },
         ret =
        {
            type = "N",
            description = "a returned number"
        }
    },

    {
        lua_func_name = "no_args_func",
        host_func_name = "NoArgsFunc",
        required = "true",
        description = "no_args",
        ret =
        {
            type = "N",
            description = "a returned number"
        },
    },

    {
        lua_func_name = "optional_func",
        host_func_name = "OptionalFunc",
        required = "false",
        description = "Function is optional.",
        ret =
        {
            type = "I",
            description = "Dummy return value."
        }
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

    {
        lua_func_name = "get_time",
        host_func_name = "GetTime",
        description = "What time is it",
        args =
        {
            {
                name = "tzone",
                type = "I",
                description = "Time zone"
            },
        },
        ret =
        {
            type = "S",
            description = "The time"
        }
    },
}

return M
