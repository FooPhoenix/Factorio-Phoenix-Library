
-- ██████████████████████████████████████████████████████████████████████████████████████████████████████████████████ --
-- ██▛▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▜██ --
-- ██▌ Phoenix Library - Debug - Assertions.                                                                      ▐██ --
-- ██▙▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▟██ --
-- ██████████████████████████████████████████████████████████████████████████████████████████████████████████████████ --

-- ▛▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▜ --
-- ▌ Internal Functions.                                                                                            ▐ --
-- ▙▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▟ --

---
--- ### This function throws the standard error message for a type mismatch.<br>
---
--- -----
--- @param expected string The expected type label.
--- @param received string The received runtime type.
--- @param is_optional boolean? Whether the value is optional. Defaults to `false`.
--- @param index index? The index of the argument if available.
---
--- *no return*
---
--
local function throwSimpleError(expected, received, is_optional, index)

    local mindex, moptional             ---@type string

    if is_optional == true then
        moptional = " optional"
    else
        moptional = ""
    end

    if type(index) == 'number' then
        mindex = "For the argument #" .. index .. " : "
    else
        mindex = ""
    end

    error(mindex .. "The expected type for this" .. moptional .. " value is '" .. expected .. "', actually got '" .. received .. "' instead.", 3)
end

-- ▛▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▜ --
-- ▌ Declaration.                                                                                                   ▐ --
-- ▙▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▟ --

-- ╔══════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗ --
-- ║ Dependencies.                                                                                                    ║ --
-- ╚══════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝ --

local libExtendedTypes = require('SubLibraries.extended_types')

-- ╔════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗ --
-- ║ Command Shortcuts.                                                                                             ║ --
-- ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝ --

local pairs  = pairs
local ipairs = ipairs
local type   = type
local select = select
local floor  = math.floor
local error  = error

-- ╔════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗ --
-- ║ Classes.                                                                                                       ║ --
-- ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝ --

-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓ --
-- ┃ DebugAssert Class.                                                                                             ┃ --
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛ --

---
--- @class DebugAssert
---
--- ### This class groups all functions used for assertions.<br>
--- [*DEBUG ONLY*]
---
--
local DebugAssert = { }

-- ▛▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▜ --
-- ▌ Implementation.                                                                                                ▐ --
-- ▙▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▟ --


-- #region Assert native types -                                                                                     --

-- ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐ --
-- │ Boolean assert section.                                                                                        │ --
-- └────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘ --

--- ### This function asserts that the provided value is a `boolean`.<br>
---
--- -----
--- @param value any The value to check.
---
--- @return boolean # Returns `true` if the value is a boolean; otherwise throws an error.
---
--
function DebugAssert.isBoolean(value)
    if type(value) ~= 'boolean' then
        throwSimpleError('boolean', type(value))
    end

    return true
end

-- ────────────────────────────────────────────────────────────────────────────────────────────────────────────────── --

--- ### This function asserts that all provided values are `boolean`.<br>
---
--- -----
--- @param ... any The values to check.
---
--- @return boolean # Returns `true` if all values are booleans; otherwise throws an error.
---
--
function DebugAssert.areBoolean(...)

    local arg_count = select('#', ...)
    local args      = { ... }

    for index = 1, arg_count do
        if type(args[index]) ~= 'boolean' then
            throwSimpleError('boolean', type(args[index]), false, index)
        end
    end

    return true
end

-- ────────────────────────────────────────────────────────────────────────────────────────────────────────────────── --

--- ### This function asserts that the provided value is a `boolean` or `nil`.<br>
---
--- -----
--- @param value any The value to check.
---
--- @return boolean # Returns `true` if the value is a boolean or nil; otherwise throws an error.
---
--
function DebugAssert.isOptionalBoolean(value)
    if value ~= nil and type(value) ~= 'boolean' then
        throwSimpleError('boolean', type(value), true)
    end

    return true
end

-- ────────────────────────────────────────────────────────────────────────────────────────────────────────────────── --

--- ### This function asserts that all provided values are `boolean` or `nil`.<br>
---
--- -----
--- @param ... any The values to check.
---
--- @return boolean # Returns `true` if all values are booleans or nil; otherwise throws an error.
---
--
function DebugAssert.areOptionalBoolean(...)

    local arg_count = select('#', ...)
    local args      = { ... }

    for index = 1, arg_count do
        if args[index] ~= nil and type(args[index]) ~= 'boolean' then
            throwSimpleError('boolean', type(args[index]), true, index)
        end
    end

    return true
end

-- ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐ --
-- │ Number assert section.                                                                                         │ --
-- └────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘ --

--- ### This function asserts that the provided value is a `number`.<br>
---
--- -----
--- @param value any The value to check.
---
--- @return boolean # Returns `true` if the value is a number; otherwise throws an error.
---
--
function DebugAssert.isNumber(value)
    if type(value) ~= 'number' then
        throwSimpleError('number', type(value))
    end

    return true
end

-- ────────────────────────────────────────────────────────────────────────────────────────────────────────────────── --

--- ### This function asserts that all provided values are `number`.<br>
---
--- -----
--- @param ... any The values to check.
---
--- @return boolean # Returns `true` if all values are numbers; otherwise throws an error.
---
--
function DebugAssert.areNumber(...)

    local arg_count = select('#', ...)
    local args      = { ... }

    for index = 1, arg_count do
        if type(args[index]) ~= 'number' then
            throwSimpleError('number', type(args[index]), false, index)
        end
    end

    return true
