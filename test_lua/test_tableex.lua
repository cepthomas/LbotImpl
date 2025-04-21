-- Unit tests for Tableex.lua.

require("Tableex")
-- local ut = require("lbot_utils")


local M = {}


-- -----------------------------------------------------------------------------
-- function M.setup(pn)
--     -- print("setup()!!!")
-- end

-- -----------------------------------------------------------------------------
-- function M.teardown(pn)
--     -- print("teardown()!!!")
-- end


---------------------------------------------------------------------------
function M.suite_happy_path(pn)

    local t1 = Tableex:create(
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
        }
    },
    'green bunny')

    print('>>>', t1[1])

    local s = t1:dump()
    print(s)
    pn.UT_EQUAL(t1:count(), 4)


    -- metatable
    pn.UT_STR_EQUAL('green bunny', t1:name)
    pn.UT_STR_EQUAL('string', t1:value_type())
    pn.UT_STR_EQUAL('string', t1:value_type())
    pn.UT_STR_EQUAL('Tableex', t1:class())
    pn.UT_STR_EQUAL('Tableex:(string)[3] "green bunny"', tostring(t1))

    local l = t1:keys()
    pn.UT_EQUAL(l:count(), 3)
    print('keys', l)

    l = t1:values()
    pn.UT_EQUAL(l:count(), 3)
    print('values', l)


    local t2 =
    {
        color='blue',
        something={name='bazoo', count=55},
    }

    t1:add_range(t2)
    pn.UT_EQUAL(t1:count(), 5)

    pn.UT_EQUAL(t1:contains_value('bb'), 90901)
    pn.UT_EQUAL(t1:contains_value('color'), 'blue')
    pn.UT_NIL(t1:contains_value('nada'))


    local t3 = t1:copy(t1.something)
    pn.UT_EQUAL(t3:count(), 55)


    t1:clear()
    pn.UT_EQUAL(t1:count(), 0)



--     -- Test dump_table().

--     local d = ut.dump_table(t1, '000', 0)
--     pn.UT_EQUAL(#d, 70)
--     -- print(d)

--     d = ut.dump_table(t1, '111', 1)
--     pn.UT_EQUAL(#d, 168)

--     d = ut.dump_table(t1, '222', 2)
--     pn.UT_EQUAL(#d, 251)

--     d = ut.dump_table(t1, '333', 3)
--     pn.UT_EQUAL(#d, 321)

--     d = ut.dump_table(t1, '444', 4)
--     pn.UT_EQUAL(#d, 321)

end



-----------------------------------------------------------------------------
function M.suite_sad_path(pn)

    -- Init from table.
    local t1 = Tableex:create({ aa="pt1", bb=90901, alist={ "qwerty", 777, temb1={ jj="pt8", b=true, temb2={ num=1.517, dd="strdd" } }, intx=5432}}, 'green bunny')
    pn.UT_EQUAL(t1:count(), 4)

    local ok, msg = pcall(t1.add, 123)
    pn.UT_FALSE(ok)
    pn.UT_STR_CONTAINS(msg, 'Values not homogenous')

    ok, msg = pcall(t1.remove_at, t1, 55)
    pn.UT_FALSE(ok)
    pn.UT_STR_CONTAINS(msg, 'Invalid integer:55')

    -- Init from nothing.
    local l2 = Tableex:create()
    pn.UT_EQUAL(l2:count(), 0)

    ok, msg = pcall(l2.add, l2, true)
    pn.UT_TRUE(ok)
    pn.UT_EQUAL(l2:count(), 1)

    ok, msg = pcall(l2.add, l2, {})
    pn.UT_FALSE(ok)
    pn.UT_STR_CONTAINS(msg, 'Values not homogenous')

end

-----------------------------------------------------------------------------
-- function M.suite_table(pn)


-- end

-----------------------------------------------------------------------------
-- Return the module.
return M
