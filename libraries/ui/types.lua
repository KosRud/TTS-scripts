---@class ConfigUiParams
---@field BASE_OBJ_SCALE Vector3
---@field getConfig fun():table
---@field QUALITY number
---@field setConfig fun(config: table)
---@field UI_HEIGHT number?
---@field UI_WIDTH number

---@class TargetObject
---@field UI UI

---@class UI
---@field setAttribute fun(id:string, attribute:string, value)
---@field setXmlTable fun(xmlTable : table)

---@class UiParams
---@field configUiParams ConfigUiParams
---@field makeUiMain fun():table
---@field object TargetObject
---@field style table The <Default> element in XML ui.

---@class Vector3
---@field x number
---@field y number
---@field z number