end

-- ────────────────────────────────────────────────────────────────────────────────────────────────────────────────── --

--- ### This function asserts that the provided value is a `number` or `nil`.<br>
---
--- -----
--- @param value any The value to check.
---
--- @return boolean # Returns `true` if the value is a number or nil; otherwise throws an error.
---
--
function DebugAssert.isOptionalNumber(value)
    if value ~= nil and type(value) ~= 'number' then
        throwSimpleError('number', type(value), true)
    end

    return true
end

-- ────────────────────────────────────────────────────────────────────────────────────────────────────────────────── --

--- ### This function asserts that all provided values are `number` or `nil`.<br>
---
--- -----
--- @param ... any The values to check.
---
--- @return boolean # Returns `true` if all values are numbers or nil; otherwise throws an error.
---
--
function DebugAssert.areOptionalNumber(...)

    local arg_count = select('#', ...)
    local args      = { ... }

    for index = 1, arg_count do
        if args[index] ~= nil and type(args[index]) ~= 'number' then
            throwSimpleError('number', type(args[index]), true, index)
        end
    end

    return true
end

-- ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐ --
-- │ String assert section.                                                                                         │ --
-- └────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘ --

--- ### This function asserts that the provided value is a `string`.<br>
---
--- -----
--- @param value any The value to check.
---
--- @return boolean # Returns `true` if the value is a string; otherwise throws an error.
---
--
function DebugAssert.isString(value)
    if type(value) ~= 'string' then
        throwSimpleError('string', type(value))
    end

    return true
end

-- ────────────────────────────────────────────────────────────────────────────────────────────────────────────────── --

--- ### This function asserts that all provided values are `string`.<br>
---
--- -----
--- @param ... any The values to check.
---
--- @return boolean # Returns `true` if all values are strings; otherwise throws an error.
---
--
function DebugAssert.areString(...)

    local arg_count = select('#', ...)
    local args      = { ... }

    for index = 1, arg_count do
        if type(args[index]) ~= 'string' then
            throwSimpleError('string', type(args[index]), false, index)
        end
    end

    return true
end

-- ────────────────────────────────────────────────────────────────────────────────────────────────────────────────── --

--- ### This function asserts that the provided value is a `string` or `nil`.<br>
---
--- -----
--- @param value any The value to check.
---
--- @return boolean # Returns `true` if the value is a string or nil; otherwise throws an error.
---
--
function DebugAssert.isOptionalString(value)
    if value ~= nil and type(value) ~= 'string' then
        throwSimpleError('string', type(value), true)
    end

    return true
end

-- ────────────────────────────────────────────────────────────────────────────────────────────────────────────────── --

--- ### This function asserts that all provided values are `string` or `nil`.<br>
---
--- -----
--- @param ... any The values to check.
---
--- @return boolean # Returns `true` if all values are strings or nil; otherwise throws an error.
---
--
function DebugAssert.areOptionalString(...)

    local arg_count = select('#', ...)
    local args      = { ... }

    for index = 1, arg_count do
        if args[index] ~= nil and type(args[index]) ~= 'string' then
            throwSimpleError('string', type(args[index]), true, index)
        end
    end

    return true
end

-- ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐ --
-- │ Table assert section.                                                                                          │ --
-- └────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘ --

--- ### This function asserts that the provided value is a `table`.<br>
---
--- -----
--- @param value any The value to check.
---
--- @return boolean # Returns `true` if the value is a table; otherwise throws an error.
---
--
function DebugAssert.isTable(value)
    if type(value) ~= 'table' then
        throwSimpleError('table', type(value))
    end

    return true
end

-- ────────────────────────────────────────────────────────────────────────────────────────────────────────────────── --

--- ### This function asserts that all provided values are `table`.<br>
---
--- -----
--- @param ... any The values to check.
---
--- @return boolean # Returns `true` if all values are tables; otherwise throws an error.
---
--
function DebugAssert.areTable(...)

    local arg_count = select('#', ...)
    local args      = { ... }

    for index = 1, arg_count do
        if type(args[index]) ~= 'table' then
            throwSimpleError('table', type(args[index]), false, index)
        end
    end

    return true
end

-- ────────────────────────────────────────────────────────────────────────────────────────────────────────────────── --

--- ### This function asserts that the provided value is a `table` or `nil`.<br>
---
--- -----
--- @param value any The value to check.
---
--- @return boolean # Returns `true` if the value is a table or nil; otherwise throws an error.
---
--
function DebugAssert.isOptionalTable(value)
    if value ~= nil and type(value) ~= 'table' then
        throwSimpleError('table', type(value), true)
    end

    return true
end

-- ────────────────────────────────────────────────────────────────────────────────────────────────────────────────── --

--- ### This function asserts that all provided values are `table` or `nil`.<br>
---
--- -----
--- @param ... any The values to check.
---
--- @return boolean # Returns `true` if all values are tables or nil; otherwise throws an error.
---
--
function DebugAssert.areOptionalTable(...)

    local arg_count = select('#', ...)
    local args      = { ... }

    for index = 1, arg_count do
        if args[index] ~= nil and type(args[index]) ~= 'table' then
            throwSimpleError('table', type(args[index]), true, index)
        end
    end

    return true
end

-- ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐ --
-- │ Function assert section.                                                                                       │ --
-- └────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘ --

