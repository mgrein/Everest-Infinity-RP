------------------------------------------------------
----------https://github.com/DaviReisVieira-----------
------------EMAIL:VIEIRA08DAVI38@GMAIL.COM------------
---------------DISCORD: DAVI REIS #2602---------------
------------------------------------------------------
-- vRP TUNNEL/PROXY
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

-- RESOURCE TUNNEL/PROXY
vRPlv = {}
Tunnel.bindInterface("vrp_lavagem", vRPlv)
Proxy.addInterface("vrp_lavagem", vRPlv)
LVclient = Tunnel.getInterface("vrp_lavagem")

cfg = module("vrp_lavagem", "cfg/config")

local DISCORD_WEBHOOK = "https://discordapp.com/api/webhooks/676607702025371708/5N4593jx346EzjrV5mStMRSbDxIh4Uv3njCgGJwv6KgIkjnK-eZO095gY6ppEoyl3OzF"

function vRPlv.lavarabrir()
    local source = source
    local user_id = vRP.getUserId(source)
    local amount = vRP.prompt(source, "Valor que você quer lavar:", "")
    local amount = parseInt(amount)
    if amount > 0 then
        if vRP.tryGetInventoryItem(user_id, "cartaoclonado",40) then
            vRP.tryGetInventoryItem(user_id, "dinheirosujo", amount, true) 
			vRP.giveMoney(user_id, parseInt(amount * (cfg.lavagemporcento)))
            TriggerClientEvent("Notify", source, "sucesso", "Lavou <b>R$" .. vRP.format(amount) .. ",00 Sujo</b> e recebeu <b>R$" .. vRP.format(parseInt(amount * (cfg.lavagemporcento))) .. ",00</b> Limpo.")
			TriggerEvent("everest:postarDiscord", source, DISCORD_WEBHOOK, "LOGS LAVAGEM MAFIA2", "ID: "..user_id.. "\nLavou: $ "..vRP.format(parseInt(amount)), 16711680)
            LVclient.jalimpououn(source)
		else
            TriggerClientEvent("Notify",source,"negado","Você precisa de <b>40x Cartão clonado</b> para fazer uma lavagem de dinheiro.",8000)
			LVclient.jalimpououn(source)
        end
    end
end