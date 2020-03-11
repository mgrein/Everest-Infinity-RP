local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_pizza",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPizza()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("pizza")*3 <= vRP.getInventoryMaxWeight(user_id) then
			if vRP.tryGetInventoryItem(user_id,"caixadepizza",3) then
				vRP.giveInventoryItem(user_id,"pizza",3)
				vRP._playAnim(source,true,{{"amb@prop_human_atm@male@idle_a"}},false)	
				return true
			else
				TriggerClientEvent("Notify",source,"aviso","Você precisa de <b>3x Caixa de Pizza.</b>")
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local quantidade = {}
local quantia = 0

RegisterServerEvent('event:GetPizza')
AddEventHandler('event:GetPizza', function()
	quantia = math.random(3,9)
	TriggerClientEvent('event:SetPizza', source, quantia)
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
		if vRP.tryGetInventoryItem(user_id,"pizza",quantidade[source]) then
			vRP.giveMoney(user_id,pagamento)
			quantidade[source] = nil
			TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>$"..pagamento.." dólares.</b>")
			TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
			return true
		else
			TriggerClientEvent("Notify",source,"aviso","Você precisa de <b>"..quantidade[source].."x Caixa de Pizza</b>.")
		end
	end
end