local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_farm_ilegal",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSAO
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if  vRP.hasPermission(user_id,"mafia.permissao")  or vRP.hasPermission(user_id,"motoclub.permissao")    then
			return true
		else
			TriggerClientEvent("Notify",source,"negado","Você não tem acesso.")
			return false
		end						
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECK PAGAMENTO
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"mafia.permissao") then
			local itens = math.random(100)
			local quantidade = math.random(25,50)
			if itens <= 100 then
				if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("capsuladebala")*quantidade <= vRP.getInventoryMaxWeight(user_id) then
					quantidade = math.random(20,50)
					vRP.giveInventoryItem(user_id,"capsuladebala",quantidade)
					TriggerClientEvent("Notify",source,"sucesso","Você coletou <b>"..quantidade.."x Cápsula de Muniçôes.</b>")
					TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
				else
					TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
				end
			end	

		elseif vRP.hasPermission(user_id,"motoclub.permissao") then
			local itens = math.random(1)
			local quantidade = math.random(35,50)
			local pagamento = math.random(35,50)*quantidade
			if itens <= 100 then
				if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("pecasdearma")*quantidade <= vRP.getInventoryMaxWeight(user_id) then
					quantidade = math.random(20,30)
					vRP.giveInventoryItem(user_id,"pecasdearma",quantidade)
					TriggerClientEvent("Notify",source,"sucesso","Você coletou <b>"..quantidade.."x Peças de Armas.</b>")
					TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
				else
					TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
				end
			end


		end
		return true			
	end
end