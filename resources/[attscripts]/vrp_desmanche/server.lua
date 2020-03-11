-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_desmanche",src)
vCLIENT = Tunnel.getInterface("vrp_desmanche")
vGARAGE = Tunnel.getInterface("vrp_garages")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local vehicles = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function src.startVehicleList(vehList)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vehicles[user_id] = ""
		for k,v in pairs(vehList) do
			vehicles[user_id] = vehicles[user_id]..vRP.vehicleName(v[1])
			if k ~= #vehList then
				vehicles[user_id] = vehicles[user_id]..", "
			end
		end
		vCLIENT.setVehicles(source,vehicles[user_id])
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESSEDVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function src.pressedVehicle(veh,vname,placa)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRP.getClonePlate(placa) then
			local nuser_id = vRP.getUserByRegistration(placa)
			if nuser_id then
				local vehicle = vRP.query("creative/get_vehicles",{ user_id = parseInt(nuser_id), vehicle = vname })
				if #vehicle <= 0 then
					TriggerClientEvent("Notify",source,"aviso","Veículo não encontrado na lista do proprietário.",8000)
					return
				end

				if parseInt(vehicle[1].detido) >= 1 then
					TriggerClientEvent("Notify",source,"aviso","Veículo encontra-se apreendido na seguradora.",8000)
					return
				end

				vRP.execute("creative/set_detido",{ user_id = parseInt(nuser_id), vehicle = vname, detido = 1, time = parseInt(os.time()) })
				vRP.giveInventoryItem(user_id,"dinheirosujo",parseInt(vRP.vehiclePrice(vname)*0.15))
				TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>$"..vRP.format(parseInt(vRP.vehiclePrice(vname)*0.15)).." dólares</b> pelo veículo <b>"..vRP.vehicleName(vname).."</b>.",10000)
			else
				vRP.giveInventoryItem(user_id,"dinheirosujo",parseInt(vRP.vehiclePrice(vname)*0.1))
				TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>$"..vRP.format(parseInt(vRP.vehiclePrice(vname)*0.1)).." dólares</b> pelo veículo <b>"..vRP.vehicleName(vname).."</b>.",10000)
			end

			if math.random(100) <= 20 then
				vRP.giveInventoryItem(user_id,"placa",1)
			end

			if math.random(100) <= 6 then
				vRP.giveInventoryItem(user_id,"pumpkin",1)
			end

			vGARAGE.deleteVehicle(source,veh)
			vCLIENT.resetList(source)
		else
			TriggerClientEvent("Notify",source,"aviso","Veículos clonados não podem ser desmanchados.",8000)
		end
	end
end