
local ut = require("lbot_utils")
local lt = require("lbot_types")
local sx = require("stringex")
local tx = require('tableex')

local dbg = require("debugger2")

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
    log_info('boom() was called'..nil)
end


local msgh = function(...)
    local arg = {...}
    print('>>>1', tx.dump_table(arg))
    print('>>>2', debug.traceback())

    dbg(false, 1, "msgh")
    return ...
end
-- debug_test.lua(29) [INF] [Loading debug_test.lua]
-- debug_test.lua(29) [INF] [setup() was called]
-- debug_test.lua(29) [INF] [Got this command: xxx(how)]
-- >>>0    noname(table):
--         EMPTY
-- stack traceback:
--         debug_test.lua:146: in local 'run_debug'
--         debug_test.lua:161: in main chunk
--         [C]: in ?
-- >>>1    noname(table):
--     1(string)[attempt to call a string value]
-- >>>2    stack traceback:
--         debug_test.lua:93: in function <debug_test.lua:90>
--         [C]: in function 'xpcall'
--         debug_test.lua:147: in local 'run_debug'
--         debug_test.lua:161: in main chunk
--         [C]: in ?
-- break via msgh => debug_test.lua:147 in local 'run_debug'
-- debugger.lua>




-- Error message handler that can be used with lua_pcall().
local msgh2 = function(...)
    local arg = {...}
    print('>>>1', tx.dump_table(arg))
    print('>>>2', debug.traceback())

    if debug.getinfo(2) then
        print("ERROR: "..dbg.pretty(...))
        dbg(false, 1, "msgh2")
    else
        print("Error did not occur in Lua code. Execution will continue after dbg_pcall().")
    end

    return ...
end
-- debug_test.lua(29) [INF] [Loading debug_test.lua]
-- debug_test.lua(29) [INF] [setup() was called]
-- debug_test.lua(29) [INF] [Got this command: xxx(how)]
-- >>>0    noname(table):
--         EMPTY
-- stack traceback:
--         debug_test.lua:153: in local 'run_debug'
--         debug_test.lua:168: in main chunk
--         [C]: in ?
-- >>>1    noname(table):
--     1(string)[attempt to call a string value]
-- >>>2    stack traceback:
--         debug_test.lua:124: in function <debug_test.lua:121>
--         [C]: in function 'xpcall'
--         debug_test.lua:154: in local 'run_debug'
--         debug_test.lua:168: in main chunk
--         [C]: in ?
-- ERROR: "attempt to call a string value"
-- break via msgh2 => debug_test.lua:154 in local 'run_debug'
-- debugger.lua>




-- Works like pcall(), but invokes the debugger on an error.
local function run_debug(f, ...)
    local arg = {...}
    print('>>>0', tx.dump_table(arg))
    print(debug.traceback())
    return xpcall(f, msgh2, ...)
end


-----------------------------------------------------------------------------

-- print(tx.dump_table(_G))
-- local err = _G.error
-- _G.error = dbg.error
-- print(_G.error, err)
-- _G.error = function(...) print'!!!!' end

setup()

run_debug(do_command('xxx', 'how'))



boom()



--[[ py tracer
@trfunc
def a_test_function(a1: int, a2: float):
    '''Entry/exit is traced with args and return value.'''
    cl1 = TracerExample('number 1', [45, 78, 23], a1)
    cl2 = TracerExample('number 2', [100, 101, 102], a2)
    T(cl1)
    T(cl2)
    ret = f'answer is cl1:{cl1.do_something(a1)}...cl2:{cl2.do_something(a2)}'

    ret = f'{cl1.do_class_assert(a1)}'

    ret = f'{cl1.do_class_exception(a2)}'
    return ret

    '''Assert processing.'''
    i = 10
    j = 10

    A(i == j)  # ok - no trace
    i += 1
    A(i == j)  # assert

@trfunc
def do_a_suite(alpha, number):
    '''Make a nice suite with entry/exit and return value.'''
    T('something sweet')

    ret = a_test_function(5, 9.126)

    test_exception_function()

    test_assert_function()

    no_trfunc_function('can you see me?')
    ret = another_test_function([33, 'tyu', 3.56], {'aaa': 111, 'bbb': 222, 'ccc': 333})
    return ret
]]
