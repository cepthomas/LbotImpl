
local ut = require("lbot_utils")
local lt = require("lbot_types")
local sx = require("stringex")
local tx = require('tableex')

local dbg = require("debugex")

-- Reference/original app. Needs env TERM=1.
-- local dbg = require("debugger")

local counter = 100



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
    local ret = 'counter => '..counter
    counter = counter + 1
    return ret
end



-----------------------------------------------------------------------------
local function nest2(some_arg)
    log_info('nest2() was called: '..some_arg)
    return 'boom'..nil
end

local function nest1(some_arg)
    log_info('nest1() was called: '..some_arg)
    nest2(some_arg..'1')
end

local function boom(some_arg)
    log_info('boom() was called: '..some_arg)
    nest1(some_arg..'0')
end


-- -- Works like pcall(), but invokes the debugger on an error.
-- local function run_debug_X(f, ...)
--     -- local arg = {...}
--     -- print('>>>0', tx.dump_table(arg))
--     -- print(debug.traceback())

--     -- local ok, msg = pcall(f, ...)
--     -- print('!!!', ok, msg)

--     local ok, msg = xpcall(f, msgh_X, ...)

-- -- after c(ontinue):

--     local tr = sx.strsplit(_trace, '\n')
--     table.remove(tr, 1)

--     print('!!! run_debug', ok, msg, f)
--     print('!!! ', tx.dump_table(tr, 'run_debug'))
-- end


-- dbg(condition, top_offset, source)
-- dbg(false, level, 'dbg.error()')


-- -- Works like pcall(), but invokes the debugger on an error.
-- local function run_debug(f, ...)

--     -- msg like: test_debugex.lua:68: attempt to concatenate a nil value
--     local ok, msg = xpcall(f,
--         function(...)
--             -- print('### err:', ...)
--             -- print('### msgh traceback', debug.traceback())
--             -- Save the trace.
--             _trace = debug.traceback()
--             -- Start debugger.
--             dbg.run(false, 1, "msgh")
--             -- dbg(false, 1, "msgh")
--             return ...
--         end,
--         ...)

--     if not ok then
--         local tr = sx.strsplit(_trace, '\n')
--         table.remove(tr, 1)

--         print('!!! run_debug', ok, msg, f)
--         print('!!! ', tx.dump_table(tr, 'run_debug'))
--     end
-- end


-----------------------------------------------------------------------------
-- fake script here:

setup()

local ok, msg = dbg.pdebug(boom, 'green')
if not ok then
    print('*** err:', msg)
end



-- '<return> re-run last command',
-- 'c(ontinue) continue execution',
-- 's(tep) step forward by one line (into functions)',
-- 'n(ext) step forward by one line (skipping over functions)',
-- 'f(inish) step forward until exiting the current function',
-- 'u(p) move up the stack by one frame',
-- 'd(own) move down the stack by one frame',
-- 'i(nspect) [index] move to a specific stack frame',
-- 'w(here) [line count] print source code around the current line',
-- 'e(val) [statement] execute the statement',
-- 'p(rint) [expression] execute the expression and print the result',
-- 't(race) print the stack trace',
-- 'l(ocals) print the function arguments, locals and upvalues.',
-- 'h(elp) print this message',
-- 'q(uit) halt execution'
