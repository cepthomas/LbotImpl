
local sx = require("stringex")
local tx = require("tableex")
local ut = require("lbot_utils")


local M = {}


-----------------------------------------------------------------------------
function M.setup(pn)
    -- pn.UT_INFO("setup()!!!")
end

-----------------------------------------------------------------------------
function M.teardown(pn)
    -- pn.UT_INFO("teardown()!!!")
end


------------------------------ System ---------------------------------------
function M.suite_system(pn)

    accidental_global = 0
    local extraneous, unused = ut.check_globals( { 'appglob1', 'appglob2', 'appglob3'})
    -- print(tx.dump_table_string(extraneous, 1, 'extraneous'))
    -- print(tx.dump_table_string(unused, 1, 'unused'))

    ut.fix_lua_path('/mypath')
    -- print(package.path)
    pn.UT_STR_CONTAINS(package.path, 'mypath')

    local res = ut.execute_and_capture('dir')
    pn.UT_STR_CONTAINS(res, 'test_utils.lua')

    local fpath, line, dir = ut.get_caller_info(0)
    -- print(0, fpath, line, dir)
    -- 0   [C] -1  

    fpath, line, dir = ut.get_caller_info(1)
    -- print(1, fpath, line, dir)
    -- 1   C:\Dev\Libs\LbotImpl\LBOT\lbot_utils.lua    80  C:\Dev\Libs\LbotImpl\LBOT

    fpath, line, dir = ut.get_caller_info(2)
    -- print(2, fpath, line, dir)
    -- 2   C:\Dev\Libs\LbotImpl\test_lua\test_utils.lua    40  C:\Dev\Libs\LbotImpl\test_lua

    fpath, line, dir = ut.get_caller_info(3)
    -- print(3, fpath, line, dir)
    -- 3   [C] -1  

    fpath, line, dir = ut.get_caller_info(4)
    -- print(4, fpath, line, dir)
    -- 4   C:\Dev\Libs\LbotImpl\LBOT\pnut_runner.lua   56  C:\Dev\Libs\LbotImpl\LBOT

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
