math.randomseed(os.time())

function onObjectPickUp(...) require("durobai/hooks/onObjectPickUp")({...}) end

function onObjectCollisionEnter(...)
    require("durobai/hooks/onObjectCollisionEnter")({...})
end
