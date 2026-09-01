
-- ██████████████████████████████████████████████████████████████████████████████████████████████████████████████████ --
-- ██▛▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▜██ --
-- ██▌ Phoenix Library - Extended Types.                                                                          ▐██ --
-- ██▙▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▟██ --
-- ██████████████████████████████████████████████████████████████████████████████████████████████████████████████████ --

-- ▛▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▜ --
-- ▌ Extended type aliases declaration.                                                                             ▐ --
-- ▙▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▟ --

-- #region --

--                                                                                                                    --
-- [Description] These aliases are made to help you to make some function arguments or                                --
--               variables more specific in their types.                                                              --
--                                                                                                                    --

--                                                                                                                    --
--  [NOTE] The type `thread` is not used in Factorio LUA.                                                             --
--                                                                                                                    --

--
-- TYPE GUIDE
-- ==========
--
-- Lua values have a small set of native runtime types. The extended types below do
-- not create new Lua runtime types: they describe more precise shapes or meanings
-- for values that are still numbers, strings, or tables. They are useful for type
-- annotations, documentation, and validation.
--
-- Native Lua types
-- ----------------
--
-- * nil      : The absence of a value. Assigning nil to a table entry removes it.
-- * boolean  : Either true or false.
-- * number   : A numeric value. It may represent an integer or a fractional value.
-- * string   : An immutable sequence of characters, such as "iron-plate".
-- * table    : Lua's general-purpose container. Tables can represent arrays,
--              dictionaries, objects, sets, and other data structures.
-- * function : Executable Lua code stored as a value.
-- * userdata : A value implemented and managed outside Lua, for example an object
--              exposed by the Factorio API.
-- * thread   : A Lua coroutine. It is a native Lua type, but it is not available
--              for normal use in Factorio and is therefore not registered above.
--
-- Lua's type(value) function returns one of these native type names. In particular,
-- an integer, array, or dictionary is reported as "number" or "table" because Lua
-- does not know the semantic aliases defined by this library.
--
-- Extended value types
-- --------------------
--
-- * integer           : A number with no fractional part, such as 3 or -12.
-- * identifier        : A string that follows Lua identifier syntax: letters,
--                       digits, and underscores, without a digit at the start.
--                       Example: "player_index" is valid; "player-index" is not.
-- * index             : A positive integer used as an array position. Lua arrays
--                       conventionally start at 1 and have no gaps.
-- * array             : A table whose keys are consecutive indexes 1, 2, 3, ... .
--                       Its values may have any non-nil type.
-- * arrayOfString     : An array containing only strings.
-- * arrayOfTypeEx     : An array containing only type names accepted by typeEx.
-- * dictionary        : A table indexed by identifiers; values may have any
--                       type. Example: {health = 100, active = true}.
-- * dictionaryOfTable : A dictionary in which every value is itself a table.
-- * enumeration       : A dictionary that maps names to integers. Integers may be
--                       sequential values (1, 2, 3, ...) or independent bit flags
--                       (1, 2, 4, 8, ...), depending on the intended use.
--
-- Composite aliases and type-name aliases
-- ---------------------------------------
--
-- * any               : Any Lua value, including nil.
-- * extendedTypes     : Any value matching one of the extended value types.
-- * anyEx             : Any native or extended value; a more descriptive form of
--                       any when extended annotations are used.
-- * anyButNil         : Any native value except nil.
-- * anyButNilEx       : Any native or extended value except nil.
-- * type              : A string naming a native type.
-- * typeExtended      : A string naming an extended type or alias.
-- * typeEx            : A string accepted by either type or typeExtended.
--
-- Examples
-- --------
--
--     local count = 10                         -- number; also an integer
--     local names = {"north", "south"}         -- table; also an arrayOfString
--     local state = {running = 1, stopped = 2} -- table; also an enumeration
--
-- The native description answers "what kind of Lua value is this?". The extended
-- description answers "what rules and meaning does this particular value have?".
--

-- ╔════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗ --
-- ║ Extended Type : Extended Types.                                                                                  ║ --
-- ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝ --

--- ### Extended Type : Extended Types
---
--- -----
--- The `extendedTypes` alias contains all the extended types (without the standard types).<br>
--- _Note : The type `identifier` is shown as `string` because all identifiers are string, BUT not all string are identifiers !_
---
--- @alias extendedTypes integer|identifier|array|arrayOfString|arrayOfTypeEx|dictionary|dictionaryOfTable|enumeration

