local uiConstants = {}

uiConstants.UI_QUALITY = 3
uiConstants.BASE_OBJ_SCALE = {
	x = 5,
	y = 0.1,
	z = 1
}

uiConstants.ROW_HEIGHT = 36 * uiConstants.UI_QUALITY
uiConstants.SPACING = 12 * uiConstants.UI_QUALITY
uiConstants.SPACING_S = 6 * uiConstants.UI_QUALITY
uiConstants.UI_HEIGHT_CLOSED = 100 * uiConstants.UI_QUALITY
uiConstants.UI_WIDTH = 100 * uiConstants.BASE_OBJ_SCALE.x * uiConstants.UI_QUALITY
uiConstants.RESOURCE_COUNT_MIN_WIDTH = 30 * uiConstants.UI_QUALITY
uiConstants.LINE_WIDTH = 4 * uiConstants.UI_QUALITY

uiConstants.HEADER_PADDING = 12 * uiConstants.UI_QUALITY
uiConstants.FOOTER_PADDING = uiConstants.SPACING_S

uiConstants.ELEMENT_IDS = {
	json = "json",
}

return uiConstants
