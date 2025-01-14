local Array = require("lib-array/Array")
local Object = require("lib-array/Object")
local uiConstants = require("mod-resource-tracker/ui/uiConstants")
local makeHeader = require("mod-resource-tracker/ui/uiMainHeader")
local makeFooter = require("mod-resource-tracker/ui/uiMainFooter")
local makeResourceRow = require("mod-resource-tracker/ui/uiMainResourceRow")

local function makeUiMain()
	local resources = Object.entries(State.data.resources)
	local rows = State.isOpen and resources:map(makeResourceRow) or Array:new()

	local uiHeight = math.max(
		uiConstants.UI_HEIGHT_CLOSED,
		(
			(uiConstants.ROW_HEIGHT + uiConstants.SPACING) * (#resources + 2)
			+ uiConstants.HEADER_PADDING * 2
			+ uiConstants.FOOTER_PADDING * 2
		)
	)

	local header = makeHeader()
	local footer = makeFooter()

	local rows = State.isOpen and resources:map(makeResourceRow) or Array:new()

	rows = header:concat(rows, footer)

	return (
		{
			{
				tag = "VerticalLayout",
				attributes = {
					height = State.isOpen and uiHeight or uiConstants.UI_HEIGHT_CLOSED,
					width = uiConstants.UI_WIDTH,
					rectAlignment = "UpperCenter",
					rotation = "0, 0, 0",
					position = string.format(
						"%f %f %f",
						0,
						-50,
						-100
					),
					scale = string.format("%f %f %f", -1 / uiConstants.BASE_OBJ_SCALE.x / uiConstants.UI_QUALITY,
						-1 / uiConstants.BASE_OBJ_SCALE.z / uiConstants.UI_QUALITY,
						1 / uiConstants.BASE_OBJ_SCALE.y / uiConstants.UI_QUALITY),
					childForceExpandWidth = true,
					childForceExpandHeight = false,
					childAlignment = "UpperLeft",
					spacing = uiConstants.SPACING,
					color = "white",
				},
				children = rows
			}
		}
	)
end

return makeUiMain
