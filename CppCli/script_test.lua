
-- Use the debugger. For color output set env var 'TERM' and provide a dbg() statement.
-- Not that the project must be set to `<OutputType>Exe</OutputType>` even if using WinForms.
local dbg = require("debugger")

local li  = require("luainterop")

local counter = 100


-----------------------------------------------------------------------------
--- Log functions. This goes straight through to the host.
-- Magic numbers must match host code.
-- @param msg what to log
local function log_error(msg) li.log(4, msg) end
local function log_warn(msg)  li.log(3, msg) end
local function log_info(msg)  li.log(2, msg) end
local function log_debug(msg) li.log(1, msg) end
local function log_trace(msg) li.log(0, msg) end

log_info('Loading test.lua')

-- Test event.
li.notif(33, "Notification XYZ")


-----------------------------------------------------------------------------
function setup()
    log_info('setup() was called')
    -- log_info'aaa'
    return 3
end


-----------------------------------------------------------------------------
--- Global function for App interaction with script internals.
-- @param cmd specific command string
-- @param arg optional argument int
-- @return result string (table would be nice later)
function do_command(cmd, arg)
    dbg()

    log_info('Got this command: '..cmd..'('..arg..')')
    local ret = 'counter='..counter
    counter = counter + 1

    return ret
end
