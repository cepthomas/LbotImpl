
require 'class'
tx = require 'tableex'


--[[ (pseudo)objects
-- ---------------------
-- C:\Users\cepth\OneDrive\OneDriveDocuments\tech\lua\lua-oop.ntr -> # mixing closures with tables

People get confused on this because of the obj:method syntax, but it's a clever lie. In Lua, obj:method isn't a 
language feature; objects don't exist. It's just syntactic sugar over the tbl.key form of table access with an 
implicit first argument, which itself is syntactic sugar over tbl["key"].

So these are all equivalent:
obj:method(foo)
obj.method(obj, foo)
obj["method"] (obj, foo) 

And they all work because functions are first class, which means you can create "methods" by binding functions to table keys. 
So, like the above, these are equivalent for creating methods to an "object":
obj = {}
function obj:method(foo) ... end
function obj.method(self,foo) ... end
obj["method"] = function (self, foo) ... end

You can use metatables to do fancier things like build your own inheritance systems and control access to parts of it, 
but ultimately the above is what you're dealing with in Lua when working with "objects": a table that has "fields" 
(keys of data) and "methods" (keys of functions) that are fully public and can be manipulated freely. You can even 
pretend you have classes by making a Foo:new() that constructs one of these table objects and returns it.

    __index: The indexing access operation table[key]. This event happens when table is not a table or when key is not present in table. 
    The metavalue is looked up in the metatable of table.
    The metavalue for this event can be either a function, a table, or any value with an __index metavalue. 
    If it is a function, it is called with table and key as arguments, and the result of the call (adjusted to one value) 
    is the result of the operation. Otherwise, the final result is the result of indexing this metavalue with key. This indexing 
    is regular, not raw, and therefore can trigger another __index metavalue.

    __newindex: The indexing assignment table[key] = value. Like the index event, this event happens when table is not a table or when 
    key is not present in table. The metavalue is looked up in the metatable of table.
    Like with indexing, the metavalue for this event can be either a function, a table, or any value with an __newindex metavalue. 
    If it is a function, it is called with table, key, and value as arguments. Otherwise, Lua repeats the indexing assignment over 
    this metavalue with the same key and value. This assignment is regular, not raw, and therefore can trigger another __newindex metavalue.
    Whenever a __newindex metavalue is invoked, Lua does not perform the primitive assignment. If needed, the metamethod itself can call 
    rawset to do the assignment.

    __call: The call operation func(args). This event happens when Lua tries to call a non-function value (that is, func is not a function). 
    The metamethod is looked up in func. If present, the metamethod is called with func as its first argument, followed by the arguments 
    of the original call (args). All results of the call are the results of the operation. This is the only metamethod that allows multiple results.

My background (such as it is) has been in functional, rather than OOP coding, historically, so I guess I’m more
comfortable running arrays through functions, rather than creating objects with their own encapsulated properties
and methods (though I also understand some of the advantages of this approach).

also -- >>>>>>>>>>>>>>>>>>>>> https://www.reddit.com/r/lua/comments/tia21g/comment/i1dok2a/

]]


------------------ mine ------------------------------------------



-- l1 = list:new()
-- l1:len()
-- l1:insert(2, o)


-- function MyList(t)
--     local name = n
--     local o = t -- this is our storage

function MyList(n)
    local name = n
    local o = {} -- this is our storage
    local num = 0

    function o:setName(n)
        name = n
    end

    function o:getName()
        return name
    end

    function o:len()
        return name
    end

    return o
end

o = MyList('fido')
print('+++ fido '..o:getName())
o:setName('bonzo')
print('+++ bonzo '..o:getName())




function MyObject(n)
    local name = n -- this is our field
    local obj = {}  -- this is our object

    function obj:setName(n)
        name = n
    end

    function obj:getName()
        return name
    end

    return obj
end

o = MyObject('fido')
print('+++ fido '..o:getName())
o:setName('bonzo')
print('+++ bonzo '..o:getName())





------------------------------------------------------------

--[[ http://www.luafaq.org/#T1.28

The problem with not having a 'canonical' OOP scheme comes when integrating Lua code that uses an incompatible scheme. 
Then all you can assume is that an object can be called with a:f() notation. Re-use of classes via inheritance is only 
possible if you know how that class is structured. This can be considered a problem that hinders adoption of classic OOP style in Lua.

If inheritance is not an issue, the following pattern is a quick way to create 'fat objects':

function MyObject(n)
    local name -- this is our field
    local obj = {}  -- this is our object

    function obj:setName(n)
        name = n
    end

    function obj:getName()
        return name
    end

    return obj
end

o = MyObject 'fido'
o:getName()
-- fido
o:setName 'bonzo'
o:getName()
-- bonzo

]]

