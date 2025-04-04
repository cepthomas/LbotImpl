

-- (pseudo)objects
-- ---------------------
-- C:\Users\cepth\OneDrive\OneDriveDocuments\tech\lua\lua-oop.ntr -> # mixing closures with tables

-- So these are all equivalent:
-- obj:method(foo)
-- obj.method(obj, foo)
-- obj["method"] (obj, foo) 


-- My background (such as it is) has been in functional, rather than OOP coding, historically, so I guess I’m more
-- comfortable running arrays through functions, rather than creating objects with their own encapsulated properties
-- and methods (though I also understand some of the advantages of this approach).


------------------------------------------------------------

-- http://www.luafaq.org/#T1.28

-- The problem with not having a 'canonical' OOP scheme comes when integrating Lua code that uses an incompatible scheme. 
-- Then all you can assume is that an object can be called with a:f() notation. Re-use of classes via inheritance is only 
-- possible if you know how that class is structured. This can be considered a problem that hinders adoption of classic OOP style in Lua.

-- If inheritance is not an issue, the following pattern is a quick way to create 'fat objects':

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



------------------------------------------------------------

-- https://www.reddit.com/r/lua/comments/tia21g/really_how_best_to_give_lua_an_objectclass/i1dok2a

Foo = {}

function Foo.new(args)

  -- private fields
  local field1 = 42
  local field2 = "string"

  -- private method
  local function private_method (arg) return "private_method" end

  local o = {}

  -- public field
  o.public_field = "hello"

  -- public method
  function o:method (arg) return "method" end

  -- public method to access a private field
  function o:get_field1 () return field1 end

  -- return the object
  return o
end



-- also:

Ratio = {}

Ratio.add = function (left, right)
  local gcd = function (m, n)
    while n ~= 0 do
      local q = m
      m = n
      n = q % n
    end
    return m
  end

  local lcm = function (m, n)
    return ( m ~= 0 and n ~= 0 ) and m * n / gcd( m, n ) or 0
  end

  local l = left.to_pair()
  local r = right.to_pair()
  local m = lcm(l[2], r[2])
  local new = (l[1] * (m / l[2])) + (r[1] * (m / r[2]))

  -- Not reducing the ratio to keep illustration simpler.
  return Ratio(new .. "/" .. m)
end

setmetatable(Ratio, 
  { 
    __call = 
    function (self, s)

      -- "Internal" variables, hidden via closure
      local numerator
      local denominator

      -- The type to return
      local t = {}

      -- Metatable implementations
      local meta = {
        __tostring = function (self) return numerator .. "/" .. denominator end,
        __metatable = "Ratio type",
        __add = function (left, right) return Ratio.add(left, right) end,
        -- TODOx:  add math operator metamethod implementations
      }
  
      -- Set things up
      local split = string.find(s,"/")
      numerator = tonumber(string.sub(s,1,split - 1))
      denominator = tonumber(string.sub(s,split + 1,string.len(s)))

      -- Need a few things to get useful information out of the internal values
      t.to_pair  = function () return {numerator, denominator} end
      t.to_float = function () return numerator / denominator end
  
      setmetatable(t, meta)
      return t
  
    end
  })

------------------------------------------------------------
-- https://www.lua.org/pil/16.1.html  - Classes


Account = { balance = 0,
            withdraw = function (self, v)  self.balance = self.balance - v  end
          }

function Account:deposit (v)
  self.balance = self.balance + v
end

Account.deposit(Account, 200.00)
Account:withdraw(100.00)

function Account:new (o)
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


------------------------------------------------------------

-- https://notesbylex.com/object-prototypes.html

-- In Lua, object-oriented programming is achieved using prototypal inheritance, since Lua does not have the concept of a
-- class. Prototypal inheritance simply means that objects can refer to a "prototype" object which is looked up when any 
-- field doesn't exist in the first object. In Lua, this is achieved by using the __index Lua Table-Access Metamethods. 
-- In the example, I'm creating a Person table which will serve as a metatable for all instances of a Person:

local Person = {firstName='', lastName='', age=nil}

function Person:new(o)
    local o = o or {}
    setmetatable(self, o)
    self.__index = self
    return o
end

function Person:getName()
    return self.firstName..' '..self.lastName
end
--[[ ????
local me = Person:new({firstName='Lex', lastName='T', age=34})
print(me:getName())

-- I can then extend Person by creating a new object with modified parameters:
local PersonWithMiddleName = Person:new()
PersonWithMiddleName.middleName = ''

local me = PersonWithMiddleName({firstName='Lex', lastName='T', age=34, middleName='D'})

-- In that example, the me object will be consulted for fields. If they aren't found, PersonWithMiddleName will be looked up. 
-- If not found, since it uses Person as the __index metatable, Person will then be consulted.Javascript also uses prototypal
-- inheritance at the core of its object-oriented paradigm.
]]

------------------- my impl -----------------------------------------

AccountXXX = { balance = 0,
           -- withdraw = function (self, v)  self.balance = self.balance - v  end
          }

function AccountXXX:deposit (v)
    self.balance = self.balance + v
end

function AccountXXX:withdraw (v)
    self.balance = self.balance - v
end

function AccountXXX:balance (v)
    self.balance = self.balance - v
end


function AccountXXX:new (o)
    o = o or {}   -- create object if user does not provide one
    setmetatable(o, self)
    self.__index = self
    return o
end

a = AccountXXX:new{balance = 0}
a:deposit(100.00)
a:withdraw(32.4)
print('>>> '..a.balance)    --> 0


-- AccountXXX.deposit(a, 100.00)

-- b = AccountXXX:new()
-- print(b.balance)    --> 0

-- When we call the deposit method on b, it runs the equivalent of
-- b.balance = b.balance + v



------------------- current class -----------------------------------
require 'class'

-- the class
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

-- inherit
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


local fido = Dog('Fido')
local felix = Cat('Felix', 'Tabby')
local leo = Lion('Leo', 'African')

print(tostring(fido))
print(tostring(felix))
print(tostring(leo))

print(tostring(leo:is_a(Animal))..' -> true')
print(tostring(leo:is_a(Dog))..' -> false')
print(tostring(leo:is_a(Cat))..' -> true')


------------------ test ------------------------------------------

-- l1 = list:new()
-- l1:len()
-- l1:insert(2, o)

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
