
local sx = require("stringex")
local tx = require("tableex")
local ut = require("lbot_utils")


local M = {}


-----------------------------------------------------------------------------
function M.setup(pn)
    -- pn.UT_INFO("setup()!!!")
end

-----------------------------------------------------------------------------
function M.teardown(pn)
    -- pn.UT_INFO("teardown()!!!")
end


------------------------------ System ---------------------------------------
function M.suite_system(pn)

    -- TODOL test these:
    -- ut.check_globals(app_glob)
    -- ut.fix_lua_path(s)
    -- ut.execute_and_capture(cmd)
    -- ut.get_caller_info(level)
end


------------------------- Types ---------------------------------------------
function M.suite_types(pn)

    -- TODOL test these:
    -- ut.is_integer(x)
    -- ut.tointeger(v)
    -- ut.is_callable(obj)
    -- ut.is_indexable(obj)
    -- ut.is_iterable(obj)
    -- ut.is_writeable(obj)
    -- ut.val_type(v, vt)
    -- ut.val_table(t, min_size)
    -- ut.val_not_nil(v)
    -- ut.val_func(func)


    local res
    
    -- OK
    res = pcall(ut.val_number, 13.4, 13.3, 13.5)
    pn.UT_TRUE(res)

    res = pcall(ut.val_number, 13.4)
    pn.UT_TRUE(res)

    -- Wrong type
    res = pcall(ut.val_number, '13.4', 13.3, 13.5)
    pn.UT_FALSE(res)

    -- Below
    res = pcall(ut.val_number, 13.2, 13.3, 13.5)
    pn.UT_FALSE(res)

    -- Above
    res = pcall(ut.val_number, 13.6, 13.9, 13.5)
    pn.UT_FALSE(res)


    -- OK
    res = pcall(ut.val_integer, 271, 270, 272)
    pn.UT_TRUE(res)

    res = pcall(ut.val_integer, 271)
    pn.UT_TRUE(res)

    -- Wrong type
    res = pcall(ut.val_integer, 13.4, 13.3, 13.5)
    pn.UT_FALSE(res)

    -- Below
    res = pcall(ut.val_integer, 269, 270, 272)
    pn.UT_FALSE(res)

    -- Above
    res = pcall(ut.val_integer, 273, 270, 272)
    pn.UT_FALSE(res)

end

--[[
TODOL these tests

------------------------- Math ----------------------------------------------
function M.suite_math(pn)
    ut.map(val, start1, stop1, start2, stop2)
    ut.constrain(val, min, max)
    ut.clamp(val, granularity, round)
end


------------------------------ Files ----------------------------------------
function M.suite_files(pn)
    ut.file_read_all(fn)
    ut.file_write_all(fn, s)
    ut.file_append_all(fn, s)
end


------------------------------ Odds and Ends --------------------------------
function M.suite_misc(pn)
    ut.ternary(cond, tval, fval)
    ut.colorize_text(text)
    ut.set_colorize(map)
end

]]

-----------------------------------------------------------------------------
-- Return the module.
return M
