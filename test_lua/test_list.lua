-- Unit tests for List.lua.

require('List')
local sx = require("stringex")


local M = {}

-- -----------------------------------------------------------------------------
-- function M.setup(pn)
-- end

-- -----------------------------------------------------------------------------
-- function M.teardown(pn)
-- end



---------------------------------------------------------------------------
function M.suite_happy_path(pn)

    local l1 = List({ 'fido', 'bonzo', 'moondoggie' }, 'pink bunny')
    pn.UT_EQUAL(l1:count(), 3)
    local s = l1:dump()

    -- metatable
    pn.UT_STR_EQUAL('pink bunny', l1:name())
    pn.UT_STR_EQUAL('string', l1:value_type())
    pn.UT_STR_EQUAL('List', l1:class())
    pn.UT_STR_EQUAL('List:(string)[3] "pink bunny"', tostring(l1))

    l1:add('end')
    pn.UT_EQUAL(l1:count(), 4)

    l1:insert(1, 'first')
    pn.UT_EQUAL(l1:count(), 5)
    l1:insert(4, 'middle')
    pn.UT_EQUAL(l1:count(), 6)
    -- { 'first', 'fido', 'bonzo', 'middle', 'moondoggie', 'end' }

    l1:add_range({ 'muffin', 'kitty', 'beetlejuice', 'tigger' })
    pn.UT_EQUAL(l1:count(), 10)
    -- { 'first', 'fido', 'bonzo', 'middle', 'moondoggie', 'end', 'muffin', 'kitty', 'beetlejuice', 'tigger' }

    pn.UT_EQUAL(l1:index_of('kitty'), 8)
    pn.UT_EQUAL(l1:index_of('nada'), nil)

    pn.UT_TRUE(l1:contains('moondoggie'))
    pn.UT_FALSE(l1:contains('hoody'))


    l1:sort(function(a, b) return a < b end)
    -- 'beetlejuice', 'bonzo', 'end', 'fido', 'first', 'kitty', 'middle', 'moondoggie', 'muffin', 'tigger'
    pn.UT_EQUAL(l1:count(), 10)
    pn.UT_STR_EQUAL(l1[5], 'first')

    l1:reverse()
    -- 'tigger', 'muffin', 'moondoggie', 'middle', 'kitty', 'first', 'fido', 'end', 'bonzo', 'beetlejuice', 
    pn.UT_EQUAL(l1:count(), 10)
    pn.UT_STR_EQUAL(l1[5], 'kitty')

    -- find
    local l3 = List({ 'muffin', 'xxx', 'kitty', 'beetlejuice', 'tigger', 'xxx', 'fido', 'bonzo', 'moondoggie', 'xxx' }, 'find')
    local ind = l3:find('zzz')
    pn.UT_NIL(ind)
    ind = l3:find('xxx')
    pn.UT_EQUAL(ind, 2)
    ind = l3:find('xxx', ind + 1)
    pn.UT_EQUAL(ind, 6)
    ind = l3:find('xxx', ind + 1)
    pn.UT_EQUAL(ind, 10)
    ind = l3:find('xxx', ind + 1)
    pn.UT_NIL(ind)

    local all = l3:find_all(function(v) return sx.contains(v, 'zzzzzz') end)
    pn.UT_EQUAL(all:count(), 0)
    local all = l3:find_all(function(v) return sx.contains(v, 't') end)
    pn.UT_EQUAL(all:count(), 3)


    local res = l1:get_range() -- clone
    pn.UT_EQUAL(res:count(), 10)
    pn.UT_STR_EQUAL(res[2], 'muffin')

    res = l1:get_range(5) -- rh
    -- 'kitty', 'first', 'fido', 'end', 'bonzo', 'beetlejuice', 
    pn.UT_EQUAL(res:count(), 6)
    pn.UT_STR_EQUAL(res[3], 'fido')

    res = l1:get_range(3, 6) -- subset
    -- 'moondoggie', 'middle', 'kitty', 'first', 'fido', 'end' 
    pn.UT_EQUAL(res:count(), 6)
    pn.UT_STR_EQUAL(res[4], 'first')

    l1:remove_at(5)
    pn.UT_EQUAL(l1:count(), 9)

    l1:remove('middle')
    pn.UT_EQUAL(l1:count(), 8)

    l1:remove('fake')
    pn.UT_EQUAL(l1:count(), 8)

    l1:clear()
    pn.UT_EQUAL(l1:count(), 0)

end

-----------------------------------------------------------------------------
function M.suite_sad_path(pn)

    -- Init from table.
    local l1 = List({ 'muffin', 'kitty', 'beetlejuice', 'tigger' })
    pn.UT_EQUAL(l1:count(), 4)

    local ok, msg = pcall(l1.add, 123)
    pn.UT_FALSE(ok)
    pn.UT_STR_CONTAINS(msg, 'Values not homogenous')

    ok, msg = pcall(l1.remove_at, l1, 55)
    pn.UT_FALSE(ok)
    pn.UT_STR_CONTAINS(msg, 'Invalid integer:55')

    -- Init from nothing.
    local l2 = List()
    pn.UT_EQUAL(l2:count(), 0)

    ok, msg = pcall(l2.add, l2, true)
    pn.UT_TRUE(ok)
    pn.UT_EQUAL(l2:count(), 1)

    ok, msg = pcall(l2.add, l2, {})
    pn.UT_FALSE(ok)
    pn.UT_STR_CONTAINS(msg, 'Values not homogenous')

end

-----------------------------------------------------------------------------
-- Return the module.
return M
