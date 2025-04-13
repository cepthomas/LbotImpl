
local sx = require("stringex")
local tx = require("tableex")
local ut = require("lbot_utils")
local lt = require("lbot_types")


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
function M.suite_basic_types(pn)

    pn.UT_TRUE(lt.is_integer(101))
    pn.UT_FALSE(lt.is_integer(101.0001))

    local function hoohaa() end
    pn.UT_TRUE(lt.is_callable(hoohaa))
    pn.UT_FALSE(lt.is_callable('abcdef'))

    local tbl1 = { 'aaa', 'bbb', 333 }
    local tbl2 = { ['aaa']=777; ['bbb']='uuu'; [333]=122.2 }
    pn.UT_TRUE(lt.is_indexable(tbl1))
    pn.UT_TRUE(lt.is_indexable(tbl2))

    pn.UT_TRUE(lt.is_iterable(tbl1))
    pn.UT_TRUE(lt.is_iterable(tbl2))

    pn.UT_FALSE(lt.is_iterable('rrr'))
    pn.UT_FALSE(lt.is_iterable(123))

    pn.UT_TRUE(lt.is_writeable(tbl1))
    pn.UT_FALSE(lt.is_writeable(2.2))

    local res = lt.tointeger(123)
    pn.UT_EQUAL(res, 123)
    res = lt.tointeger(123.1)
    pn.UT_EQUAL(res, nil)
    res = lt.tointeger('123')
    pn.UT_EQUAL(res, 123)

end

-----------------------------------------------------------------------------
function M.suite_validators(pn)

    local res

    ----- val_number
    res = pcall(lt.val_number, 13.4, 13.3, 13.5)
    pn.UT_TRUE(res)

    res = pcall(lt.val_number, 13.4)
    pn.UT_TRUE(res)

    -- Wrong type
    res = pcall(lt.val_number, '13.4', 13.3, 13.5)
    pn.UT_FALSE(res)

    -- Below
    res = pcall(lt.val_number, 13.2, 13.3, 13.5)
    pn.UT_FALSE(res)

    -- Above
    res = pcall(lt.val_number, 13.6, 13.9, 13.5)
    pn.UT_FALSE(res)

    ----- val_integer
    res = pcall(lt.val_integer, 271, 270, 272)
    pn.UT_TRUE(res)

    res = pcall(lt.val_integer, 271)
    pn.UT_TRUE(res)

    -- Wrong type
    res = pcall(lt.val_integer, 13.4, 13.3, 13.5)
    pn.UT_FALSE(res)

    -- Below
    res = pcall(lt.val_integer, 269, 270, 272)
    pn.UT_FALSE(res)

    -- Above
    res = pcall(lt.val_integer, 273, 270, 272)
    pn.UT_FALSE(res)

    ----- val_xxx
    local tbl = {}
    pn.UT_TRUE(lt.val_type(tbl, 'table'))
    pn.UT_TRUE(lt.val_type(123, 'integer'))
    pn.UT_TRUE(lt.val_type(123.1, 'number'))
    pn.UT_TRUE(lt.val_type(false, 'boolean'))
    res = pcall(lt.val_type, '123', 'table')
    pn.UT_FALSE(res)

    local tbl1 = { 'aaa', 'bbb', 333 }
    local tbl2 = { ['aaa']=777; ['bbb']='uuu'; [333]=122.2 }

    pn.UT_TRUE(lt.val_table(tbl1, 3))
    res = pcall(lt.val_table, tbl1, 4)
    pn.UT_FALSE(res)
    res = pcall(lt.val_table, 'tbl1', 4)
    pn.UT_FALSE(res)

    pn.UT_TRUE(lt.val_not_nil(tbl1))
    res = pcall(lt.val_not_nil, nil)
    pn.UT_FALSE(res)

    local function hoohaa() end
    pn.UT_TRUE(lt.val_func(hoohaa))
    res = pcall(lt.val_func, 123)
    pn.UT_FALSE(res)

end

-----------------------------------------------------------------------------
-- Return the module.
return M
