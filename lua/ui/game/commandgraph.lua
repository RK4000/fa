local ValidateAssist = import('/lua/ui/game/validateassist.lua')


function OnCommandGraphShow(show)
    -- Loo through world views and tell them to display pings
    local views = import('/lua/ui/game/worldview.lua').GetWorldViews()
    for _, view in views do
        if view and not view.DisableMarkers then
            view:ShowPings(show)
        end
    end
end



-- While the actual dragging/rendering is done engine-side. These callbacks can
-- be used to make stuff happen when dragging orders.
function OnCommandDragBegin()
    return true
end

function OnCommandDragEnd(event,cmdId)
    local rollover = GetRolloverInfo()
    for k,v in event do
        LOG(k)
    end
    LOG("Type:" .. event.Type)
    if rollover.userUnit then
        ForkThread(function()
            WaitSeconds(0.1)
            LOG("WorldPos: " .. repr(GetMouseWorldPos()))
            LOG("ScreenPos: " .. repr(GetMouseScreenPos()))
            LOG("MouseX: " .. event.MouseX)
            LOG("MouseY: " .. event.MouseY)
            local cb = { Func = 'ValidateAssist', Args = { target = rollover.userUnit:GetEntityId(), worldPos = GetMouseWorldPos() } }
            SimCallback(cb, false)
        end)
    end
    return true
end
