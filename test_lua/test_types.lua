
local sx = require("stringex")
local tx = require("tableex")
local ut = require("lbot_utils")
local lt = require("lbot_types")


local M = {}

-- TODOL tests for these.

-----------------------------------------------------------------------------
function M.setup(pn)
    -- pn.UT_INFO("setup()!!!")
end

-----------------------------------------------------------------------------
function M.teardown(pn)
    -- pn.UT_INFO("teardown()!!!")
end


-----------------------------------------------------------------------------
function M.suite_basic_types(pn)

    -- lt.is_integer(x)
    -- lt.is_callable(obj)
    -- lt.is_indexable(obj)
    -- lt.is_iterable(obj)
    -- lt.is_writeable(obj)
    -- ut.tointeger(v)
end


-----------------------------------------------------------------------------
function M.suite_validators(pn)

    -- lt.val_type(v, vt)
    -- lt.val_table(t, min_size)
    -- lt.val_not_nil(v)
    -- lt.val_func(func)


    local res

    ----- val_number
    res = pcall(lt.val_number, 13.4, 13.3, 13.5)
    pn.UT_TRUE(res)

    res = pcall(lt.val_number, 13.4)
    pn.UT_TRUE(res)

    -- Wrong type
    res = pcall(lt.val_number, '13.4', 13.3, 13.5)
    pn.UT_FALSE(res)

    -- Below
    res = pcall(lt.val_number, 13.2, 13.3, 13.5)
    pn.UT_FALSE(res)

    -- Above
    res = pcall(lt.val_number, 13.6, 13.9, 13.5)
    pn.UT_FALSE(res)


    ----- val_integer
    res = pcall(lt.val_integer, 271, 270, 272)
    pn.UT_TRUE(res)

    res = pcall(lt.val_integer, 271)
    pn.UT_TRUE(res)

    -- Wrong type
    res = pcall(lt.val_integer, 13.4, 13.3, 13.5)
    pn.UT_FALSE(res)

    -- Below
    res = pcall(lt.val_integer, 269, 270, 272)
    pn.UT_FALSE(res)

    -- Above
    res = pcall(lt.val_integer, 273, 270, 272)
    pn.UT_FALSE(res)

end


-----------------------------------------------------------------------------
-- Return the module.
return M
