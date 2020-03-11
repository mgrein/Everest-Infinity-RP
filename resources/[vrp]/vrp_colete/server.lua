local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
hppf = {}
Tunnel.bindInterface("vrp_colete",hppf)


function hppf.checkitems()
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.tryGetInventoryItem(user_id,"colete",1,false) then
		return true
	end	
end

function hppf.checkpermission(perm)
	local perm = perm
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,perm)
end

function hppf.redeemarmour()
	local source = source
	local user_id = vRP.getUserId(source)
	vRP.giveInventoryItem(user_id,"colete",1)
end	

function hppf.checkPF()
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"membro.pf") then
		return true
	else 
		return false
	end		
end