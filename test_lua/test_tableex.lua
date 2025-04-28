-- Unit tests for Tableex.lua.

local ut = require("lbot_utils")
local tx = require("tableex")
local sx = require("stringex")

local M = {}


-- -----------------------------------------------------------------------------
-- function M.setup(pn)
-- end

-- -----------------------------------------------------------------------------
-- function M.teardown(pn)
-- end

local tt =
{
    aa="pt1",
    bb=90901,
    alist=
    {
        "qwerty",
        777,
        temb1=
        {
            jj="pt8",
            b=true,
            temb2=
            {
                num=1.517,
                dd="strdd"
            }
        },
        intx=5432
    },
    cc=function() end,
    [101]='booga'
}


-----------------------------------------------------------------------------
function M.suite_success(pn)

    -- basic functions
    pn.UT_EQUAL(tx.table_count(tt), 5)
    pn.UT_EQUAL(tx.table_count(tt.alist), 4)

    -- dump_table()
    local s = tx.dump_table(tt)
    pn.UT_EQUAL(#s, 141)

    local s = tx.dump_table(tt, 0, 'depth0')
    pn.UT_EQUAL(#s, 141)

    s = tx.dump_table(tt, 1)
    pn.UT_EQUAL(#s, 239)

    s = tx.dump_table(tt, 2, 'depth0')
    pn.UT_EQUAL(#s, 322)

    s = tx.dump_table(tt, 3)
    pn.UT_EQUAL(#s, 392)

    s = tx.dump_table(tt, 4, 'depth4')
    pn.UT_EQUAL(#s, 392)

    -- misc functions
    pn.UT_TRUE(tx.contains_value(tt, 'booga'))
    pn.UT_FALSE(tx.contains_value(tt, 'ack'))

    local tc = tx.copy(tt) -- shallow
    pn.UT_EQUAL(tx.table_count(tc), 5)
    s = tx.dump_table(tc)
    pn.UT_EQUAL(#s, 141)

    tc = tx.deep_copy(tt)
    s = tx.dump_table(tc)
    -- TODOL fails, makes shallow copy.
    -- pn.UT_EQUAL(#s, 392)

    -- sequence-like tables
    local tl = {'aaa', 'bbb', 'ccc', 'ddd', 'eee'}
    s = tx.dump_list(tl)
    pn.UT_EQUAL(s, 'aaa,bbb,ccc,ddd,eee')

end


-----------------------------------------------------------------------------
-- Return the module.
return M
