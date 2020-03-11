local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","emp_vanilla")


local DISCORD_WEBHOOK = "https://discordapp.com/api/webhooks/676607702025371708/5N4593jx346EzjrV5mStMRSbDxIh4Uv3njCgGJwv6KgIkjnK-eZO095gY6ppEoyl3OzF"

----------------------------------------
-------------- LAVAGEM -----------------
----------------------------------------
  RegisterServerEvent('receber:Dinheiro')
  AddEventHandler('receber:Dinheiro', function(loadWeed)
    local user_id = vRP.getUserId(source)
    local player = vRP.getUserSource(user_id)
    local weight = vRP.getInventoryWeight(user_id)
    local qtdsujo = vRP.getInventoryItemAmount(user_id,"dinheirosujo")
    if weight >= vRP.getInventoryMaxWeight(user_id) then
      TriggerClientEvent('sem:espaco', player)
    else
      if vRP.hasGroup(user_id,"Vanilla") then
        if vRP.tryGetInventoryItem(user_id,"dinheirosujo",qtdsujo,true) then
          vRP.giveMoney(user_id,qtdsujo*90/100)
          TriggerEvent("everest:postarDiscord", source, DISCORD_WEBHOOK, "LOGS LAVAGEM VANILLA", "ID: "..user_id.. "\nLavou: $ "..qtdsujo, 16711680)
        else
          TriggerClientEvent('sem:dinheiro', player)
        end
      else
          TriggerClientEvent('sem:group', player)
      end
    end
  end)