-- ╔════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗ --
-- ║ Extended Type : Extended Any.                                                                                  ║ --
-- ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝ --

--- ### Extended Type : Extended Any
---
--- -----
--- The `anyEx` alias is the same as `any` but with all extended types as well.<br>
--- _see the `extendedTypes` alias for more details about anyEx._
---
--- @alias anyEx any|extendedTypes
---

-- ╔════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗ --
-- ║ Extended Type : Any but nil.                                                                                   ║ --
-- ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝ --

--- ### Extended Type : Any but nil
---
--- -----
--- The `anyButNil` alias is the same as `any` but without the `nil` type.<br>
---
--- @alias anyButNil  number|string|boolean|table|function|userdata

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --

--- ### Extended Type : Extended Any but nil
---
--- -----
--- The `anyButNilEx` alias is the same as the `anyEx` alias but without the `nil` type.<br>
--- _see the `anyEx` alias for more details about anyEx._
---
--- @alias anyButNilEx  anyButNil|extendedTypes

-- ╔════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗ --
-- ║ Extended Type : Identifier.                                                                                    ║ --
-- ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝ --

--- ### Extended Type : Identifier
---
--- -----
--- An `identifier` is a `string` where the content is compatible with the LUA identifier syntax.<br>
--- `identifier` are used in `table` to distinguish `dictionary` and `enumeration` from simple table.<br>
---
--- ------
--- **Usage example:**<br>
--- ```
--- myString_1 = "foo-Bar"       -- is not compatible with identifier
--- myString_2 = "fooBar"        -- is compatible with identifier
---
--- myTable_1 = { }
--- myTable_1[myString_1] = "test"    -- is valid assignation
---
--- myTable_2 = { }
--- myTable_2[myString_2] = "test"    -- is valid assignation
---
--- -- myTable_1 can only be a simple `table`, because one key is not an identifier.
--- -- But myTable_2 can be a `dictionary` because all its keys are compatible with identifier.
---
--- myTable_1.foo-Bar = "Test"  -- syntax error
--- myTable_2.fooBar  = "Test"  -- is valid
---
--- aTable = {
---     foo-Bar = "Test"   -- syntax error
---     fooBar  = "Test",  -- is valid
--- }
---
--- -- This nuance is important in some context where some functions of this library or some Factorio API will require a `dictionary` as arguments.
--- ```
--- -----
--- As a reminder, LUA identifier can only be any string of letters, digits, and underscores, not beginning with a digit.
---
--- @alias identifier string

-- ╔════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗ --
-- ║ Extended Type : Index.                                                                                         ║ --
-- ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝ --

--- ### Extended Type : Index
---
--- -----
--- An `index` is a `integer` used to index a table or array.<br>
--- Indexes start from `1` and increase one by one for each value without leaving any gaps between indexes.<br>
---
--- @alias index integer

-- ╔════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗ --
-- ║ Extended Type : Array.                                                                                         ║ --
-- ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝ --

--- ### Extended Type : Array
---
--- -----
--- An `array` is a `table` where all keys are integer indexes starting from `1` and increasing one by one for each value without leaving any gaps between indexes.<br>
--- Values can be of any type except `nil` (because a `nil` value will create a gap).
---
--- @alias array        { [index]: anyButNil }

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --

--- ### Extended Type : Array (of string)
---
--- -----
--- A `arrayOfString` is an `array` where all values can only be a `string`.<br>
--- see alias `array` for more details about array.
---
--- @alias arrayOfString { [index]: string }

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --

--- ### Extended Type : Array (of typeEx)
---
--- -----
--- A `arrayOfTypeEx` is an `array` where all values can only be a `typeEx`.<br>
--- see alias `array` and `typeEx` for more details about array or typeEx.
---
--- @alias arrayOfTypeEx { [index]: typeEx }

-- ╔════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗ --
-- ║ Extended Type : Dictionary.                                                                                    ║ --
-- ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝ --

--- ### Extended Type : Dictionary
---
--- -----
--- A `dictionary` is a `table` where all keys are an `identifier`. Values can be of any type.
---
--- @alias dictionary  { [identifier]: any }

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --

