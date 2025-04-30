
local ut = require("lbot_utils")
local lt = require("lbot_types")
local sx = require("stringex")
local tx = require('tableex')

local dbg = require("debugex")

-- Reference. Needs env TERM=1.
-- local dbg = require("debugger")

local counter = 100


--- Replacement for print(...) with file and line added. from lbot
function printex(...)
    local res = {}
    local arg = {...}
    local fpath = debug.getinfo(2, 'S').short_src
    local line = debug.getinfo(2, 'l').currentline
    table.insert(res, fpath..'('..line..')')
    for _, v in ipairs(arg) do
        table.insert(res, '['..tostring(v)..']')
    end

    print(sx.strjoin(' ', res))
end


-----------------------------------------------------------------------------
local function log_error(msg) printex('ERR', msg) end
local function log_info(msg)  printex('INF', msg) end
local function log_trace(msg) printex('TRC', msg) end


log_info('Loading debug_test.lua')


-----------------------------------------------------------------------------
local function setup()
    log_info('setup() was called')
    -- log_info'aaa'
    return 3
end


-----------------------------------------------------------------------------
--- Global function for App interaction with script internals.
-- @param cmd specific command string
-- @param arg optional argument int
-- @return result string (table would be nice later)
local function do_command(cmd, arg)

-- dbg()

    log_info('Got this command: '..cmd..'('..arg..')')
    local ret = 'counter='..counter
    counter = counter + 1

    return ret
end

-----------------------------------------------------------------------------
local function boom()
    log_info('boom() was called')
    return 'boom() was called'..nil
end

-- Error message handler that can be used with lua_pcall().
local msgh = function(...)
    local arg = {...}
    print('>>> arg', tx.dump_table(arg))
    print('>>> traceback', debug.traceback())
    dbg(false, 1, "msgh")

    return ...
end

-- Works like pcall(), but invokes the debugger on an error.
local function run_debug(f, ...)
    -- local arg = {...}
    -- print('>>>0', tx.dump_table(arg))
    -- print(debug.traceback())

    -- local ok, msg = pcall(f, ...)
    -- print('!!!', ok, msg)

    local ok, msg = xpcall(f, msgh, ...)
    print('!!!', ok, msg, f)
end


-----------------------------------------------------------------------------
-- fake script here:

setup()

local ok, msg = xpcall(do_command, msgh2, 'xxx', 'how')
print('!!! do_command', ok, msg)
-- !!! do_command  true    counter=100     nil
-- run_debug(do_command('xxx', 'how'))


ok, msg = xpcall(boom, msgh2)
print('!!! boom', ok, msg)
-- !!! boom        false   test_debugex.lua:66: attempt to concatenate a nil value
-- >>> arg anonymous(table):
--     1(string)[test_debugex.lua:66: attempt to concatenate a nil value]
-- >>> traceback   stack traceback:
--         test_debugex.lua:83: in metamethod 'concat'
--         test_debugex.lua:66: in function <test_debugex.lua:64>
--         [C]: in function 'xpcall'
--         test_debugex.lua:150: in main chunk
--         [C]: in ?
--   ind:1 file:test_debugex.lua line:90
 