------------------------------------------------------------
-- https://www.lua.org/pil/16.1.html  - Classes

--[[

Account = { balance = 0,
            withdraw = function (self, v)  self.balance = self.balance - v  end
          }

function Account:deposit(v)
  self.balance = self.balance + v
end

Account.deposit(Account, 200.00)
Account:withdraw(100.00)

function Account:new(o)
  o = o or {}   -- create object if user does not provide one
  setmetatable(o, self)
  self.__index = self
  return o
end

a = Account:new{balance = 0}
a:deposit(100.00)


Account.deposit(a, 100.00)

b = Account:new()
print(b.balance)    --> 0

-- When we call the deposit method on b, it runs the equivalent of
-- b.balance = b.balance + v

]]

---------------------- prototype --------------------------------------

--[[

-- https://notesbylex.com/object-prototypes.html

-- In Lua, object-oriented programming is achieved using prototypal inheritance, since Lua does not have the concept of a
-- class. Prototypal inheritance simply means that objects can refer to a "prototype" object which is looked up when any 
-- field doesn't exist in the first object. In Lua, this is achieved by using the __index Lua Table-Access Metamethods. 
-- In the example, I'm creating a Person table which will serve as a metatable for all instances of a Person:

local Person = { firstName='', lastName='', age=nil }

function Person:getName()
    return self.firstName..' '..self.lastName
end

function Person:new(o)
    local o = o or {}
    setmetatable(self, o)
    self.__index = self
    return o
end

print(tx.dump_table_string(Person, 1, 'Person'))

local me = Person:new({ firstName='Lex', lastName='T', age=34 })
print(tx.dump_table_string(me, 1, 'me'))
-- print(me:getName())

-- I can then extend Person by creating a new object with modified parameters:
local PersonWithMiddleName = Person:new()
PersonWithMiddleName.middleName = ''

local me = PersonWithMiddleName({ firstName='Lex', lastName='T', age=34, middleName='D' })
print(tx.dump_table_string(me, 1, 'me'))

-- In that example, the me object will be consulted for fields. If they aren't found, PersonWithMiddleName will be looked up. 
-- If not found, since it uses Person as the __index metatable, Person will then be consulted. Javascript also uses prototypal
-- inheritance at the core of its object-oriented paradigm.

]]

------------------- prototype impl -----------------------------------------


--[[

AccountXXX = { balance = 0,
           -- withdraw = function (self, v)  self.balance = self.balance - v  end
          }

function AccountXXX:deposit(v)
    print(tx.dump_table_string(self, 1, 'self1'))
    self.balance = self.balance + v
end

function AccountXXX:withdraw(v)
    self.balance = self.balance - v
end

-- function AccountXXX:balance(v)
--     self.balance = self.balance - v
-- end

function AccountXXX:get_balance()
    print(tx.dump_table_string(self, 1, 'self2'))
    print('>>>4 '..self)    --> 77.6
    return self.balance
end


function AccountXXX:new(o)
    o = o or {}   -- create object if user does not provide one
    setmetatable(o, self)
    self.__index = self
    return o
end

-- test
a = AccountXXX:new({ balance = 10 })
a:deposit(100.00)
a:withdraw(32.4)
print(tx.dump_table_string(a, 1, 'a'))

print('>>>1 '..a.balance)    --> 77.6
print('>>>2 '..a.get_balance())    --> 77.6


-- AccountXXX.deposit(a, 100.00)

-- b = AccountXXX:new()
-- print(b.balance)    --> 0

-- When we call the deposit method on b, it runs the equivalent of
-- b.balance = b.balance + v

]]


------------------- current class.lua -----------------------------------

-- http://lua-users.org/wiki/SimpleLuaClasses

----- simple
AccountYYY = class(function(acc,balance)
              acc.balance = balance
           end)

function AccountYYY:withdraw(amount)
   self.balance = self.balance - amount
end

-- can create an AccountYYY using call notation!
acc = AccountYYY(1000)
acc:withdraw(100)



------ inheritance
local Animal = class(
    function(a, name)
        a.name = name
    end)

function Animal:__tostring()
    return self.name..': '..self:speak()
end

-- instance
Dog = class(Animal)

function Dog:speak()
    return 'dog bark'
end

-- simple inheritance
Cat = class(Animal,
    function(c, name, breed)
        Animal.__init(c, name) -- must init base!
        c.breed = breed
    end)

