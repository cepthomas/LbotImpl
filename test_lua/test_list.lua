
local ut = require("lbot_utils")
local tx = require("tableex")
local sx = require("stringex")
local ls = require("List")


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
function M.suite_happy_path(pn)

    local t1 = { 'fido', 'bonzo', 'moondoggie' }
    local t2 = { 'muffin', 'kitty', 'beetlejuice', 'tigger' }

    local l1 = List(t1, 'pink bunny')

    pn.UT_EQUAL('List:[pink bunny] type:string len:3', tostring(l1))
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
    pn.UT_EQUAL(l1[5], 'first')


    l1:reverse()
    -- 'tigger', 'muffin', 'moondoggie', 'middle', 'kitty', 'first', 'fido', 'end', 'bonzo', 'beetlejuice', 
    pn.UT_EQUAL(l1:count(), 10)
    pn.UT_EQUAL(l1[5], 'kitty')

    l1:foreach(function(v, arg) v = v..arg end, '_xyz')
    pn.UT_EQUAL(l1:count(), 10)

    res = l1:get_range() -- clone
    pn.UT_EQUAL(res:count(), 10)
    pn.UT_EQUAL(res[2], 'muffin')

    res = l1:get_range(5) -- rh
    -- 'kitty', 'first', 'fido', 'end', 'bonzo', 'beetlejuice', 
    pn.UT_EQUAL(res:count(), 6)
    pn.UT_EQUAL(res[3], 'fido')

    res = l1:get_range(3, 6) -- subset
    -- 'moondoggie', 'middle', 'kitty', 'first', 'fido', 'end' 
    pn.UT_EQUAL(res:count(), 6)
    pn.UT_EQUAL(res[4], 'first')

    l1:remove_at(5)
    pn.UT_EQUAL(l1:count(), 9)

    l1:remove('middle')
    pn.UT_EQUAL(l1:count(), 8)

    l1:remove('fake')
    pn.UT_EQUAL(l1:count(), 8)

    l1:clear()
    pn.UT_EQUAL(l1:count(), 0)

end

-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
local _orig_error_func
local _last_error_msg = '' -- {}

local function test_error(msg, level)
    _last_error_msg = msg
    -- _last_error_msg.add(msg)
    -- print('ERROR '..msg..'('..tostring(level)..')')
    -- _orig_error_func(msg, level)
end


-----------------------------------------------------------------------------
function M.suite_fail(pn)

    -- save original error function
    _orig_error_func = _G.error
    _G.error = test_error



    local tinv = { aa="pt1", 1119, bb=90901, alist={ "qwerty", 777, b=true }, intx=5432 }

print('here')
    local l3 = List(tinv)

    local t1 = { 'fido', 'bonzo', 'moondoggie' }
    local t2 = { 'muffin', 'kitty', 'beetlejuice', 'tigger' }

    local l1 = List(t1, 'pink bunny')

    l1:remove_at(55)



    -- restore
    _G.error = _orig_error_func

end

-----------------------------------------------------------------------------
-- Return the module.
return M
