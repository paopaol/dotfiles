local M = {}

local foo = function(x) return 2 * x end

print(foo(3))

local network = {
  {name = "grauna", ip = "210.26.30.34"},
  {name = "arraial", ip = "210.26.30.23"}, {name = "lua", ip = "210.26.23.12"},
  {name = "derain", ip = "210.26.23.20"}
}

table.sort(network, function(a, b) return a.name < b.name end)

local function derivative(f, delta)
  delta = delta or 1e-4
  return function(x) return (f(x + delta) - f(x) / delta) end
end

local result = derivative(function(x) return math.sin(x) end, 7)
print(result(3))

local names = {"peter", "paul", "mary"}
local grades = {mary = 10, paul = 7, peter = 8}

table.sort(names, function(a, b) return grades[a] > grades[b] end)

local function newCounter()
  local i = 0
  return function()
    i = i + 1
    return i
  end
end

local c = newCounter();
print(c())
print(c())

print(math.sin(100))
do
  local old_sin = math.sin
  local k = math.pi / 180

  math.sin = function(x) return old_sin(x * k) end
end
print(math.sin(100))
