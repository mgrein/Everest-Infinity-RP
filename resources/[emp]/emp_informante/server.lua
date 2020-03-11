local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

emP = {}
Tunnel.bindInterface("emp_informante", emP)

function emP.informantCheck()
	local source = source
	local user_id = vRP.getUserId(source)
	local policia = vRP.getUsersByPermission("policia.permissao")
	if user_id then
		if vRP.tryGetInventoryItem(user_id,"contatoinformante",1) then
			TriggerClientEvent("Notify",source,"sucesso","Você utilizou o seu <b>Contato do Informante</b> para saber a quantidade de Policiais em serviço.",8000)
			TriggerClientEvent("Notify",source,"importante","Policiais em serviço: "..#policia,8000)
			return true
		else
			TriggerClientEvent("Notify",source,"negado","Você não possui o Contato de um <b>informante</b>, consiga ele vendendo drogas.",8000)
		end
	end
end