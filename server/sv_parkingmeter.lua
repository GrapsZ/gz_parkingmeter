------------------------------------------
-- VARIABLES
------------------------------------------

local paid = {}
local cooldown = 10 -- cooldown for parking to expire (minutes)

------------------------------------------
-- EVENTS
------------------------------------------

RegisterNetEvent('gz_parkingmeter:server:payParking', function(pos)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    if Player then
        print('player founded')
        print(tostring(Player.getMoney()))
        if Player.getMoney() >= 5 then
            Player.removeMoney(5, "Parkingmeter")
            local id = math.random(10000, 99999)
            paid[id] = {
                coords = pos,
            }
            TriggerClientEvent('esx:showNotification', src, "You paid parking fee!", "success")
            Wait(cooldown * 60000)
            paid[id] = nil
            TriggerClientEvent('esx:showNotification', src, "Parking payment expired!", "error")
        else
            TriggerClientEvent('esx:showNotification', src, "You don't have enough cash!", "success")
        end
    end
end)

------------------------------------------
-- CALLBACKS
------------------------------------------

ESX.RegisterServerCallback('gz_parkingmeter:server:checkParking', function(source, cb, pos)
    local founded = false
    for _, v in pairs(paid) do
        if #(pos - v.coords) <= 3 then
            founded = true
            break
        end
    end
    cb(founded)
end)