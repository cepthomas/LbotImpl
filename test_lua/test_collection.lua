
local ut = require("lbot_utils")
local tx = require("tableex")
local sx = require("stringex")
local ls = require("List")

--- If using debugger, bind lua error() function to it.
ut.config_debug(true)


local M = {}

-----------------------------------------------------------------------------
function M.setup(pn)
    -- pn.UT_INFO("setup()!!!")
end

-----------------------------------------------------------------------------
function M.teardown(pn)
    -- pn.UT_INFO("teardown()!!!")
end

-----------------------------------------------------------------------------
function M.suite_list(pn)

    local tinv = { aa="pt1", 1119, bb=90901, alist={ "qwerty", 777, b=true }, intx=5432 }

    local t1 = { 'fido', 'bonzo', 'moondoggie' }
    local t2 = { 'muffin', 'kitty', 'beetlejuice', 'tigger' }

    -- dbg()

    ----- happy test
    local l1 = List(t1, 'pink bunny')
    l1:count()

    pn.UT_EQUAL('List:pink bunny type:string len:3', tostring(l1))
    pn.UT_EQUAL(l1:count(), 3)

    l1:add('end')
    pn.UT_EQUAL(l1:count(), 4)

    l1:insert(1, 'first')
    pn.UT_EQUAL(l1:count(), 5)
    l1:insert(4, 'middle')
    pn.UT_EQUAL(l1:count(), 6)

    l1:add_range(t2)
    pn.UT_EQUAL(l1:count(), 10)

    pn.UT_EQUAL(l1:index_of('kitty'), 8)
    pn.UT_EQUAL(l1:index_of('nada'), nil)

    pn.UT_TRUE(l1:contains('moondoggie'))
    pn.UT_FALSE(l1:contains('hoody'))


    l1:sort(function(a, b) return a < b end)
    pn.UT_EQUAL(l1:count(), 10)
    pn.UT_EQUAL(l1[5], 'first')


    l1:reverse()
    pn.UT_EQUAL(l1:count(), 10)
    pn.UT_EQUAL(l1[5], 'kitty')

    l1:foreach(function(v, arg) v = v..arg end, '_xyz')
    pn.UT_EQUAL(l1:count(), 10)

    res = l1:get_range() -- clone
    pn.UT_EQUAL(res:count(), 10)
    pn.UT_EQUAL(res[2], 'muffin')

dbg()
    res = l1:get_range(5) -- rh
    pn.UT_EQUAL(res:count(), 5)
    pn.UT_EQUAL(res[0], 'wwwww')

    res = l1:get_range(3, 6) -- subset
    pn.UT_EQUAL(res:count(), 5)
    pn.UT_EQUAL(res[0], 'wwwww')



    l1:remove_at(5)
    pn.UT_EQUAL(l1:count(), 9)

    l1:remove_at(55)
    pn.UT_EQUAL(l1:count(), 9)

    l1:remove('middle')
    pn.UT_EQUAL(l1:count(), 8)

    l1:remove('fake')
    pn.UT_EQUAL(l1:count(), 8)

    l1:clear()
    pn.UT_EQUAL(l1:count(), 0)


    ----- sad test
    l3 = List(tinv)

end


-----------------------------------------------------------------------------
function M.suite_dict(pn)

end


-----------------------------------------------------------------------------
-- Return the module.
return M
