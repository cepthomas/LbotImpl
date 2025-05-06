
-- local ut = require("lbot_utils")
-- local lt = require("lbot_types")
-- local sx = require("stringex")
-- local tx = require('tableex')


local dbg = require("debugex")

local counter = 100



dbg.print('Loading test_debugex.lua')


-----------------------------------------------------------------------------
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
    local my_table =
    {
        aa="str-pt1",
        mt={},
        bb=90901,
        alist=
        {
            "str-qwerty",
            777.888,
            temb1=
            {
                jj="str-pt8",
                b=true,
                temb2=
                {
                    num=1.517,
                    dd="string-dd"
                }
            },
            intx=5432,
            nada=nil
        },
        cc=function() end,
        [101]='booga'
    }

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

-- Plain function.
local ok, msg = do_command('touch', 'nose')
dbg.print(string.format('do_command(): %q %s', ok, msg))

-- Function that error().
ok, msg = dbg.pcall(boom, 'green')
dbg.print(string.format('boom(green): %q %s', ok, msg))

-- local ok, msg = dbg.pcall(boom, 'green')
-- if not ok then
--     dbg.print('*** err:', msg)
-- end
