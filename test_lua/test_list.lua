-- Unit tests for List.lua.

local sx = require("stringex")
local ll = require('List')
local dbg = require('debugger')


local M = {}

-- -----------------------------------------------------------------------------
-- function M.setup(pn)
-- end

-- -----------------------------------------------------------------------------
-- function M.teardown(pn)
-- end



---------------------------------------------------------------------------
function M.suite_happy_path(pn)
    -- dbg()

    -- local list1 = ll.new({'fido', 'bonzo', 'moondoggie'}, 'pink bunny')
    local list1 = ll.new('pink bunny')
    list1:add_range({'fido', 'bonzo', 'moondoggie'})

    pn.UT_EQUAL(list1:count(), 3)
    local s = list1:dump()

    -- metatable
    pn.UT_STR_EQUAL('pink bunny', list1:name())
    pn.UT_STR_EQUAL('string', list1:value_type())
    pn.UT_STR_EQUAL('List', list1:class())
    pn.UT_STR_EQUAL('pink bunny(List)[string]', tostring(list1))

    list1:add('end')
    pn.UT_EQUAL(list1:count(), 4)

    list1:insert(1, 'first')
    pn.UT_EQUAL(list1:count(), 5)
    list1:insert(4, 'middle')
    pn.UT_EQUAL(list1:count(), 6)
    -- { 'first', 'fido', 'bonzo', 'middle', 'moondoggie', 'end' }

    list1:add_range({ 'muffin', 'kitty', 'beetlejuice', 'tigger' })
    pn.UT_EQUAL(list1:count(), 10)
    -- { 'first', 'fido', 'bonzo', 'middle', 'moondoggie', 'end', 'muffin', 'kitty', 'beetlejuice', 'tigger' }

    pn.UT_EQUAL(list1:index_of('kitty'), 8)
    pn.UT_EQUAL(list1:index_of('nada'), nil)

    pn.UT_TRUE(list1:contains('moondoggie'))
    pn.UT_FALSE(list1:contains('hoody'))


    list1:sort(function(a, b) return a < b end)
    -- 'beetlejuice', 'bonzo', 'end', 'fido', 'first', 'kitty', 'middle', 'moondoggie', 'muffin', 'tigger'
    pn.UT_EQUAL(list1:count(), 10)
    pn.UT_STR_EQUAL(list1[5], 'first')

    list1:reverse()
    -- 'tigger', 'muffin', 'moondoggie', 'middle', 'kitty', 'first', 'fido', 'end', 'bonzo', 'beetlejuice', 
    pn.UT_EQUAL(list1:count(), 10)
    pn.UT_STR_EQUAL(list1[5], 'kitty')

    -- find
    local list3 = ll.new('find')
    list3:add_range({ 'muffin', 'xxx', 'kitty', 'beetlejuice', 'tigger', 'xxx', 'fido', 'bonzo', 'moondoggie', 'xxx' })
    local ind = list3:find('zzz')
    pn.UT_NIL(ind)
    ind = list3:find('xxx')
    pn.UT_EQUAL(ind, 2)
    ind = list3:find('xxx', ind + 1)
    pn.UT_EQUAL(ind, 6)
    ind = list3:find('xxx', ind + 1)
    pn.UT_EQUAL(ind, 10)
    ind = list3:find('xxx', ind + 1)
    pn.UT_NIL(ind)

    local all = list3:find_all(function(v) return sx.contains(v, 'zzzzzz') end)
    pn.UT_EQUAL(all:count(), 0)
    local all = list3:find_all(function(v) return sx.contains(v, 't') end)
    pn.UT_EQUAL(all:count(), 3)

    local res = list1:get_range() -- clone
    pn.UT_EQUAL(res:count(), 10)
    pn.UT_STR_EQUAL(res[2], 'muffin')

    res = list1:get_range(5) -- rh
    -- 'kitty', 'first', 'fido', 'end', 'bonzo', 'beetlejuice', 
    pn.UT_EQUAL(res:count(), 6)
    pn.UT_STR_EQUAL(res[3], 'fido')

    res = list1:get_range(3, 6) -- subset
    -- 'moondoggie', 'middle', 'kitty', 'first', 'fido', 'end' 
    pn.UT_EQUAL(res:count(), 6)
    pn.UT_STR_EQUAL(res[4], 'first')

    list1:remove_at(5)
    pn.UT_EQUAL(list1:count(), 9)

    list1:remove('middle')
    pn.UT_EQUAL(list1:count(), 8)

    list1:remove('fake')
    pn.UT_EQUAL(list1:count(), 8)

    list1:clear()
    pn.UT_EQUAL(list1:count(), 0)

end

-----------------------------------------------------------------------------
function M.suite_sad_path(pn)

    -- -- Init from table.
    -- local list1 = ll.new({ 'muffin', 'kitty', 'beetlejuice', 'tigger' }, 'purple dragon')
    -- list1.count()
    -- pn.UT_EQUAL(list1:count(), 4)

    -- local ok, msg = pcall(list1.add, 123)
    -- pn.UT_FALSE(ok)
    -- pn.UT_STR_CONTAINS(msg, 'Values not homogenous')

    -- ok, msg = pcall(list1.remove_at, list1, 55)
    -- pn.UT_FALSE(ok)
    -- pn.UT_STR_CONTAINS(msg, 'Invalid integer:55')

    -- -- Init from nothing.
    -- local list2 = List()
    -- pn.UT_EQUAL(list2:count(), 0)

    -- ok, msg = pcall(list2.add, list2, true)
    -- pn.UT_TRUE(ok)
    -- pn.UT_EQUAL(list2:count(), 1)

    -- ok, msg = pcall(list2.add, list2, {})
    -- pn.UT_FALSE(ok)
    -- pn.UT_STR_CONTAINS(msg, 'Values not homogenous')

end

-----------------------------------------------------------------------------
-- Return the module.
return M
