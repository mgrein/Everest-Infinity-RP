local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_placa",emP)

RegisterServerEvent("primaryColors")
AddEventHandler("primaryColors",function(r,g,b,r2,g2,b2)
	local source = source
    local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"liberty.permissao") and vRPclient.isInVehicle(source) then
		local vehicle,vnetid,placa,vname = vRPclient.vehList(source,7)
		if vehicle then
			local puser_id = vRP.getUserByRegistration(placa)
			if puser_id then
				vCLIENT.vehiclePrimary(source,vehicle,parseInt(r),parseInt(g),parseInt(b))
				local ok = vRP.request(source,"Deseja aplicar a cor selecionada no veículo?",30)
				if ok then
					if vRP.tryFullPayment(user_id,3000) then
						TriggerClientEvent("Notify",source,"sucesso","Aplicada com sucesso.",8000)
						vRP.execute("creative/set_priColor",{ user_id = puser_id, vehicle = vname, colorR = parseInt(r), colorG = parseInt(g), colorB = parseInt(b) })
					else
						vCLIENT.vehiclePrimary(source,vehicle,parseInt(r2),parseInt(g2),parseInt(b2))
					end
				else
					vCLIENT.vehiclePrimary(source,vehicle,parseInt(r2),parseInt(g2),parseInt(b2))
				end
			end
		end
	end
end)
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
