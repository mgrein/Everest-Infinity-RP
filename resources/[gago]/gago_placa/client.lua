local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emP = Tunnel.getInterface("emp_placa")
vRP = Proxy.getInterface("vRP")

local CoordenadaX = -1133.94
local CoordenadaY = 2693.5
local CoordenadaZ = 18.12

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------

--[[RegisterCommand("colors",function(source,args)
	local ped = PlayerPedId()
	if parseInt(args[1]) and parseInt(args[2]) and parseInt(args[3]) and IsPedInAnyVehicle(ped) then
		for _,v in pairs(clona) do
			local x,y,z = table.unpack(v)
			local colors = table.pack(GetVehicleCustomPrimaryColour(GetVehiclePedIsUsing(ped)))
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),x,y,z,true)
			if distance <= 5 then
				TriggerServerEvent("primaryColors",parseInt(args[1]),parseInt(args[2]),parseInt(args[3]),parseInt(colors[1]),parseInt(colors[2]),parseInt(colors[3]))
			end
		end
	end
end)]]


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if placa then
			local ped = PlayerPedId()
			local vehicle = GetVehiclePedIsUsing(ped)
			local x,y,z = table.unpack(GetEntityCoords(ped))
			if distance <= 50.0 then
				if IsEntityAVehicle(vehicle) and GetVehicleClass(vehicle) ~= 9 and GetPedInVehicleSeat(vehicle,-1) == ped then
					DrawMarker(23,CoordenadaX,CoordenadaY,CoordenadaZ-0.900,0,0,0,0,0,0,20.0,20.0,1.0,0,95,140,100,0,0,0,0)
					if distance <= 10.9 then
						drawTxt("PRESSIONE  ~r~E~w~  PARA CLONAR O CARRO",6,0.09,0.770,0.50,255,255,255,150)
						if IsControlJustPressed(0,38) and emP.checkPermission() then
							TriggerServerEvent("primaryColors",parseInt(args[1]),parseInt(args[2]),parseInt(args[3]),parseInt(colors[1]),parseInt(colors[2]),parseInt(colors[3]))
						end
					end
				end
			end
		end
	end
end)