AyseCore = exports["Ayse_Core"]:GetCoreObject()

RegisterNetEvent("Ayse_CarWash:paywash", function(amount)
    local player = source
    local amount = Config.Price
    local success = nil
    local ped = AyseCore.Functions.GetPlayer(source)
    local canAfford = Config.Price >= 0 and ped.cash >= Config.Price

   if canAfford then
    success = AyseCore.Functions.DeductMoney(Config.Price, player, "cash") 
    TriggerClientEvent("Ayse_CarWash:washevent", player)
   else
    TriggerClientEvent("Ayse_CarWash:washfail", player)
    end
end)