--- ### Extended Type : Dictionary (of table)
---
--- -----
--- A `dictionaryOfTable` is a `table` where all keys are an `identifier`. Values can be of any type.
---
--- @alias dictionaryOfTable  { [identifier]: table }

-- ╔════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗ --
-- ║ Extended Type : Enumeration.                                                                                   ║ --
-- ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝ --

--- ### Extended Type : Enumeration
---
--- -----
--- An `enumeration` is a `table` where all keys are an `identifier` and all values are an `integer`.<br>
--- Usually in simple enumeration the values start from `1` and increase one by one for each value without leaving any gaps between values.<br>
--- <br>
--- There is also binary enumeration where values are made using powers of two (1, 2, 4, 8, ...), so each value has a unique bit set.<br>
--- This allows combining multiple values in a single variable using addition or bitwise operations,<br>
--- and checking if a value is present using a simple bitwise AND (`&`).<br>
--- It is useful when a variable can represent multiple states or flags at once.
--- ```
--- days = {    Monday    = 1,
---             Tuesday   = 2,
---             Wednesday = 3,
---             Thursday  = 4,
---             Friday    = 5,
---             Saturday  = 6,
---             Sunday    = 7   }
---
--- days = {    Monday    =  1,     -- 00000001
---             Tuesday   =  2,     -- 00000010
---             Wednesday =  4,     -- 00000100
---             Thursday  =  8,     -- 00001000
---             Friday    = 16,     -- 00010000
---             Saturday  = 32,     -- 00100000
---             Sunday    = 64   }  -- 01000000
--- ```
---
--- @alias enumeration  { [identifier]: integer }   -- integer need to start from 1 and increment one by one.

-- ╔════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗ --
-- ║ Extended Type : Type Extended.                                                                                 ║ --
-- ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝ --

--- ### Extended Type : Type Extended
---
--- -----
--- The `typeExtended` alias contains all the extended type names as `string` (without the standard types).<br>
--- It is the equivalent of the `type` alias but only with extended types.
--- _Do not confuse it with the `extendedTypes` alias which contains all the real extended types (not as string)._
---
--- @alias typeExtended 'integer'|'identifier'|'array'|'arrayOfString'|'arrayOfTypeEx'|'dictionary'|'dictionaryOfTable'|'enumeration'|'extendedTypes'|'anyEx'|'anyButNil'|'anyButNilEx'|'type'|'typeEx'|'typeExtended'

-- ╔════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗ --
-- ║ Extended Type : typeEx.                                                                                        ║ --
-- ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝ --

--- ### Extended Type : typeEx
---
--- -----
--- The `typeEx` alias is the same as the `type` alias but with all extended types as well.<br>
--- See alias `typeExtended` for more details about type.
---
--- @alias typeEx       type|typeExtended

-- #endregion --

-- ╔════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗ --
-- ║ Type Constant declaration.                                                                                     ║ --
-- ╚════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝ --

--- @enum typeCategory
--- ### Type Category
---
--- -----
--- The two categories of type supported by this library are `standard` and `extended`.<br>
---
local type_category = {
        standard = 1,       -- standard or native types
        extended = 2
    }

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --

--- ### Lookup table for types
---
--- -----
--- This table is used to look up the type category of a type or to check if a type exists.<br>
---
local types = {     ---@type table<identifier, typeCategory>
        ['nil']               = type_category.standard,
        ['boolean']           = type_category.standard,
        ['number']            = type_category.standard,
        ['string']            = type_category.standard,
        ['table']             = type_category.standard,
        ['function']          = type_category.standard,
        ['userdata']          = type_category.standard,
        ['integer']           = type_category.extended,
        ['identifier']        = type_category.extended,
        ['array']             = type_category.extended,
        ['arrayOfString']     = type_category.extended,
        ['arrayOfTypeEx']     = type_category.extended,
        ['dictionary']        = type_category.extended,
        ['dictionaryOfTable'] = type_category.extended,
        ['enumeration']       = type_category.extended,
        ['extendedTypes']     = type_category.extended,
        ['anyEx']             = type_category.extended,
        ['anyButNil']         = type_category.extended,
        ['anyButNilEx']       = type_category.extended,
        ['type']              = type_category.extended,
        ['typeEx']            = type_category.extended,
        ['typeExtended']      = type_category.extended
    }

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --

return {
        typeCategory = type_category,
        types        = types
    }
