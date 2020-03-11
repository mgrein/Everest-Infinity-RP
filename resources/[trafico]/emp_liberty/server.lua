local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_liberty",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSAO
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if  vRP.hasPermission(user_id,"liberty.permissao")  then
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
		if vRP.hasPermission(user_id,"liberty.permissao")  then
			local itens = math.random(100)
			local quantidade = math.random(35,50)
			local pagamento = math.random(1,5)*quantidade
			if itens <= 100 then
				if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("yellowcard")*quantidade <= vRP.getInventoryMaxWeight(user_id) then
					quantidade = math.random(5,10)
					vRP.giveInventoryItem(user_id,"yellowcard",quantidade)
					vRP.giveInventoryItem(user_id,"dinheirosujo",pagamento)
					TriggerClientEvent("Notify",source,"sucesso","Você coletou <b>"..quantidade.."x Yellow Card.</b>")
					TriggerClientEvent("Notify",source,"sucesso","Você ganhou <b>"..pagamento.."x Dinheiro Sujo.</b>")
					TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
				else
					TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
				end
			end			
			
		end
		return true			
	end
end