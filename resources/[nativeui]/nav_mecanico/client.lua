-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
local menuactive = false
function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		SendNUIMessage({ showmenu = true })
	else
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "cars-01" then
		spawnVehicle("turismor",-1125.79,-1977.53,12.76,180.13)
		TriggerEvent("Notify","sucesso","Carga de <b>Veículo</b> liberada.")
	elseif data == "cars-02" then
		spawnVehicle("turismor",-1130.74,-1977.40,12.75,180.13)
		TriggerEvent("Notify","sucesso","Carga de <b>Veículo</b> liberada.")
	elseif data == "cars-03" then
		spawnVehicle("turismor",-1135.95,-1977.21,12.75,180.13)
		TriggerEvent("Notify","sucesso","Carga de <b>Veículo</b> liberada.")

	elseif data == "class-01" then
		spawnVehicle("btype2",-1125.79,-1977.53,12.76,180.13)
		TriggerEvent("Notify","sucesso","Carga de <b>Veículo</b> liberada.")
	elseif data == "class-02" then
		spawnVehicle("btype2",-1130.74,-1977.40,12.75,180.13)
		TriggerEvent("Notify","sucesso","Carga de <b>Veículo</b> liberada.")
	elseif data == "class-03" then
		spawnVehicle("btype2",-1135.95,-1977.21,12.75,180.13)
		TriggerEvent("Notify","sucesso","Carga de <b>Veículo</b> liberada.")

	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)

function spawnVehicle(name,x,y,z,h)
	local mhash = GetHashKey(name)
	while not HasModelLoaded(mhash) do
		RequestModel(mhash)
		Citizen.Wait(10)
	end

	if HasModelLoaded(mhash) then
		local nveh = CreateVehicle(mhash,x,y,z+0.5,180.13,true,false)
		local netveh = VehToNet(nveh)
		local id = NetworkGetNetworkIdFromEntity(nveh)

		NetworkRegisterEntityAsNetworked(nveh)
		while not NetworkGetEntityIsNetworked(nveh) do
			NetworkRegisterEntityAsNetworked(nveh)
			Citizen.Wait(1)
		end

		if NetworkDoesNetworkIdExist(netveh) then
			SetEntitySomething(nveh,true)
			if NetworkGetEntityIsNetworked(nveh) then
				SetNetworkIdExistsOnAllMachines(netveh,true)
			end
		end

		SetNetworkIdCanMigrate(id,true)
		SetVehicleNumberPlateText(NetToVeh(netveh),"CARGA")
		Citizen.InvokeNative(0xAD738C3085FE7E11,NetToVeh(netveh),true,true)
		SetVehicleHasBeenOwnedByPlayer(NetToVeh(netveh),true)
		SetVehicleNeedsToBeHotwired(NetToVeh(netveh),false)
		SetModelAsNoLongerNeeded(mhash)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		Citizen.Wait(1)
		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),-1142.70,-1993.43,13.16,true)
		if distance <= 1.2 then
			if IsControlJustPressed(0,38) then
				ToggleActionMenu()
			end
		end
	end
end)