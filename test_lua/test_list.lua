-- Unit tests for List.lua.

require('List')


local M = {}

-- -----------------------------------------------------------------------------
-- function M.setup(pn)
-- end

-- -----------------------------------------------------------------------------
-- function M.teardown(pn)
-- end

---------------------------------------------------------------------------
function M.suite_happy_path(pn)

    local t1 = { 'fido', 'bonzo', 'moondoggie' }
    local t2 = { 'muffin', 'kitty', 'beetlejuice', 'tigger' }

    local l1 = List(t1, 'pink bunny')

    pn.UT_STR_EQUAL('List:[pink bunny] type:string len:3', tostring(l1))
    pn.UT_EQUAL(l1:count(), 3)

    l1:add('end')
    pn.UT_EQUAL(l1:count(), 4)

    l1:insert(1, 'first')
    pn.UT_EQUAL(l1:count(), 5)
    l1:insert(4, 'middle')
    pn.UT_EQUAL(l1:count(), 6)

    -- { 'first', 'fido', 'bonzo', 'middle', 'moondoggie', 'end' }

    l1:add_range(t2)
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

    l1:foreach(function(v, arg) v = v..arg end, '_xyz')
    pn.UT_EQUAL(l1:count(), 10)

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
function M.suite_fail(pn)

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
    print(ok, msg)
    pn.UT_TRUE(ok)
    pn.UT_EQUAL(l2:count(), 1)

    ok, msg = pcall(l2.add, l2, {})
    pn.UT_FALSE(ok)
    pn.UT_STR_CONTAINS(msg, 'Values not homogenous')

end

-----------------------------------------------------------------------------
-- Return the module.
return M
