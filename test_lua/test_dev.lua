
local dev = require("dev_1")
local ut = require("lbot_utils")

-- print('_G:', ut.dump_table(_G, '_G'))


local acc = Account1

-- client create and use an Account
local acc_bob = acc:create('bob_name', 1000)
print('10', 'bob got:', acc_bob:getbalance())
acc_bob:withdraw(100)
print('15', 'bob got:', acc_bob:getbalance())

acc_bob['added'] = 1234

print('20', 'acc_bob:', acc_bob)

-- print('25', 'acc_bob:', acc_bob, ut.dump_table(acc_bob, 'acc_bob table'))
print('30', acc_bob:name(), acc_bob, ut.dump_table(acc_bob, acc_bob:name()))

-- print('I got:', acc_bob:getbalance())

local acc_mary = acc:create('mary_name', 1234)
print('35', 'mary got:', acc_mary.balance)
print('40', 'mary got:', acc_mary:getbalance())

print('45', 'acc_mary:', acc_mary)
print('50', 'acc_bob:', acc_bob)


------------------------------  Measure object sizes. ---------------------------
-- st = collectgarbage('count')
-- print('start', st)

-- store = {}
-- for i = 1, 10000 do
--     local a = Account1:create('bob_'..tostring(i), 1000)
--     table.insert(store, a)
-- end
-- local stn = collectgarbage('count')
-- print('Account1 took', stn - st, stn)
-- st = stn

-- for i = 1, 10000 do
--     local a = Account2:create('bob_'..tostring(i), 1000)
--     table.insert(store, a)
-- end
-- stn = collectgarbage('count')
-- print('Account2 took', stn - st, stn)
-- st = stn

-- store = {}
-- stn = collectgarbage()

-- stn = collectgarbage('count')
-- print('GC took', stn - st, stn)
-- st = stn
