local Array = require("js-like/Array")
local util = require("durobai/util")

math.randomseed(os.time())

function onObjectPickUp(...) require("durobai/hooks/onObjectPickUp")({...}) end

function onObjectCollisionEnter(...)
    require("durobai/hooks/onObjectCollisionEnter")({...})
end
