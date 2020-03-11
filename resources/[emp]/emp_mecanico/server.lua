local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_mecanico",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"mecanico.permissao")
end

function emP.checkPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	local qtd = math.random(1, 3)
	if user_id then
		if vRP.tryGetInventoryItem(user_id,"ferramenta",qtd) then
			vRP.giveMoney(user_id,math.random(300,500)*qtd)
			return true
		else
			TriggerClientEvent("Notify",source,"aviso","Você precisa de <b>"..qtd.."x Ferramenta</b>.")
		end
	end
end


-----------------------------------------------------------------------------------------------------------------------------------------
-- MEC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('mec',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if user_id then
			if vRP.hasPermission(user_id, "mecanico.permissao") then
				TriggerClientEvent('chatMessage',-1,"MECANICO | "..identity.name.." "..identity.firstname,{255,140,0},rawCommand:sub(4))
			else
				TriggerClientEvent('chatMessage',-1,identity.name.." "..identity.firstname,{255,140,0},rawCommand:sub(4))
			end
		end
	end
end)