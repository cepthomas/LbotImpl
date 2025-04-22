-- Unit tests for Dictionary.lua.

require("Dictionary")
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

    local d1 = Dictionary:create(
    {
        aa="pd1",
        bb=90901,
        temb1=
        {
            jj="pt8",
            b=true,
        },
        xyz= function() end,
        777,
    },
    'green bunny')

    pn.UT_EQUAL(d1:count(), 5)

    local s = d1:dump()
    -- print(s)
    pn.UT_STR_CONTAINS(s, 'aa(string)[pd1]')

    -- metatable
    pn.UT_STR_EQUAL('green bunny', d1:name())
    pn.UT_STR_EQUAL('nil', d1:key_type())
    pn.UT_STR_EQUAL('nil', d1:value_type())
    pn.UT_STR_EQUAL('Dictionary', d1:class())
    pn.UT_STR_EQUAL('green bunny(Dictionary)[nil:nil]', tostring(d1))

--  TODOL fails for non-homogenous
--    local l = d1:keys()
--    pn.UT_EQUAL(l:count(), 4)
--    print('keys', l)
--
--    l = d1:values()
--    pn.UT_EQUAL(l:count(), 4)
--    print('values', l)


    local t2 =
    {
        color='blue',
        to_add={name='bazoo', count=55},
    }

    d1:add_range(t2)
    pn.UT_EQUAL(d1:count(), 7)

-- print(d1:contains_value('bb'))

    -- pn.UT_EQUAL(d1:contains_value('bb'), 90901)
    -- pn.UT_EQUAL(d1:contains_value('color'), 'blue')
    pn.UT_EQUAL(d1:contains_value(90901), 'bb')
    pn.UT_EQUAL(d1:contains_value('blue'), 'color')
    pn.UT_NIL(d1:contains_value('nada'))


    d1:clear()
    pn.UT_EQUAL(d1:count(), 0)

end


-----------------------------------------------------------------------------
function M.suite_sad_path(pn) -- TODOL


end


-----------------------------------------------------------------------------
-- Return the module.
return M
