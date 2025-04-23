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


-----------------------------------------------------------------------------
function M.suite_happy_path(pn)

    -- Test dump_table()
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

    pn.UT_EQUAL(tx.table_count(tt), 5)
    pn.UT_EQUAL(tx.table_count(tt.alist), 4)

    local d = tx.dump_table(tt)
    pn.UT_EQUAL(#d, 141)

    local d = tx.dump_table(tt, 0, 'depth0')
    pn.UT_EQUAL(#d, 141)

    d = tx.dump_table(tt, 1)
    pn.UT_EQUAL(#d, 239)

    d = tx.dump_table(tt, 2, 'depth0')
    pn.UT_EQUAL(#d, 322)

    d = tx.dump_table(tt, 3)
    pn.UT_EQUAL(#d, 392)

    d = tx.dump_table(tt, 4, 'depth4')
    pn.UT_EQUAL(#d, 392)



    -- list-like tables
    local tl = {'aaa', 'bbb', 'ccc', 'ddd', 'eee'}
    d = tx.dump_list(tl)
    pn.UT_EQUAL(d, 'aaa,bbb,ccc,ddd,eee')


    -- TODOL these tests:
    -- function M.contains_value(tbl, val)
    -- function M.copy(tbl)  Shallow
    -- function M.deep_copy(t)
    -- function M.table_add(tbl, key, val)
    -- function M.table_count(tbl)


    -- local t2 =
    -- {
    --     color='blue',
    --     something={name='bazoo', count=55},
    -- }
    -- t1:add_range(t2)
    -- pn.UT_EQUAL(t1:count(), 5)
    -- pn.UT_EQUAL(t1:contains_value('bb'), 90901)
    -- pn.UT_EQUAL(t1:contains_value('color'), 'blue')
    -- pn.UT_NIL(t1:contains_value('nada'))
    -- local t3 = t1:copy(t1.something)
    -- pn.UT_EQUAL(t3:count(), 55)
    -- t1:clear()
    -- pn.UT_EQUAL(t1:count(), 0)

end

-----------------------------------------------------------------------------
function M.suite_sad_path(pn) -- TODOL

    -- -- Init from table.
    -- local t1 = Tableex:create({ aa="pt1", bb=90901, alist={ "qwerty", 777, temb1={ jj="pt8", b=true, temb2={ num=1.517, dd="strdd" } }, intx=5432}}, 'green bunny')
    -- pn.UT_EQUAL(t1:count(), 4)

    -- local ok, msg = pcall(t1.add, 123)
    -- pn.UT_FALSE(ok)
    -- pn.UT_STR_CONTAINS(msg, 'Values not homogenous')

    -- ok, msg = pcall(t1.remove_at, t1, 55)
    -- pn.UT_FALSE(ok)
    -- pn.UT_STR_CONTAINS(msg, 'Invalid integer:55')

    -- -- Init from nothing.
    -- local l2 = Tableex:create()
    -- pn.UT_EQUAL(l2:count(), 0)

    -- ok, msg = pcall(l2.add, l2, true)
    -- pn.UT_TRUE(ok)
    -- pn.UT_EQUAL(l2:count(), 1)

    -- ok, msg = pcall(l2.add, l2, {})
    -- pn.UT_FALSE(ok)
    -- pn.UT_STR_CONTAINS(msg, 'Values not homogenous')

end

-----------------------------------------------------------------------------
-- Return the module.
return M