function Cat:speak()
    return 'cat meow'
end

-- instance
Lion = class(Cat)

function Lion:speak()
    return 'lion roar'
end

-- test
local fido = Dog('Fido')
local felix = Cat('Felix', 'Tabby')
local leo = Lion('Leo', 'African')

print(tostring(fido))
print(tostring(felix))
print(tostring(leo))

print(tostring(leo:is_a(Animal))..' -> true')
print(tostring(leo:is_a(Dog))..' -> false')
print(tostring(leo:is_a(Cat))..' -> true')



------------------ stuff ------------------------------------------

--[[
    __index: The indexing access operation table[key]. This event happens when table is not a table or when key is not present in table. 
    The metavalue is looked up in the metatable of table.
    The metavalue for this event can be either a function, a table, or any value with an __index metavalue. 
    If it is a function, it is called with table and key as arguments, and the result of the call (adjusted to one value) 
    is the result of the operation. Otherwise, the final result is the result of indexing this metavalue with key. This indexing 
    is regular, not raw, and therefore can trigger another __index metavalue.

    __newindex: The indexing assignment table[key] = value. Like the index event, this event happens when table is not a table or when 
    key is not present in table. The metavalue is looked up in the metatable of table.
    Like with indexing, the metavalue for this event can be either a function, a table, or any value with an __newindex metavalue. 
    If it is a function, it is called with table, key, and value as arguments. Otherwise, Lua repeats the indexing assignment over 
    this metavalue with the same key and value. This assignment is regular, not raw, and therefore can trigger another __newindex metavalue.
    Whenever a __newindex metavalue is invoked, Lua does not perform the primitive assignment. If needed, the metamethod itself can call 
    rawset to do the assignment.

    __call: The call operation func(args). This event happens when Lua tries to call a non-function value (that is, func is not a function). 
    The metamethod is looked up in func. If present, the metamethod is called with func as its first argument, followed by the arguments 
    of the original call (args). All results of the call are the results of the operation. This is the only metamethod that allows multiple results.


    __add: the addition (+) operation. If any operand for an addition is not a number, Lua will try to call a metamethod. It starts by checking the first operand (even if it is a number); if that operand does not define a metamethod for __add, then Lua will check the second operand. If Lua can find a metamethod, it calls the metamethod with the two operands as arguments, and the result of the call (adjusted to one value) is the result of the operation. Otherwise, if no metamethod is found, Lua raises an error.
    __sub: the subtraction (-) operation. Behavior similar to the addition operation.
    __mul: the multiplication (*) operation. Behavior similar to the addition operation.
    __div: the division (/) operation. Behavior similar to the addition operation.
    __mod: the modulo (%) operation. Behavior similar to the addition operation.
    __pow: the exponentiation (^) operation. Behavior similar to the addition operation.
    __unm: the negation (unary -) operation. Behavior similar to the addition operation.
    __idiv: the floor division (//) operation. Behavior similar to the addition operation.
    __band: the bitwise AND (&) operation. Behavior similar to the addition operation, except that Lua will try a metamethod if any operand is neither an integer nor a float coercible to an integer (see §3.4.3).
    __bor: the bitwise OR (|) operation. Behavior similar to the bitwise AND operation.
    __bxor: the bitwise exclusive OR (binary ~) operation. Behavior similar to the bitwise AND operation.
    __bnot: the bitwise NOT (unary ~) operation. Behavior similar to the bitwise AND operation.
    __shl: the bitwise left shift (<<) operation. Behavior similar to the bitwise AND operation.
    __shr: the bitwise right shift (>>) operation. Behavior similar to the bitwise AND operation.
    __concat: the concatenation (..) operation. Behavior similar to the addition operation, except that Lua will try a metamethod if any operand is neither a string nor a number (which is always coercible to a string).
    __len: the length (#) operation. If the object is not a string, Lua will try its metamethod. If there is a metamethod, Lua calls it with the object as argument, and the result of the call (always adjusted to one value) is the result of the operation. If there is no metamethod but the object is a table, then Lua uses the table length operation (see §3.4.7). Otherwise, Lua raises an error.
    __eq: the equal (==) operation. Behavior similar to the addition operation, except that Lua will try a metamethod only when the values being compared are either both tables or both full userdata and they are not primitively equal. The result of the call is always converted to a boolean.
    __lt: the less than (<) operation. Behavior similar to the addition operation, except that Lua will try a metamethod only when the values being compared are neither both numbers nor both strings. Moreover, the result of the call is always converted to a boolean.
    __le: the less equal (<=) operation. Behavior similar to the less than operation.

]]
