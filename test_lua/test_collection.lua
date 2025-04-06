
-- local sx = require("stringex")
-- local tx = require("tableex")
local ut = require("lbot_utils")
local tx = require("tableex")
local ls = require("List")

-- print('!!!', package.path)

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


    ----- happy test
    local l1 = List(t1, 'pink bunny')
    -- print('+++ fido '..l:getName(1))
    -- print('+++ bonzo '..l:getName(2))

    print(tx.dump_table_string(l1, 1, 'name'))

    l1:count()

    -- for i, v in ipairs(l1) do
    --     print(i, v)
    -- end

    pn.UT_EQUAL('List:pink bunny type:string len:3', l1:__tostring())
    pn.UT_EQUAL('tostring', tostring(l1))
    pn.UT_EQUAL(l1:count(), 3)

    l1:add('end')
    pn.UT_EQUAL(l1:count(), 4)

    l1:insert(0, 'first')
    pn.UT_EQUAL(l1:count(), 5)
    l1:insert(4, 'middle')
    pn.UT_EQUAL(l1:count(), 6)

    l1:add_range(t2)
    pn.UT_EQUAL(l1:count(), 11)

    pn.UT_EQUAL(l1:index_of('kitty'), 11)
    pn.UT_EQUAL(l1:index_of('nada'), nil)

    pn.UT_TRUE(l1:contains('moondoggie'))
    pn.UT_FALSE(l1:contains('hoody'))



    -- for l in seq.filter(io.lines(file), stringx.isdigit) do print(l) end
    -- ls = seq.filter(ls, '>', 0)
    -- seq.filter(seq.list{10,20,5,15},seq.greater_than(10))
    local res = o:find_all(l1, string.contains('n'), 'xtra-arg')
    pn.UT_EQUAL(res:count(), 999)


-- If comp is given, then it must be a function that receives two list elements and returns true when the first element must come before the second in the final order, so that, after the sort, i <= j implies not comp(list[j],list[i]). If comp is not given, then the standard Lua operator < is used instead.

    l1:sort(function(a, b) return a < b end)
    pn.UT_EQUAL(l1:count(), 999)
    pn.UT_EQUAL(l1[5], 'wwwww')


    l1:reverse()
    pn.UT_EQUAL(l1:count(), 999)
    pn.UT_EQUAL(l1[5], 'wwwww')


    l1:foreach(function(v, arg) v = v..arg end, 'hello')
    pn.UT_EQUAL(l1:count(), 999)
    pn.UT_EQUAL(l1[5], 'wwwww')


    res = l1:get_range() -- clone
    pn.UT_EQUAL(res:count(), 999)
    pn.UT_EQUAL(res[0], 'wwwww')

    res = l1:get_range(5) -- rh
    pn.UT_EQUAL(res:count(), 999)
    pn.UT_EQUAL(res[0], 'wwwww')

    res = l1:get_range(3, 6) -- subset
    pn.UT_EQUAL(res:count(), 999)
    pn.UT_EQUAL(res[0], 'wwwww')



    l1:remove_at(5)
    pn.UT_EQUAL(l1:count(), 999)

    l1:remove_at(55)
    pn.UT_EQUAL(l1:count(), 999)

    l1:remove('middle')
    pn.UT_EQUAL(l1:count(), 999)

    l1:remove('fake')
    pn.UT_EQUAL(l1:count(), 999)

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