--- ### This function asserts that the provided value is a `function`.<br>
---
--- -----
--- @param value any The value to check.
---
--- @return boolean # Returns `true` if the value is a function; otherwise throws an error.
---
--
function DebugAssert.isFunction(value)
    if type(value) ~= 'function' then
        throwSimpleError('function', type(value))
    end

    return true
end

-- ────────────────────────────────────────────────────────────────────────────────────────────────────────────────── --

--- ### This function asserts that all provided values are `function`.<br>
---
--- -----
--- @param ... any The values to check.
---
--- @return boolean # Returns `true` if all values are functions; otherwise throws an error.
---
--
function DebugAssert.areFunction(...)

    local arg_count = select('#', ...)
    local args      = { ... }

    for index = 1, arg_count do
        if type(args[index]) ~= 'function' then
            throwSimpleError('function', type(args[index]), false, index)
        end
    end

    return true
end

-- ────────────────────────────────────────────────────────────────────────────────────────────────────────────────── --

--- ### This function asserts that the provided value is a `function` or `nil`.<br>
---
--- -----
--- @param value any The value to check.
---
--- @return boolean # Returns `true` if the value is a function or nil; otherwise throws an error.
---
--
function DebugAssert.isOptionalFunction(value)
    if value ~= nil and type(value) ~= 'function' then
        throwSimpleError('function', type(value), true)
    end

    return true
end

-- ────────────────────────────────────────────────────────────────────────────────────────────────────────────────── --

--- ### This function asserts that all provided values are `function` or `nil`.<br>
---
--- -----
--- @param ... any The values to check.
---
--- @return boolean # Returns `true` if all values are functions or nil; otherwise throws an error.
---
--
function DebugAssert.areOptionalFunction(...)

    local arg_count = select('#', ...)
    local args      = { ... }

    for index = 1, arg_count do
        if args[index] ~= nil and type(args[index]) ~= 'function' then
            throwSimpleError('function', type(args[index]), true, index)
        end
    end

    return true
end

-- ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐ --
-- │ Nil assert section.                                                                                            │ --
-- └────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘ --

--- ### This function asserts that the provided value is `nil`.<br>
---
--- -----
--- @param value any The value to check.
---
--- @return boolean # Returns `true` if the value is nil; otherwise throws an error.
---
--
function DebugAssert.isNil(value)
    if value ~= nil then
        throwSimpleError('nil', type(value))
    end

    return true
end

--- ### This function asserts that all provided values are `nil`.<br>
---
--- -----
--- @param ... any The values to check.
---
--- @return boolean # Returns `true` if all values are nil; otherwise throws an error.
---
--
function DebugAssert.areNil(...)

    local arg_count = select('#', ...)
    local args      = { ... }

    for index = 1, arg_count do
        if args[index] ~= nil then
            throwSimpleError('nil', type(args[index]), false, index)
        end
    end

    return true
end

-- ────────────────────────────────────────────────────────────────────────────────────────────────────────────────── --

--- ### This function asserts that the provided value is not `nil`.<br>
---
--- -----
--- @param value any The value to check.
---
--- @return boolean # Returns `true` if the value is not nil; otherwise throws an error.
---
--
function DebugAssert.isNotNil(value)
    if value == nil  then
        throwSimpleError('not nil', 'nil')
    end

    return true
end

--- ### This function asserts that all provided values are not `nil`.<br>
---
--- -----
--- @param ... any The values to check, or a table containing the values to check.
---
--- @return boolean # Returns `true` if all values are not nil; otherwise throws an error.
---
--
function DebugAssert.areNotNil(...)

    local arg_count = select('#', ...)
    local args      = { ... }

    if arg_count == 1 and type(args[1]) == 'table' then
        arg_count = #args[1]
        args = args[1]
    end

    for index = 1, arg_count do
        if args[index] == nil then
            throwSimpleError('not nil', 'nil', false, index)
        end
    end

    return true
end

-- #endregion --

-- #region Assert extended types -                                                                                   --

-- ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐ --
-- │ Integer assert section.                                                                                        │ --
-- └────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘ --

--- ### This function asserts that the provided value is an `integer`.<br>
---
--- -----
--- @param value any The value to check.
---
--- @return boolean # Returns `true` if the value is an integer; otherwise throws an error.
---
--
function DebugAssert.isInteger(value)
    if type(value) ~= 'number' or floor(value) ~= value then
        throwSimpleError('integer', type(value))
    end

    return true
end

-- ────────────────────────────────────────────────────────────────────────────────────────────────────────────────── --

--- ### This function asserts that all provided values are `integer`.<br>
---
--- -----
--- @param ... any The values to check.
---
--- @return boolean # Returns `true` if all values are integers; otherwise throws an error.
---
--
function DebugAssert.areInteger(...)

    local arg_count = select('#', ...)
    local args      = { ... }

    for index = 1, arg_count do
        if type(args[index]) ~= 'number' or floor(args[index]) ~= args[index] then
            throwSimpleError('integer', type(args[index]), false, index)
        end
    end

    return true
end

-- ────────────────────────────────────────────────────────────────────────────────────────────────────────────────── --

--- ### This function asserts that the provided value is an `integer` or `nil`.<br>
---
--- -----
--- @param value any The value to check.
---
--- @return boolean # Returns `true` if the value is an integer or nil; otherwise throws an error.
---
--
function DebugAssert.isOptionalInteger(value)
    if value ~= nil and (type(value) ~= 'number' or floor(value) ~= value) then
        throwSimpleError('integer', type(value), true)
    end

    return true
