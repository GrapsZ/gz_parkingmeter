------------------------------------------
-- EVENTS
------------------------------------------

RegisterNetEvent('gz_parkingmeter:client:payParking', function()
    local playerPed = PlayerPedId()
    local pos = GetEntityCoords(playerPed)

    ESX.Progressbar("Making payment...", 3000, {
        FreezePlayer = true,
        animation = {
            type = "Scenario",
            Scenario = "PROP_HUMAN_PARKING_METER",
        },
        onFinish = function()
            ClearPedTasks(playerPed)
            ESX.TriggerServerCallback('gz_parkingmeter:server:checkParking', function(hasPayed)
                if hasPayed then
                    ESX.ShowNotification('Parking is already paid!', 'error', 5000)
                else
                    TriggerServerEvent('gz_parkingmeter:server:payParking', pos)
                end
            end, pos)
        end, onCancel = function()
            ClearPedTasks(playerPed)
        end
    })
end)

RegisterNetEvent('gz_parkingmeter:client:checkParking', function()
    local playerPed = PlayerPedId()
    local pos = GetEntityCoords(playerPed)

    ESX.Progressbar("Checking payment...", 5000, {
        FreezePlayer = true,
        animation = {
            type = "Scenario",
            Scenario = "PROP_HUMAN_PARKING_METER",
        },
        onFinish = function()
            ClearPedTasks(playerPed)
            ESX.TriggerServerCallback('gz_parkingmeter:server:checkParking', function(hasPayed)
                if hasPayed then
                    ESX.ShowNotification('Parking is paid!', 'success', 5000)
                else
                    ESX.ShowNotification('Parking is not paid!', 'error', 5000)
                end
            end, pos)
        end, onCancel = function()
            ClearPedTasks(playerPed)
        end
    })
end)
