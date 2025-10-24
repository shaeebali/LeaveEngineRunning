-------------------------------------------
--- Leave Engine Running, Made by FAXES ---
-------------------------------------------

local _C = Config or {}

local RestrictEmer = _C.RestrictEmer
local keepDoorOpen = _C.KeepDoorOpen
local highBeams = _C.HighBeams
local debugMode = _C.Debug

local notify = false

local function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

local function L(key)
    if type(Config) ~= "table" then return key end
    local locale = Config.Locale or "en"
    local locales = Config.Locales or {}
    if locales[locale] and locales[locale][key] then
        return locales[locale][key]
    end
    if locales['en'] and locales['en'][key] then
        return locales['en'][key]
    end
    return key
end

-- Optimised leave engine thread
Citizen.CreateThread(function()
    while true do
        local waitTime = 1000

        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped, false)

        if veh ~= 0 and not IsEntityDead(ped) then
            waitTime = 0

            -- notification
            if not notify then
                ShowNotification(L("leave_engine"))
                notify = true
            end

            -- leave engine running
            if IsControlPressed(2, 75) then
                Citizen.Wait(150)
                if IsControlPressed(2, 75) then
                    local netId = NetworkGetNetworkIdFromEntity(veh)
                    TriggerServerEvent('leaveEngineRunning:toggle', netId, true, highBeams)

                    if keepDoorOpen then
                        TaskLeaveVehicle(ped, veh, 256)
                    else
                        TaskLeaveVehicle(ped, veh, 0)
                    end
                end
            end
        end

        Citizen.Wait(waitTime)
    end
end)

-- Auto-turn-off lights thread
Citizen.CreateThread(function()
    local prevVeh = nil
    while true do
        Citizen.Wait(500)
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped, false)

        if prevVeh and veh == 0 then
            if not GetIsVehicleEngineRunning(prevVeh) then
                local netId = NetworkGetNetworkIdFromEntity(prevVeh)
                TriggerServerEvent('leaveEngineRunning:toggle', netId, false, false)
            end
        end

        prevVeh = veh ~= 0 and veh or nil
    end
end)

-- receive networked engine/light updates
RegisterNetEvent('leaveEngineRunning:setEngine')
AddEventHandler('leaveEngineRunning:setEngine', function(vehicleNetId, turnOn, fullBeam)
    local veh = NetworkGetEntityFromNetworkId(vehicleNetId)
    if DoesEntityExist(veh) then
        SetVehicleEngineOn(veh, turnOn, true, false)
        if turnOn and fullBeam then
            SetVehicleLights(veh, 2)
            SetVehicleFullbeam(veh, true)
            SetVehicleLightMultiplier(veh, 1.0)
        else
            SetVehicleLights(veh, 0)
            SetVehicleFullbeam(veh, false)
            SetVehicleLightMultiplier(veh, 0.0)
        end
    end
end)
