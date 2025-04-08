
local sx = require("stringex")
local tx = require("tableex")
local ut = require("lbot_utils")

--- If using debugger, bind lua error() function to it.
-- ut.config_debug(true)

local M = {}

-----------------------------------------------------------------------------
function M.setup(pn)
    -- pn.UT_INFO("setup()!!!")
end

-----------------------------------------------------------------------------
function M.teardown(pn)
    -- pn.UT_INFO("teardown()!!!")
end

-----------------------------------------------------------------------------
function M.suite_dump_table(pn)

    -- Test dump_table().
    local tt = { aa="pt1", bb=90901, alist={ "qwerty", 777, temb1={ jj="pt8", b=true, temb2={ num=1.517, dd="strdd" } }, intx=5432}}

    local d = tx.dump_table(tt, 0)
    pn.UT_EQUAL(#d, 4)

    d = tx.dump_table(tt, 1)
    pn.UT_EQUAL(#d, 8)

    d = tx.dump_table(tt, 2)
    pn.UT_EQUAL(#d, 11)

    d = tx.dump_table(tt, 3)
    pn.UT_EQUAL(#d, 13)

    d = tx.dump_table(tt, 4)
    pn.UT_EQUAL(#d, 13)

    local s = tx.dump_table_string(tt, 0, 'doody')
    pn.UT_EQUAL(#s, 94)

    s = tx.dump_table_string(tt, 1)
    pn.UT_EQUAL(#s, 191)

    s = tx.dump_table_string(tt, 2)
    pn.UT_EQUAL(#s, 272)

    s = tx.dump_table_string(tt, 3)
    pn.UT_EQUAL(#s, 316)

    s = tx.dump_table_string(tt, 4)
    pn.UT_EQUAL(#s, 316)

    local tl = {'aaa', 'bbb', 'ccc', 'ddd', 'eee'}
    s = tx.dump_list(tl)
    print(s)
    pn.UT_EQUAL(#s, 19)

end

-----------------------------------------------------------------------------
function M.suite_validation(pn)

    local res

    -- OK
    res = ut.val_number(13.4, 13.3, 13.5)
    pn.UT_TRUE(res)

    res = ut.val_number(13.4)
    pn.UT_TRUE(res)

    -- Wrong type
    res = ut.val_number('13.4', 13.3, 13.5)
    pn.UT_FALSE(res)

    -- Below
    res = ut.val_number(13.2, 13.3, 13.5)
    pn.UT_FALSE(res)

    -- Above
    res = ut.val_number(13.6, 13.9, 13.5)
    pn.UT_FALSE(res)


    -- OK
    res = ut.val_integer(271, 270, 272)
    pn.UT_TRUE(res)

    res = ut.val_integer(271)
    pn.UT_TRUE(res)

    -- Wrong type
    res = ut.val_integer(13.4, 13.3, 13.5)
    pn.UT_FALSE(res)

    -- Below
    res = ut.val_integer(269, 270, 272)
    pn.UT_FALSE(res)

    -- Above
    res = ut.val_integer(273, 270, 272)
    pn.UT_FALSE(res)

end

-----------------------------------------------------------------------------
function M.suite_types(pn)

    -- Valid array with homogenous values.
    local t1 = { "pt1", "pt2", "pt3", "pt4" }
    -- dbg()
    local ok, val_type = ut.is_array(t1)
    pn.UT_TRUE(ok)
    pn.UT_EQUAL(val_type, 'string')

    -- Valid array with non-homogenous values.
    local t2 = { "pt1", 111, "pt3", "pt4" }
    ok, val_type = ut.is_array(t2)
    pn.UT_TRUE(ok)
    pn.UT_EQUAL(val_type, nil)

    -- Invalid array - not sequential.
    local t3 = { [1]="pt1"; [3]="pt2"; [9]="pt3"; "pt4" }
    ok, val_type = ut.is_array(t3)
    pn.UT_FALSE(ok)
    pn.UT_EQUAL(val_type, nil)

end

-----------------------------------------------------------------------------
-- Return the module.
return M
