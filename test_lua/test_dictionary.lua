-- Unit tests for Dictionary.lua.

local dict = require("Dictionary")
local tx = require("tableex")
-- local ut = require("lbot_utils")

local M = {}


-- -----------------------------------------------------------------------------
-- function M.setup(pn)
-- end

-- -----------------------------------------------------------------------------
-- function M.teardown(pn)
-- end


---------------------------------------------------------------------------
function M.suite_happy_path(pn)

    local d1 = dict.new(
    {
        aa=100,
        bb=200,
        cc=300,
        dd=400,
        ee=500
    },
    'green dragon')

    pn.UT_EQUAL(d1:count(), 5)

    local s = d1:dump()
    -- print(s)
    pn.UT_STR_CONTAINS(s, 'bb(number)[200]')

    -- metatable
    pn.UT_STR_EQUAL('Dictionary', d1:class())
    pn.UT_STR_EQUAL('green dragon', d1:name())
    pn.UT_STR_EQUAL('string', d1:key_type())
    pn.UT_STR_EQUAL('integer', d1:value_type())
    pn.UT_STR_EQUAL('green dragon(Dictionary)[string:integer]', tostring(d1))

    local l = d1:keys()
    pn.UT_EQUAL(l:count(), 5)

    l = d1:values()
    pn.UT_EQUAL(l:count(), 5)

    local t2 =
    {
        xx=808,
        yy=909,
    }

    d1:add_range(t2)
    pn.UT_EQUAL(d1:count(), 7)

    pn.UT_EQUAL(d1:contains_value(400), 'dd')
    pn.UT_EQUAL(d1:contains_value(808), 'xx')
    pn.UT_NIL(d1:contains_value('nada'))

    d1:clear()
    pn.UT_EQUAL(d1:count(), 0)

end

-----------------------------------------------------------------------------
function M.suite_sad_path(pn) -- TODOL break things
    -- -- local d1 = Dictionary:create(
    -- local d1 = dict.new(
    -- {
    --     aa="pd1",
    --     bb=90901,
    --     temb1=
    --     {
    --         jj="pt8",
    --         b=true,
    --     },
    --     xyz= function() end,
    --     777,
    -- },
    -- 'green bunny')

    -- -- metatable
    -- pn.UT_STR_EQUAL('green bunny', d1:name())
    -- pn.UT_STR_EQUAL('nil', d1:key_type())
    -- pn.UT_STR_EQUAL('nil', d1:value_type())
    -- pn.UT_STR_EQUAL('Dictionary', d1:class())
    -- pn.UT_STR_EQUAL('green bunny(Dictionary)[nil:nil]', tostring(d1))

    -- local l = d1:keys()
    -- pn.UT_EQUAL(l:count(), 4)
    -- -- print('keys', l)

    -- l = d1:values()
    -- pn.UT_EQUAL(l:count(), 4)
    -- -- print('values', l)



    -- local t2 =
    -- {
    --     color='blue',
    --     to_add={name='bazoo', count=55},
    -- }

    -- d1:add_range(t2)
    -- pn.UT_EQUAL(d1:count(), 7)

    -- -- print(d1:contains_value('bb'))

    -- -- pn.UT_EQUAL(d1:contains_value('bb'), 90901)
    -- -- pn.UT_EQUAL(d1:contains_value('color'), 'blue')
    -- pn.UT_EQUAL(d1:contains_value(90901), 'bb')
    -- pn.UT_EQUAL(d1:contains_value('blue'), 'color')
    -- pn.UT_NIL(d1:contains_value('nada'))

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