end

-- ────────────────────────────────────────────────────────────────────────────────────────────────────────────────── --

--- ### This function asserts that all provided values are `integer` or `nil`.<br>
---
--- -----
--- @param ... any The values to check.
---
--- @return boolean # Returns `true` if all values are integers or nil; otherwise throws an error.
---
--
function DebugAssert.areOptionalInteger(...)

    local arg_count = select('#', ...)
    local args      = { ... }

    for index = 1, arg_count do
        if args[index] ~= nil and (type(args[index]) ~= 'number' or floor(args[index]) ~= args[index]) then
            throwSimpleError('integer', type(args[index]), true, index)
        end
    end

    return true
end

-- ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐ --
-- │ Identifier assert section.                                                                                     │ --
-- └────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘ --

--- ### This function asserts that the provided value is an `identifier`.<br>
---
--- -----
--- @param value any The value to check.
---
--- @return boolean # Returns `true` if the value is an identifier; otherwise throws an error.
---
--
function DebugAssert.isIdentifier(value)

    if type(value) ~= "string" or value:match("^[_%a][_%w]*$") == nil then
        throwSimpleError("identifier", type(value))
    end

    return true
end

-- ────────────────────────────────────────────────────────────────────────────────────────────────────────────────── --

--- ### This function asserts that all provided values are `identifier`.<br>
---
--- -----
--- @param ... any The values to check.
---
--- @return boolean # Returns `true` if all values are identifiers; otherwise throws an error.
---
--
function DebugAssert.areIdentifier(...)

    local arg_count = select('#', ...)
    local args      = { ... }

    for index = 1, arg_count do
        if type(args[index]) ~= 'string' or args[index]:match("^[_%a][_%w]*$") == nil then
            throwSimpleError('identifier', type(args[index]), false, index)
        end
    end

    return true
end

-- ────────────────────────────────────────────────────────────────────────────────────────────────────────────────── --

--- ### This function asserts that the provided value is an `identifier` or `nil`.<br>
---
--- -----
--- @param value any The value to check.
---
--- @return boolean # Returns `true` if the value is an identifier or nil; otherwise throws an error.
---
--
function DebugAssert.isOptionalIdentifier(value)
    if value ~= nil and (type(value) ~= 'string' or value:match("^[_%a][_%w]*$") == nil) then
        throwSimpleError('identifier', type(value), true)
    end

    return true
end

-- ────────────────────────────────────────────────────────────────────────────────────────────────────────────────── --

--- ### This function asserts that all provided values are `identifier` or `nil`.<br>
---
--- -----
--- @param ... any The values to check.
---
--- @return boolean # Returns `true` if all values are identifiers or nil; otherwise throws an error.
---
--
function DebugAssert.areOptionalIdentifier(...)

    local arg_count = select('#', ...)
    local args      = { ... }

    for index = 1, arg_count do
        if args[index] ~= nil and (type(args[index]) ~= 'string' or args[index]:match("^[_%a][_%w]*$") == nil) then
            throwSimpleError('identifier', type(args[index]), true, index)
        end
    end

    return true
end

-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓ --
-- ┃ All Type assert section.                                                                                       ┃ --
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛ --

local type_category = libExtendedTypes.typeCategory
local type_lookup   = libExtendedTypes.types

-- ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐ --
-- │ Type assert section.                                                                                           │ --
-- └────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘ --

--- ### This function asserts that the provided value is a valid `type`.<br>
--- _Works only for native types._
---
--- -----
--- @param value any The value to check.
---
--- @return boolean # Returns `true` if the value is a valid `type`; otherwise throws an error.
---
--
function DebugAssert.isType(value)
    if type(value) ~= 'string' or type_lookup[value] ~= type_category.standard then
        throwSimpleError('type', type(value))
    end

    return true
end

-- ────────────────────────────────────────────────────────────────────────────────────────────────────────────────── --

--- ### This function asserts that all provided values are valid `type`.<br>
--- _Works only for native types._
---
--- -----
--- @param ... any The values to check.
---
--- @return boolean # Returns `true` if all values are valid `type`; otherwise throws an error.
---
--
function DebugAssert.areType(...)

    local arg_count = select('#', ...)
    local args      = { ... }

    for index = 1, arg_count do
        if type(args[index]) ~= 'string' or type_lookup[args[index]] ~= type_category.standard then
            throwSimpleError('type', type(args[index]), false, index)
        end
    end

    return true
end

-- ────────────────────────────────────────────────────────────────────────────────────────────────────────────────── --

--- ### This function asserts that the provided value is a valid `type` or `nil`.<br>
--- _Works only for native types._
---
--- -----
--- @param value any The value to check.
---
--- @return boolean # Returns `true` if the value is a valid `type` or `nil`; otherwise throws an error.
---
--
function DebugAssert.isOptionalType(value)
    if value ~= nil and (type(value) ~= 'string' or type_lookup[value] ~= type_category.standard) then
        throwSimpleError('type', type(value), true)
    end

    return true
end

-- ────────────────────────────────────────────────────────────────────────────────────────────────────────────────── --

