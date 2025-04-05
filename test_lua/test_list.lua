
-- local sx = require("stringex")
-- local tx = require("tableex")
local ut = require("lbot_utils")
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

    -- Test dump_table().
    local tt = { aa="pt1", bb=90901, alist={ "qwerty", 777, temb1={ jj="pt8", b=true, temb2={ num=1.517, dd="strdd" } }, intx=5432}}

    local d = tx.dump_table(tt, 0)
    pn.UT_EQUAL(#d, 4)

    -- test
    l = List({ 'fido', 'bonzo' })
    -- print('+++ fido '..l:getName(1))
    -- print('+++ bonzo '..l:getName(2))

    pn.UT_EQUAL('tostring', l:__tostring())
    pn.UT_EQUAL(l:len(), 2)

    l:append('end')
    pn.UT_EQUAL(l:len(), 3)

    print(l:put('first'))
    pn.UT_EQUAL(l:len(), 4)


    print(l:pop(i))


    print(l:remove (i))

    print(l:remove_value(v))

    print(l:reverse())

    print(l:clear())

    print(l:clone())

    print(l:contains(v))

    print(l:count(v))


    print(l:iter())

    print(l:extend({ 'xxx', 'yyy', 'zzz' }))

    -- print(l:filter(fun, arg))

    -- print(l:foreach(fun, ...))
    -- print(l:sort(cmp))

    print(l:insert(2, 'v'))




end

-----------------------------------------------------------------------------
-- Return the module.
return M
