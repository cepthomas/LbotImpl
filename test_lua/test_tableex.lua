-- Unit tests for Tableex.lua.

local ut = require("lbot_utils")
local tx = require("tableex")
local sx = require("stringex")


local M = {}

--[[ TODOL these:
function M.add_range(other)
function M.clear()
function M.contains(tbl, val)
function M.contains_value(val)
function M.copy(tbl)
function M.copy(tbl)
function M.deep_copy(t)
function M.dump_list(lst)
function M.dump_table(tbl, depth, name)
function M.keys()
function M.table_add(tbl, key, val)
function M.table_count(tbl)
function M.values()
]]

-- -----------------------------------------------------------------------------
-- function M.setup(pn)
--     -- print("setup()!!!")
-- end

-- -----------------------------------------------------------------------------
-- function M.teardown(pn)
--     -- print("teardown()!!!")
-- end


-- ---------------------------------------------------------------------------
-- function M.suite_happy_path(pn)
-- end

-- -----------------------------------------------------------------------------
-- function M.suite_table(pn)

--     -- Test dump_table().
--     local t1 = { aa="pt1", bb=90901, alist={ "qwerty", 777, temb1={ jj="pt8", b=true, temb2={ num=1.517, dd="strdd" } }, intx=5432}}

--     local d = tx.dump_table(t1, '000', 0)
--     print(d)

--     d = tx.dump_table(t1, '111', 1)
--     pn.UT_EQUAL(#d, 168)

--     d = tx.dump_table(t1, '222', 2)
--     pn.UT_EQUAL(#d, 251)

--     d = tx.dump_table(t1, '333', 3)
--     pn.UT_EQUAL(#d, 321)

--     d = tx.dump_table(t1, '444', 4)
--     pn.UT_EQUAL(#d, 321)

-- end


-----------------------------------------------------------------------------
function M.suite_dump_table(pn)

    -- Test dump_table().
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

    local d = tx.dump_table(tt)
    print(d)
    pn.UT_EQUAL(#d, 141)

    local d = tx.dump_table(tt, 0, 'depth0')
    print(d)
    pn.UT_EQUAL(#d, 141)

    d = tx.dump_table(tt, 1)
    print(d)
    pn.UT_EQUAL(#d, 239)

    d = tx.dump_table(tt, 2, 'depth0')
    print(d)
    pn.UT_EQUAL(#d, 322)

    d = tx.dump_table(tt, 3)
    print(d)
    pn.UT_EQUAL(#d, 392)

    d = tx.dump_table(tt, 4, 'depth4')
    print(d)
    pn.UT_EQUAL(#d, 392)

    -- local s = tx.dump_table_string(tt, 0, 'doody')
    -- pn.UT_EQUAL(#s, 94)

    -- s = tx.dump_table_string(tt, 1)
    -- pn.UT_EQUAL(#s, 191)

    -- s = tx.dump_table_string(tt, 2)
    -- pn.UT_EQUAL(#s, 272)

    -- s = tx.dump_table_string(tt, 3)
    -- pn.UT_EQUAL(#s, 316)

    -- s = tx.dump_table_string(tt, 4)
    -- pn.UT_EQUAL(#s, 316)

    local tl = {'aaa', 'bbb', 'ccc', 'ddd', 'eee'}
    d = tx.dump_list(tl)
    -- print(d)
    pn.UT_EQUAL(#d, 19)



--     local t1 = Tableex:create(
--     {
--         aa="pt1",
--         bb=90901,
--         alist=
--         {
--             "qwerty",
--             777,
--             temb1=
--             {
--                 jj="pt8",
--                 b=true,
--                 temb2=
--                 {
--                     num=1.517,
--                     dd="strdd"
--                 }
--             },
--             intx=5432
--         }
--     },
--     'green bunny')

--     print('>>>', t1[1])

--     local s = t1:dump()
--     print(s)
--     pn.UT_EQUAL(t1:count(), 4)


--     -- metatable
--     pn.UT_STR_EQUAL('green bunny', t1:name)
--     pn.UT_STR_EQUAL('string', t1:value_type())
--     pn.UT_STR_EQUAL('string', t1:value_type())
--     pn.UT_STR_EQUAL('Tableex', t1:class())
--     pn.UT_STR_EQUAL('Tableex:(string)[3] "green bunny"', tostring(t1))

--     local l = t1:keys()
--     pn.UT_EQUAL(l:count(), 3)
--     print('keys', l)

--     l = t1:values()
--     pn.UT_EQUAL(l:count(), 3)
--     print('values', l)


--     local t2 =
--     {
--         color='blue',
--         something={name='bazoo', count=55},
--     }

--     t1:add_range(t2)
--     pn.UT_EQUAL(t1:count(), 5)

--     pn.UT_EQUAL(t1:contains_value('bb'), 90901)
--     pn.UT_EQUAL(t1:contains_value('color'), 'blue')
--     pn.UT_NIL(t1:contains_value('nada'))


--     local t3 = t1:copy(t1.something)
--     pn.UT_EQUAL(t3:count(), 55)


--     t1:clear()
--     pn.UT_EQUAL(t1:count(), 0)



-- --     -- Test dump_table().

-- --     local d = ut.dump_table(t1, '000', 0)
-- --     pn.UT_EQUAL(#d, 70)
-- --     -- print(d)

-- --     d = ut.dump_table(t1, '111', 1)
-- --     pn.UT_EQUAL(#d, 168)

-- --     d = ut.dump_table(t1, '222', 2)
-- --     pn.UT_EQUAL(#d, 251)

-- --     d = ut.dump_table(t1, '333', 3)
-- --     pn.UT_EQUAL(#d, 321)

-- --     d = ut.dump_table(t1, '444', 4)
-- --     pn.UT_EQUAL(#d, 321)

end



-----------------------------------------------------------------------------
function M.suite_sad_path(pn)

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
-- function M.suite_table(pn)


-- end

-----------------------------------------------------------------------------
-- Return the module.
return M
