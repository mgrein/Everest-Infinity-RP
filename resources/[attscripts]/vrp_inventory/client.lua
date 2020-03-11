local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPNserver = Tunnel.getInterface("vrp_inventory")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local invOpen = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTFOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("invClose",function()
	TriggerEvent("vrp_sound:source","zipperclose",0.2)
	SetCursorLocation(0.5,0.5)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
	invOpen = false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /INV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("inv",function(source,args)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) >= 102 and not vRP.isHandcuffed() then
		SetCursorLocation(0.5,0.5)
		if not invOpen then
			TriggerEvent("vrp_sound:source","zipperopen",0.5)
			SetNuiFocus(true,true)
			SendNUIMessage({ action = "showMenu" })
			invOpen = true
		else
			TriggerEvent("vrp_sound:source","zipperclose",0.2)
			SetNuiFocus(false,false)
			SendNUIMessage({ action = "hideMenu" })
			invOpen = false
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /MOC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("moc",function(source,args)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) >= 102 and not vRP.isHandcuffed() then
		SetCursorLocation(0.5,0.5)
		if not invOpen then
			TriggerEvent("vrp_sound:source","zipperopen",0.5)
			SetNuiFocus(true,true)
			SendNUIMessage({ action = "showMenu" })
			invOpen = true
		else
			TriggerEvent("vrp_sound:source","zipperclose",0.2)
			SetNuiFocus(false,false)
			SendNUIMessage({ action = "hideMenu" })
			invOpen = false
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESSED BUTTON "
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if IsControlPressed(1,243) and not IsPlayerFreeAiming(PlayerId()) and GetEntityHealth(PlayerPedId()) >= 102 then
			if not vRP.isHandcuffed() then
				SetNuiFocus(true,true)
				SetCursorLocation(0.5,0.5)
				SendNUIMessage({ action = "showMenu" })
				TriggerEvent("vrp_sound:source","zipperopen",0.5)
			end
		end
		Citizen.Wait(50)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("dropItem",function(data)
	vRPNserver.dropItem(data.item,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SENDITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("sendItem",function(data)
	vRPNserver.sendItem(data.item,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- USEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("useItem",function(data)
	vRPNserver.useItem(data.item,data.type,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOCHILA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestMochila",function(data,cb)
	local inventario,peso,maxpeso = vRPNserver.Mochila()
	if inventario then
		cb({ inventario = inventario, peso = peso, maxpeso = maxpeso })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AUTO-UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Creative:Update")
AddEventHandler("Creative:Update",function(action)
	SendNUIMessage({ action = action })
end)

RegisterNetEvent("Creative:AlarmCar")
AddEventHandler("Creative:AlarmCar",function(vehicle, status)
	SetVehicleAlarm(vehicle, status)
	StartVehicleAlarm(vehicle)
end)