--- ### This function asserts that all provided values are valid `type` or `nil`.<br>
--- _Works only for native types._
---
--- -----
--- @param ... any The values to check.
---
--- @return boolean # Returns `true` if all values are valid `type` or `nil`; otherwise throws an error.
---
--
function DebugAssert.areOptionalType(...)

    local arg_count = select('#', ...)
    local args      = { ... }

    for index = 1, arg_count do
        if args[index] ~= nil and (type(args[index]) ~= 'string' or type_lookup[args[index]] ~= type_category.standard) then
            throwSimpleError('type', type(args[index]), true, index)
        end
    end

    return true
end

-- ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐ --
-- │ TypeExtended assert section.                                                                                   │ --
-- └────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘ --

--- ### This function asserts that the provided value is a valid `typeExtended`.<br>
--- _Works only for extended types._
---
--- -----
--- @param value any The value to check.
---
--- @return boolean # Returns `true` if the value is a valid `typeExtended`; otherwise throws an error.
---
--
function DebugAssert.isTypeExtended(value)
    if type(value) ~= 'string' or type_lookup[value] ~= type_category.extended then
        throwSimpleError('typeExtended', type(value))
    end

    return true
end

-- ────────────────────────────────────────────────────────────────────────────────────────────────────────────────── --

--- ### This function asserts that all provided values are valid `typeExtended`.<br>
--- _Works only for extended types._
---
--- -----
--- @param ... any The values to check.
---
--- @return boolean # Returns `true` if all values are valid `typeExtended`; otherwise throws an error.
---
--
function DebugAssert.areTypeExtended(...)

    local arg_count = select('#', ...)
    local args      = { ... }

    for index = 1, arg_count do
        if type(args[index]) ~= 'string' or type_lookup[args[index]] ~= type_category.extended then
            throwSimpleError('typeExtended', type(args[index]), false, index)
        end
    end

    return true
end

-- ────────────────────────────────────────────────────────────────────────────────────────────────────────────────── --

--- ### This function asserts that the provided value is a valid `typeExtended` or `nil`.<br>
--- _Works only for extended types._
---
--- -----
--- @param value any The value to check.
---
--- @return boolean # Returns `true` if the value is a valid `typeExtended` or `nil`; otherwise throws an error.
---
--
function DebugAssert.isOptionalTypeExtended(value)
    if value ~= nil and (type(value) ~= 'string' or type_lookup[value] ~= type_category.extended) then
        throwSimpleError('typeExtended', type(value), true)
    end

    return true
end

-- ────────────────────────────────────────────────────────────────────────────────────────────────────────────────── --

--- ### This function asserts that all provided values are valid `typeExtended` or `nil`.<br>
--- _Works only for extended types._
---
--- -----
--- @param ... any The values to check.
---
--- @return boolean # Returns `true` if all values are valid `typeExtended` or `nil`; otherwise throws an error.
---
--
function DebugAssert.areOptionalTypeExtended(...)

    local arg_count = select('#', ...)
    local args      = { ... }

    for index = 1, arg_count do
        if args[index] ~= nil and (type(args[index]) ~= 'string' or type_lookup[args[index]] ~= type_category.extended) then
            throwSimpleError('typeExtended', type(args[index]), true, index)
        end
    end

    return true
end

-- ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐ --
-- │ TypeEx assert section.                                                                                         │ --
-- └────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘ --

--- ### This function asserts that the provided value is a valid `typeEx`.<br>
--- _Works both for native types and extended types._
---
--- -----
--- @param value any The value to check.
---
--- @return boolean # Returns `true` if the value is a valid `typeEx`; otherwise throws an error.
---
--
function DebugAssert.isTypeEx(value)
    if type(value) ~= 'string' or type_lookup[value] ~= nil then
        throwSimpleError('typeEx', type(value))
    end

    return true
end

-- ────────────────────────────────────────────────────────────────────────────────────────────────────────────────── --

--- ### This function asserts that all provided values are valid `typeEx`.<br>
--- _Works both for native types and extended types._
---
--- -----
--- @param ... any The values to check.
---
--- @return boolean # Returns `true` if all values are valid `typeEx`; otherwise throws an error.
---
--
function DebugAssert.areTypeEx(...)

    local arg_count = select('#', ...)
    local args      = { ... }

    for index = 1, arg_count do
        if type(args[index]) ~= 'string' or type_lookup[args[index]] ~= nil then
            throwSimpleError('typeEx', type(args[index]), false, index)
        end
    end

    return true
end

-- ────────────────────────────────────────────────────────────────────────────────────────────────────────────────── --

--- ### This function asserts that the provided value is a valid `typeEx` or `nil`.<br>
--- _Works both for native types and extended types._
---
--- -----
--- @param value any The value to check.
---
--- @return boolean # Returns `true` if the value is a valid `typeEx` or `nil`; otherwise throws an error.
---
--
function DebugAssert.isOptionalTypeEx(value)
    if value ~= nil and (type(value) ~= 'string' or type_lookup[value] ~= nil) then
        throwSimpleError('typeEx', type(value), true)
    end

    return true
end

-- ────────────────────────────────────────────────────────────────────────────────────────────────────────────────── --

--- ### This function asserts that all provided values are valid `typeEx` or `nil`.<br>
--- _Works both for native types and extended types._
---
--- -----
--- @param ... any The values to check.
---
--- @return boolean # Returns `true` if all values are valid `typeEx` or `nil`; otherwise throws an error.
---
--
function DebugAssert.areOptionalTypeEx(...)

    local arg_count = select('#', ...)
    local args      = { ... }

    for index = 1, arg_count do
        if args[index] ~= nil and (type(args[index]) ~= 'string' or type_lookup[args[index]] ~= nil) then
            throwSimpleError('typeEx', type(args[index]), true, index)
        end
    end

    return true
