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



-- TODOL test these:
-- __tostring = function(self) return string.format('%s:(%s:%s)[%d] "%s"',
-- class() return getmetatable(dd).class end
-- key_type() return getmetatable(dd).key_type end
-- name() return getmetatable(dd).name end
-- value_type() return getmetatable(dd).value_type end
-- add_range(other)
-- clear()
-- contains_value(tbl, val)
-- copy(tbl)
-- count()
-- keys()
-- values()
-- leex(t, name)



-----------------------------------------------------------------------------
-- function M.suite_table(pn)

--     -- Test dump_table().
--     local t1 = { aa="pt1", bb=90901, alist={ "qwerty", 777, temb1={ jj="pt8", b=true, temb2={ num=1.517, dd="strdd" } }, intx=5432}}

--     local d = ut.dump_table(t1, '000', 0)
--     pn.UT_EQUAL(#d, 70)
--     -- print(d)

--     d = ut.dump_table(t1, '111', 1)
--     pn.UT_EQUAL(#d, 168)

--     d = ut.dump_table(t1, '222', 2)
--     pn.UT_EQUAL(#d, 251)

--     d = ut.dump_table(t1, '333', 3)
--     pn.UT_EQUAL(#d, 321)

--     d = ut.dump_table(t1, '444', 4)
--     pn.UT_EQUAL(#d, 321)

-- end

-----------------------------------------------------------------------------
-- Return the module.
return M
