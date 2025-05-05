
local ut = require("lbot_utils")
local lt = require("lbot_types")
local sx = require("stringex")
local tx = require('tableex')


local dbg = require("debugex")

local counter = 100

dbg.print('Loading test_debugex.lua')


-----------------------------------------------------------------------------
-- fake script here:


-----------------------------------------------------------------------------
--- Global function for App interaction with script internals.
-- @param cmd specific command string
-- @param arg optional argument int
-- @return result string (table would be nice later)
local function do_command(cmd, arg)
    dbg.print('Got this command: '..cmd..'('..arg..')')
    local ret = 'counter => '..counter
    -- dbg()
    -- dbg.bp()
    counter = counter + 1
    return ret
end


-----------------------------------------------------------------------------
local function nest2(some_arg)
    dbg.print('nest2() was called: '..some_arg)
    return 'boom'..nil
end

-----------------------------------------------------------------------------
local function nest1(some_arg)
    dbg.print('nest1() was called: '..some_arg)
    dbg()
    nest2(some_arg..'1')
end

-----------------------------------------------------------------------------
local function boom(some_arg)
    dbg.print('boom() was called: '..some_arg)
    -- dbg.bp()
    nest1(some_arg..'0')
end

--------------- Start here --------------------------------------------------

print('do_command():', do_command('touch', 'nose'))

-- print('boom(orange):', boom('orange'))

print('boom(green):', dbg.pcall(boom, 'green')) -- TODOD so func/line doess not get update after this is called.

-- local ok, msg = dbg.pcall(boom, 'green')
-- if not ok then
--     dbg.print('*** err:', msg)
-- end