end

-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓ --
-- ┃ Derived Table.                                                                                                 ┃ --
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛ --

-- ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐ --
-- │ Array.                                                                                                         │ --
-- └────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘ --

--- ### This function asserts that the provided value is a valid `array`.<br>
--- [*slow*]
---
--- -----
--- @param value any The expression to check.
---
--- @return boolean # Returns `true` if the value is a valid array; otherwise throws an error.
---
--- -----
--- An array is a `table` where all keys are consecutive positive integers starting at 1. No missing key is allowed in
--- the middle of the array.
---
--- Be careful, this function can be slow with a big table.
---
--
function DebugAssert.isArray(value)

    if type(value) ~= 'table' then
        throwSimpleError('array', type(value))
    end

    local index_count = #value

    for index, _ in pairs(value) do
        if type(index) ~= 'number' or index < 1 or floor(index) ~= index then
            error('Invalid index in this array', 2)
        end
        index_count = index_count - 1
    end

    if index_count ~= 0 then
        error('Index gap detected in this array', 2)
    end
    
    return true
end

-- ────────────────────────────────────────────────────────────────────────────────────────────────────────────────── --

--- ### This function asserts that all provided values are valid `array`.<br>
--- [*slow*]
---
--- -----
--- @param ... any A list of expressions to check.
---
--- @return boolean # Returns `true` if all passed expressions are valid arrays; otherwise throws an error.
---
--- -----
--- An array is a `table` where all keys are consecutive positive integers starting at 1. No missing key is allowed in
--- the middle of the array.
---
--- Be careful, this function can be slow with a big table.
---
--
function DebugAssert.areArrays(...)

    local arg_count = select('#', ...)
    local args      = { ... }

    for array_index = 1, arg_count do
        if type(args[array_index]) ~= 'table' then
            throwSimpleError('array', type(args[array_index]), false, array_index)
        end
    end

    for array_index, arg in ipairs(args) do

        local index_count = #arg

        for index, _ in pairs(arg) do
            if type(index) ~= 'number' or index <= 0 or floor(index) ~= index then
                error('Invalid index in the array at index ' .. array_index, 2)
            end
            index_count = index_count - 1
        end

        if index_count ~= 0 then
            error('Index gap detected in the array at index ' .. array_index, 2)
        end
    end

    return true
end

-- ────────────────────────────────────────────────────────────────────────────────────────────────────────────────── --

--- ### This function asserts that the provided value is a valid `array` or `nil`.<br>
--- [*slow*]
---
--- -----
--- @param value any The expression to check.
---
--- @return boolean # Returns `true` if the value is a valid array or nil; otherwise throws an error.
---
--- -----
--- An array is a `table` where all keys are consecutive positive integers starting at 1. No missing key is allowed in
--- the middle of the array.
---
--- Be careful, this function can be slow with a big table.
---
--
function DebugAssert.isOptionalArray(value)

    if type(value) ~= 'table' then
        if value == nil then
            return true
        end

        throwSimpleError('array', type(value))
    end

    local index_count = #value

    for index, _ in pairs(value) do
        if type(index) ~= 'number' or index <= 0 or floor(index) ~= index then
            error('Invalid index in this array', 2)
        end
        index_count = index_count - 1
    end

    if index_count ~= 0 then
        error('Index gap detected in this array', 2)
    end

    return true
end

-- ────────────────────────────────────────────────────────────────────────────────────────────────────────────────── --

--- ### This function asserts that all provided values are valid `array` or `nil`.<br>
--- [*slow*]
---
--- -----
--- @param ... any A list of expressions to check.
---
--- @return boolean # Returns `true` if all passed expressions are valid arrays or nil; otherwise throws an error.
---
--- -----
--- An array is a `table` where all keys are consecutive positive integers starting at 1. No missing key is allowed in
--- the middle of the array.
---
--- Be careful, this function can be slow with a big table.
---
--
function DebugAssert.areOptionalArrays(...)

    local args = { ... }

    -- nil is allowed so we can use pairs directly.
    for array_index, arg in pairs(args) do
        if type(arg) ~= 'table' then
            throwSimpleError('array', type(arg), true, array_index)
        end

        local index_count = #arg

        for index, _ in pairs(arg) do
            if type(index) ~= 'number' or index <= 0 or floor(index) ~= index then
                error('Invalid index in the array at index ' .. array_index, 2)
            end
            index_count = index_count - 1
        end

        if index_count ~= 0 then
            error('Index gap detected in the array at index ' .. array_index, 2)
        end
    end

    return true
end

-- ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐ --
-- │ Dictionary.                                                                                                    │ --
-- └────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘ --

--- ### This function asserts that the provided value is a valid `dictionary`.<br>
--- [*slow*]
---
--- -----
--- @param value any The expression to check.
---
--- @return boolean # Returns `true` if the value is a valid dictionary; otherwise throws an error.
---
--- -----
--- A dictionary is a `table` where all keys are `identifier`
---
--- Be careful, this function can be slow with a big table.
---
--
function DebugAssert.isDictionary(value)

    if type(value) ~= 'table' then
        throwSimpleError('dictionary', type(value))
    end

    for key, _ in pairs(value) do
        if type(key) ~= 'string' or key:match("^[_%a][_%w]*$") == nil then
            error('Invalid identifier in this dictionary', 2)
        end
    end

    return true
