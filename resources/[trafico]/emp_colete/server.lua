local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_colete",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSAO
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if  vRP.hasPermission(user_id,"mafia.permissao")  then
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
		if vRP.hasPermission(user_id,"mafia.permissao")  then
			local itens = math.random(100)
			local quantidade = math.random(1,3)
			local pagamento = math.random(1,5)*quantidade
			if itens <= 100 then
				if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("colete")*quantidade <= vRP.getInventoryMaxWeight(user_id) then
					quantidade = math.random(1,3)
					vRP.giveInventoryItem(user_id,"colete",quantidade)
					TriggerClientEvent("Notify",source,"sucesso","Você coletou <b>"..quantidade.."x Colete Balístico.</b>")
					TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
				else
					TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
				end
			end			
			
		end
		return true			
	end
end