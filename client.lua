ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)

    if Config.commandEnabled then
        RegisterCommand(Config.Command, function() 
            toggleEngine()
        end, false)
    end

    while true do
        Citizen.Wait(0)
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if (IsControlJustReleased(0, Config.keybinds) or IsDisabledControlJustReleased(0, Config.keybinds)) and vehicle ~= nil and vehicle ~= 0 and GetPedInVehicleSeat(vehicle, 0)  then
            toggleEngine()
            end
        end
    end
end)

function toggleEngine()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    local engineStatus = GetIsVehicleEngineRunning(vehicle)
    local msgon = ''

    if vehicle ~= 0 then
        if not engineStatus then
            SetVehicleEngineOn(vehicle, true, false, true)
            notification('引擎發動 Engine On')
        else 
            SetVehicleEngineOn(vehicle, false, false, true)
            notification('引擎關閉 Engine Off')
        end 
    end
end

function notification(msg)
    ESX.ShowAdvancedNotification('車輛控制系統', '', msg, 'CHAR_LIFEINVADER', 1)
end