end

-- ────────────────────────────────────────────────────────────────────────────────────────────────────────────────── --

--- ### This function asserts that all provided values are valid `dictionary`.<br>
--- [*slow*]
---
--- -----
--- @param ... any A list of expressions to check.
---
--- @return boolean # Returns `true` if all passed expressions are valid dictionaries; otherwise throws an error.
---
--- -----
--- A dictionary is a `table` where all keys are `identifier`
---
--- Be careful, this function can be slow with a big table.
---
--
function DebugAssert.areDictionaries(...)

    local arg_count = select('#', ...)
    local args      = { ... }

    for dictionary_index = 1, arg_count do
        if type(args[dictionary_index]) ~= 'table' then
            throwSimpleError('dictionary', type(args[dictionary_index]), false, dictionary_index)
        end
    end

    for dictionary_index, arg in ipairs(args) do
        for key, _ in pairs(arg) do
            if type(key) ~= 'string' or key:match("^[_%a][_%w]*$") == nil then
                error('Invalid identifier in the dictionary at index ' .. dictionary_index, 2)
            end
        end
    end

    return true
end

-- ────────────────────────────────────────────────────────────────────────────────────────────────────────────────── --

--- ### This function asserts that the provided value is a valid `dictionary` or `nil`.<br>
--- [*slow*]
---
--- -----
--- @param value any The expression to check.
---
--- @return boolean # Returns `true` if the value is a valid dictionary or nil; otherwise throws an error.
---
--- -----
--- A dictionary is a `table` where all keys are `identifier`
---
--- Be careful, this function can be slow with a big table.
---
--
function DebugAssert.isOptionalDictionary(value)

    if type(value) ~= 'table' then
        if value == nil then
            return true
        end

        throwSimpleError('dictionary', type(value))
    end

    for key, _ in pairs(value) do
        if type(key) ~= 'string' or key:match("^[_%a][_%w]*$") == nil then
            error('Invalid index in this dictionary', 2)
        end
    end

    return true
end

-- ────────────────────────────────────────────────────────────────────────────────────────────────────────────────── --

--- ### This function asserts that all provided values are valid `dictionary` or `nil`.<br>
--- [*slow*]
---
--- -----
--- @param ... any A list of expressions to check.
---
--- @return boolean # Returns `true` if all passed expressions are valid dictionaries or nil; otherwise throws an error.
---
--- -----
--- A dictionary is a `table` where all keys are `identifier`
---
--- Be careful, this function can be slow with a big table.
---
--
function DebugAssert.areOptionalDictionaries(...)

    local args = { ... }

    for dictionary_index, arg in pairs(args) do
        if type(arg) ~= 'table' then
            throwSimpleError('array', type(arg), true, dictionary_index)
        end

        for key, _ in pairs(arg) do
            if type(key) ~= 'string' then
                error('Invalid identifier in the dictionary at index ' .. dictionary_index, 2)
            end
        end
    end

    return true
end

-- #endregion --

-- ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐ --
-- │ Metatable.                                                                                                     │ --
-- └────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘ --

--- ### This function asserts that the provided table has a metatable.<br>
---
--- -----
--- @param value table The table to check.
--- @param expected_metatable table? The expected metatable, if a specific one is required.
---
--- @return boolean # Returns `true` if the table has the expected metatable; otherwise throws an error.
---
--
function DebugAssert.hasMetatable(value, expected_metatable)

    if type(value) ~= 'table' then
        throwSimpleError('table', type(value))
    end

    local metatable = getmetatable(value)

    if metatable == nil then
        error("This table is expected to have a metatable but no metatable is found here.", 2)
    end

    if expected_metatable ~= nil and metatable ~= expected_metatable then
        assert(type(expected_metatable) == 'table', "The expected type for the argument 'expected_metatable' is 'table', actually got '" .. type(expected_metatable) .. "'.")       -- [DEBUG-ONLY] . --
        
        error("This table do not have the expected metatable.", 2)
    end

    return true
end

-- ┌──────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐ --
-- │ Class.                                                                                                           │ --
-- └──────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘ --

--- ### This function asserts that the provided value is a class instance.<br>
---
--- -----
--- @param value any The value to check.
--- @param name string|table? The expected object name or class metatable.
---
--- @return boolean # Returns `true` if the value is a matching class instance; otherwise throws an error.
---
--
local function isClass(value, name)

    if type(value) ~= "table" then
        error("The expected type for this class is 'table', actually got '" .. type(value) .. "' instead.", 3)
    elseif type(value.valid) ~= "boolean" then
        error("A class is expected to have a 'valid' field, but it is missing.", 3)
    elseif type(value.object_name) ~= "string" then
        error("A class is expected to have an 'object_name' field, but it is missing.", 3)
    elseif getmetatable(value) == nil then
        error("A class is expected to have a metatable.", 3)
    elseif rawget(value, "__index") ~= nil then
        error("This class is probably not an instance but a metatable.", 3)
    end

    if name ~= nil then
        if type(name) == "table" then
            assert(rawget(name, "__index") ~= nil, "This does not look like a metatable.")       -- [DEBUG-ONLY] . --
            
            if getmetatable(value) ~= name then
                assert(type(name.object_name) == "string", "This metatable does not have a 'object_name' field.")       -- [DEBUG-ONLY] . --
                error("This class is expected to be a '" .. name.object_name .. "', but it is a '" .. value.object_name .. "'.", 3)
            end
        else
            assert(type(name) == "string", "The expected type for the argument 'name' is 'string', actually got '" .. type(name) .. "'.")       -- [DEBUG-ONLY] . --
    
            if name ~= value.object_name then
                error("This class is expected to be a '" .. name .. "', but it is a '" .. value.object_name .. "'.", 3)
            end
        end
    end
    
    return true
