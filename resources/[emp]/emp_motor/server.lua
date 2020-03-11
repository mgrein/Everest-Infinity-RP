local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_motor",emP)

-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- VARIAVEIS
-- -----------------------------------------------------------------------------------------------------------------------------------------


RegisterServerEvent('terminar:Solda')
AddEventHandler('terminar:Solda', function()
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
		vRP.giveInventoryItem(user_id, "motor", 1,true)
end)