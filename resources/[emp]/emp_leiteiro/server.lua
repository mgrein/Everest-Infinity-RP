local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_leiteiro",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkLeites()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("garrafadeleite")*3 <= vRP.getInventoryMaxWeight(user_id) then
			if vRP.tryGetInventoryItem(user_id,"garrafavazia",3) then
				vRP.giveInventoryItem(user_id,"garrafadeleite",3)
				vRPclient._playAnim(source,true,{{"amb@prop_human_atm@male@idle_a"}},false)	
				return true
			else
				TriggerClientEvent("Notify",source,"aviso","Você precisa de <b>3x Garrafas Vazias.</b>")
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local quantidade = {}
local quantia = 0

RegisterServerEvent('event:GetLeite')
AddEventHandler('event:GetLeite', function()
	quantia = math.random(3,9)
	TriggerClientEvent('event:SetLeite', source, quantia)
end)

function emP.Quantidade()
	local source = source
	if quantidade[source] == nil then
		quantidade[source] = quantia
	end
end

function emP.checkPayment()
	emP.Quantidade()
	local source = source
	local user_id = vRP.getUserId(source)
	local pagamento = math.random(120,230)*quantidade[source]
	if user_id then
		if vRP.tryGetInventoryItem(user_id,"garrafadeleite",quantidade[source]) then
			vRP.giveMoney(user_id,pagamento)
			quantidade[source] = nil
			TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>$"..pagamento.." dólares.</b>")
			TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
			return true
		else
			TriggerClientEvent("Notify",source,"aviso","Você precisa de <b>"..quantidade[source].."x Garrafas de Leite</b>.")
		end
	end
end