end

--- ### This function asserts that the provided value is a class instance.<br>
---
--- -----
--- @param value any The value to check.
--- @param name string|table? The expected object name or class metatable.
---
--- @return boolean # Returns `true` if the value is a matching class instance; otherwise throws an error.
---
--
function DebugAssert.isClass(value, name)
    return isClass(value, name)
end

--- ### This function asserts that the provided value is a class instance or `nil`.<br>
---
--- -----
--- @param value any The value to check.
--- @param name string|table? The expected object name or class metatable.
---
--- @return boolean # Returns `true` if the value is nil or a matching class instance; otherwise throws an error.
---
--
function DebugAssert.isOptionalClass(value, name)
    return (value == nil) or isClass(value, name)
end

-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓ --
-- ┃ LuaObjects.                                                                                                    ┃ --
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛ --

--- ### This function asserts that the provided value is a Factorio `LuaObject`.<br>
---
--- -----
--- @param value any The value to check.
--- @param name string? The expected `object_name`.
---
--- *no return*
---
--
local function isLuaObject(value, name)

    local level = 3
    
    if not (type(value) == "table" or type(value) == "userdata") then
        error("The expected type for this LuaObject is 'table' or 'userdata', actually got '" .. type(value) .. "' instead.", level)
    elseif type(value.valid) ~= "boolean" then
        error("A LuaObject is expected to have a 'valid' field, but it is missing.", level)
    elseif type(value.object_name) ~= "string" then
        error("A LuaObject is expected to have an 'object_name' field, but it is missing.", level)
    elseif getmetatable(value) ~= "private" then
        -- Factorio LuaObjects expose their protected metatable as "private".
        -- This is an observed engine invariant, not part of the documented API.
        error("A Factorio LuaObject is expected to have a private metatable.", level)
    end

    if name ~= nil then
        assert(type(name) == "string", "The expected type for the argument 'name' is 'string', actually got '" .. type(name) .. "'.")       -- [DEBUG-ONLY] . --
        if name ~= value.object_name then
            error("This LuaObject is expected to be a '" .. name .. "', but it is a '" .. value.object_name .. "'.", level)
        end
    end
end

--- ### This function asserts that the provided value is a Factorio `LuaObject`.<br>
---
--- -----
--- @param value any The value to check.
--- @param name string? The expected `object_name`.
---
--- *no return*
---
--
function DebugAssert.isLuaObject(value, name)
    return isLuaObject(value, name)
end

--- ### This function asserts that the provided value is a Factorio `LuaObject` or `nil`.<br>
---
--- -----
--- @param value any The value to check.
--- @param name string? The expected `object_name`.
---
--- @return boolean? # Returns `true` for nil; otherwise throws an error if the value is not a matching LuaObject.
---
--
function DebugAssert.isOptionalLuaObject(value, name)
    return (value == nil) or isLuaObject(value, name)
end

-- ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐ --
-- │ LuaPlayer.                                                                                                     │ --
-- └────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘ --

--- ### This function asserts that the provided value is a Factorio `LuaPlayer`.<br>
---
--- -----
--- @param value any The value to check.
--- @param valid boolean? The expected validity state.
---
--- @return boolean # Returns `true` if the value is a matching LuaPlayer; otherwise throws an error.
---
--
function DebugAssert.isLuaPlayer(value, valid)
    
    isLuaObject(value, "LuaPlayer")
    
    if valid ~= nil then
        assert(type(valid) == "boolean", "The 'valid' argument is expected to be a boolean, got a '" .. type(valid) .. "' !")       -- [DEBUG-ONLY] . --
        if value.valid ~= valid then
            error("This LuaPlayer is expected to be " .. (valid and "valid" or "invalid") .. ", but it is " .. (value.valid and "valid" or "invalid") .. ".", 3)
        end
    end

    return true
end

--- ### This function asserts that the provided value is a Factorio `LuaPlayer` or `nil`.<br>
---
--- -----
--- @param value any The value to check.
--- @param valid boolean? The expected validity state.
---
--- @return boolean # Returns `true` if the value is nil or a matching LuaPlayer; otherwise throws an error.
---
--
function DebugAssert.isOptionalLuaPlayer(value, valid)
    
    if value == nil then
        return true
    end
    
    isLuaObject(value, "LuaPlayer")
    
    if valid ~= nil then
        assert(type(valid) == "boolean", "The 'valid' argument is expected to be a boolean, got a '" .. type(valid) .. "' !")       -- [DEBUG-ONLY] . --
        if value.valid ~= valid then
            error("This LuaPlayer is expected to be " .. (valid and "valid" or "invalid") .. ", but it is " .. (value.valid and "valid" or "invalid") .. ".", 3)
        end
    end

    return true
end

-- ════════════════════════════════════════════════════════════════════════════════════════════════════════════════════ --

return DebugAssert
