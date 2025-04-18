-- Unit tests for lbot_utils.lua.

local ut = require("lbot_utils")


local M = {}


-- -----------------------------------------------------------------------------
-- function M.setup(pn)
--     -- pn.UT_INFO("setup()!!!")
-- end

-- -----------------------------------------------------------------------------
-- function M.teardown(pn)
--     -- pn.UT_INFO("teardown()!!!")
-- end

------------------------------ System ---------------------------------------
function M.suite_system(pn)

---@diagnostic disable-next-line: lowercase-global
    accidental_global = 0
---@diagnostic disable-next-line: unused-local
    local extraneous, unused = ut.check_globals({ 'appglob1', 'appglob2', 'appglob3'})
    -- print(ut.dump_table(extraneous, 'extraneous', 1))
    -- print(ut.dump_table(unused, 'unused', 1))

    ut.fix_lua_path('/mypath')
    -- print(package.path)
    pn.UT_STR_CONTAINS(package.path, 'mypath')

    local res = ut.execute_and_capture('dir')
    pn.UT_STR_CONTAINS(res, 'test_utils.lua')
    pn.UT_STR_CONTAINS(res, '<DIR>          ..')

    local fpath, line, dir = ut.get_caller_info(2)
    pn.UT_EQUAL(line, 37) -- line of call above
    pn.UT_STR_CONTAINS(fpath, '\\LbotImpl\\test_lua\\test_utils.lua')
    pn.UT_STR_CONTAINS(dir, '\\LbotImpl\\test_lua')

    -- for i = 0, 6 do
    --     local fpath, line, dir = ut.get_caller_info(i)
    --     print(i..' '..fpath..'('..line..') dir['..dir..']')
    -- end

end

------------------------- Math ----------------------------------------------
function M.suite_math(pn)

    local res = ut.constrain(55, 107.6, 553)
    pn.UT_EQUAL(res, 107.6)

    res = ut.constrain(118.9, 107.6, 553)
    pn.UT_EQUAL(res, 118.9)

    res = ut.constrain(692, 107.6, 553)
    pn.UT_EQUAL(res, 553)

    res = ut.map(19.1, -100, 100, 30, 300)
    pn.UT_EQUAL(res, 190.785)

    res = ut.clamp(-22.84, 0.1, true)
    pn.UT_EQUAL(res, -22.8)

    res = ut.clamp(411, 5, false)
    pn.UT_EQUAL(res, 410)

end

------------------------------ Files ----------------------------------------
function M.suite_files(pn)

    ut.file_write_all('_test_file.txt', 'a new string')

    ut.file_append_all('_test_file.txt', 'a second string')

    local res = ut.file_read_all('_test_file.txt')
    pn.UT_STR_EQUAL(res, 'a new stringa second string')

end

------------------------------ Odds and Ends --------------------------------
function M.suite_table(pn)

    -- Test dump_table().
    local t1 = { aa="pt1", bb=90901, alist={ "qwerty", 777, temb1={ jj="pt8", b=true, temb2={ num=1.517, dd="strdd" } }, intx=5432}}

    local d = ut.dump_table(t1, '000', 0)
    pn.UT_EQUAL(#d, 70)
    -- print(d)

    d = ut.dump_table(t1, '111', 1)
    pn.UT_EQUAL(#d, 168)

    d = ut.dump_table(t1, '222', 2)
    pn.UT_EQUAL(#d, 251)

    d = ut.dump_table(t1, '333', 3)
    pn.UT_EQUAL(#d, 321)

    d = ut.dump_table(t1, '444', 4)
    pn.UT_EQUAL(#d, 321)

end

function M.suite_misc(pn)

    local res = ut.ternary(5 > 4, 100, 200)
    pn.UT_EQUAL(res, 100)

    ut.set_colorize( { ['red']=91, ['green']=92, ['blue']=94, ['yellow']=33, ['gray']=95, ['bred']=41 } )

    -- res = ut.colorize_text('blabla')
    -- pn.UT_STR_EQUAL(res, 'blabla')

end

-----------------------------------------------------------------------------
-- Return the module.
return M
