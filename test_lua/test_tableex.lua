
local ut = require("lbot_utils")
local tx = require("tableex")
local sx = require("stringex")


local M = {}


-----------------------------------------------------------------------------
function M.setup(pn)
    -- print("setup()!!!")
end

-----------------------------------------------------------------------------
function M.teardown(pn)
    -- print("teardown()!!!")
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
    -- print(s)
    pn.UT_EQUAL(#s, 19)

end

-----------------------------------------------------------------------------
-- Return the module.
return M
