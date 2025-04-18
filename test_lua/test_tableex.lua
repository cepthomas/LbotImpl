-- Unit tests for tableex.lua.

local ut = require("lbot_utils")
local tx = require("tableex")


local M = {}


-- -----------------------------------------------------------------------------
-- function M.setup(pn)
--     -- print("setup()!!!")
-- end

-- -----------------------------------------------------------------------------
-- function M.teardown(pn)
--     -- print("teardown()!!!")
-- end




-- __tostring = function(self) return string.format('%s:(%s:%s)[%d] "%s"',
-- function dd:add_range(other)
-- function dd:class() return getmetatable(dd).class end
-- function dd:clear()
-- function dd:contains_value(tbl, val)
-- function dd:copy(tbl)
-- function dd:count()
-- function dd:key_type() return getmetatable(dd).key_type end
-- function dd:keys()
-- function dd:name() return getmetatable(dd).name end
-- function dd:value_type() return getmetatable(dd).value_type end
-- function dd:values()
-- function Tableex(t, name)


-----------------------------------------------------------------------------
function M.suite_xxx_table(pn)

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

-----------------------------------------------------------------------------
-- Return the module.
return M
