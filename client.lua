AyseCore = exports["Ayse_Core"]:GetCoreObject()

local Wash1 = 
    BoxZone:Create(vector3(-699.99, -932.35, 19.01), 5.2, 10.6, {
        name = "Wash1",
        heading = 270,
        minZ = 18.01,
        maxZ = 22.01
    })

local Wash2 = 
    BoxZone:Create(vector3(21.07, -1391.84, 29.31), 4.6, 30.6, {
        name = "Wash2",
        heading = 0,
        minZ = 28.31,
        maxZ = 32.31
    })

local carWash = ComboZone:Create({Wash1, Wash2}, {name="carWash", debugPoly = false})
local inCarWash = false
local inVeh = false
ped = nil
dirty = nil
washing = nil

CreateThread(function()
    for _, info in pairs(Config.Blips) do
        info.blip = AddBlipForCoord(info.x, info.y, info.z)
        SetBlipSprite(info.blip, 100)
        SetBlipDisplay(info.blip, 4)
        SetBlipScale(info.blip, 0.8)
        SetBlipColour(info.blip, 0)
        SetBlipAsShortRange(info.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Car Wash')
        EndTextCommandSetBlipName(info.blip)
    end
end)

carWash:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point)
    ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped)
    if isPointInside then
        ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped)
        if veh ~= 0 then 
            inVeh = true
        if inVeh then
        inCarWash = true
        if inCarWash then
            if GetVehicleDirtLevel(veh) >= Config.minDirt then
                clean = false
                dirty = true 
                TriggerServerEvent('Ayse_CarWash:paywash')
            elseif GetVehicleDirtLevel(veh) <= Config.minClean then
                dirty = false
                clean = true
                TriggerEvent('Ayse_CarWash:clean')
            end
            end 
        end
    end
end
end)

carWash:onPlayerInOut(function(isPointInside, point)
    inCarWash = isPointInside
end)

CreateThread(function()
    while true do
        ped = PlayerPedId()
        local coord = GetEntityCoords(ped)
        inCarWash = carWash:isPointInside(coord)
        Wait(wait)
    end
end)


RegisterNetEvent('Ayse_CarWash:washevent', function()
    ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped)
  if dirty then
        if lib.progressBar({
            duration = 3000,
            label = 'Washing Vehicle',
            useWhileDead = false,
            canCancel = false,
            disable = {
                car = true,
                move = true,
            },
        }) then 
            SetVehicleDirtLevel(veh, Config.washLevel)  
            Wait(wait)
            lib.notify({
                id = 'Wash',
                title = 'Car Wash',
                description = 'You have washed your vehicle!',
                position = 'bottom',
                type = "success"
            })

        end
    end
end)

RegisterNetEvent('Ayse_CarWash:washfail', function()
    local wait = 250
    Wait(wait)
    lib.notify({
        id = 'Wash',
        title = 'Car Wash',
        description = 'You do not have enough cash!',
        position = 'bottom',
        style = {
            backgroundColor = '#141517',
            color = '#909296'
        },
        icon = 'ban',
        iconColor = '#C53030'
    })
end)

RegisterNetEvent('Ayse_CarWash:clean', function() 
if clean then 
    lib.notify({
        id = 'Wash',
        title = 'Car Wash',
        description = 'Your vehicle is already clean!',
        position = 'bottom',
        type = "success"
    })
end
end)
