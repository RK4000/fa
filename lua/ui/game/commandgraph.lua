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
    return true
end
