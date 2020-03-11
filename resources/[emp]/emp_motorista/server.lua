local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_motorista",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment(bonus)
	local source = source
	local user_id = vRP.getUserId(source)
	local pagamento = math.random(120,230)+bonus
	if user_id then
		vRP.giveMoney(user_id,pagamento)
		TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>$"..(pagamento).."</b> e bônus de <b>$"..bonus.." dólares</b>.")
		TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
	end
end