local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

emP = {}
Tunnel.bindInterface("emp_race",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
local pay = {
	--[[1] = { ['min'] = 500, ['max'] = 800 },
	[2] = { ['min'] = 500, ['max'] = 800 },
	[3] = { ['min'] = 500, ['max'] = 800 },
	[4] = { ['min'] = 500, ['max'] = 800 },
	[5] = { ['min'] = 500, ['max'] = 800 },
	[6] = { ['min'] = 500, ['max'] = 800 },
	[7] = { ['min'] = 500, ['max'] = 800 },]] 
    [1] = { ['min'] = 500, ['max'] = 800 },
    [2] = { ['min'] = 500, ['max'] = 800 },

}

function emP.paymentCheck(check)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRPclient.setStandBY(source,parseInt(180))
		local random = math.random(pay[check].min,pay[check].max)
		local policia = vRP.getUsersByPermission("policia.permissao")
		if parseInt(#policia) == 0 then
			vRP.giveInventoryItem(user_id,"dinheirosujo",parseInt(random))
			TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>$"..parseInt(random).."Dinheiro Sujo.</b>")
			TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
		else
			vRP.giveInventoryItem(user_id,"dinheirosujo",parseInt(random*#policia))
			TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>$"..parseInt(random*#policia).."Dinheiro Sujo.</b>")
			TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
		end
	end
end
