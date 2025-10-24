RegisterNetEvent('leaveEngineRunning:toggle')
AddEventHandler('leaveEngineRunning:toggle', function(vehicleNetId, turnOn, fullBeam)
    local veh = NetworkGetEntityFromNetworkId(vehicleNetId)
    if DoesEntityExist(veh) then
        TriggerClientEvent('leaveEngineRunning:setEngine', -1, vehicleNetId, turnOn, fullBeam)
    end
end)
