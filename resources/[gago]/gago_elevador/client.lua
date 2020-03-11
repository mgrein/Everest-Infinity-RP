local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
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
	local ped = PlayerPedId()
	if data == "andar1" then
		ToggleActionMenu()
		DoScreenFadeOut(2100)
		TriggerEvent("Notify","importante","Você está no elevador aguarde...")
		Citizen.Wait(1000)
		TriggerEvent("vrp_sound:source",'elevator',1.0)
		SetEntityVisible(ped,false,false)
		Citizen.Wait(25000)
		DoScreenFadeIn(1500)
		vRP.teleport(-1066.37,-833.74,19.04)
		SetEntityVisible(ped,true,true)
	elseif data == "andar2" then
		ToggleActionMenu()
		DoScreenFadeOut(1000)
		TriggerEvent("Notify","importante","Você está no elevador aguarde...")
		Citizen.Wait(1000)
		TriggerEvent("vrp_sound:source",'elevator',1.0)
		SetEntityVisible(ped,false,false)
		Citizen.Wait(25000)
		DoScreenFadeIn(1500)
		SetEntityVisible(ped,true,true)
		vRP.teleport(-1095.94,-851.07,23.04)
	elseif data == "andar3" then
		ToggleActionMenu()
		DoScreenFadeOut(1000)
		TriggerEvent("Notify","importante","Você está no elevador aguarde...")
		Citizen.Wait(1000)
		TriggerEvent("vrp_sound:source",'elevador',1.0)
		SetEntityVisible(ped,false,false)
		Citizen.Wait(25000)
		DoScreenFadeIn(1500)
		SetEntityVisible(ped,true,true)
		vRP.teleport(-1066.16,-833.66,27.04)
	elseif data == "andar4" then
		ToggleActionMenu()
		DoScreenFadeOut(1000)
		TriggerEvent("Notify","importante","Você está no elevador aguarde...")
		Citizen.Wait(1000)
		TriggerEvent("vrp_sound:source",'elevator',1.0)
		SetEntityVisible(ped,false,false)
		Citizen.Wait(25000)
		DoScreenFadeIn(1500)
		SetEntityVisible(ped,true,true)
		vRP.teleport(-1096.56,-849.71,30.76)
	elseif data == "andar5" then
		ToggleActionMenu()
		DoScreenFadeOut(1000)
		TriggerEvent("Notify","importante","Você está no elevador aguarde...")
		Citizen.Wait(1000)
		TriggerEvent("vrp_sound:source",'elevator',1.0)
		SetEntityVisible(ped,false,false)
		Citizen.Wait(25000)
		DoScreenFadeIn(1500)
		SetEntityVisible(ped,true,true)
		vRP.teleport(-1096.34,-849.98,38.25)
	elseif data == "andar-1" then
		ToggleActionMenu()
		DoScreenFadeOut(1000)
		TriggerEvent("Notify","importante","Você está no elevador aguarde...")
		Citizen.Wait(1000)
		TriggerEvent("vrp_sound:source",'elevator',1.0)
		SetEntityVisible(ped,false,false)
		Citizen.Wait(25000)
		DoScreenFadeIn(1500)
		SetEntityVisible(ped,true,true)
		vRP.teleport(-1066.18,-833.37,5.48)
	elseif data == "andar-2" then
		ToggleActionMenu()
		DoScreenFadeOut(1000)
		TriggerEvent("Notify","importante","Você está no elevador aguarde...")
		Citizen.Wait(1000)
		TriggerEvent("vrp_sound:source",'elevator',1.0)
		SetEntityVisible(ped,false,false)
		Citizen.Wait(25000)
		DoScreenFadeIn(1000)
		SetEntityVisible(ped,true,true)
		vRP.teleport(-1096.35,-850.21,10.28)
	elseif data == "andar-3" then
		ToggleActionMenu()
		DoScreenFadeOut(1000)
		TriggerEvent("Notify","importante","Você está no elevador aguarde...")
		Citizen.Wait(1000)
		TriggerEvent("vrp_sound:source",'elevator',1.0)
		SetEntityVisible(ped,false,false)
		Citizen.Wait(25000)
		DoScreenFadeIn(1500)
		SetEntityVisible(ped,true,true)
		vRP.teleport(-1097.1,-847.8,13.69)
	elseif data == "fechar" then
		ToggleActionMenu()
	end
	TriggerEvent("ToogleBackCharacter")
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- TOOGLE LOGIN
-----------------------------------------------------------------------------------------------------------------------------------------
local marcacoes = {
	{ -1096.68,-847.69,19.01 },
	{ -1066.97,-831.3,19.04 },
	{ -1096.9,-847.72,23.04 },
	{ -1067.1,-831.28,27.04 },
	{ -1096.76,-847.83,26.83 },
	{ -1096.91,-847.69,30.76 },
	{ -1096.79,-847.58,38.01 },
	{ -1066.69,-831.1,5.48 },
	{ -1067.0,-831.21,11.04 },
	{-1097.09,-847.66,10.28 },
    { -1097.1,-847.8,13.69 },
    {-1096.98,-847.87,34.37 }
}

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		Citizen.Wait(1)
		for _,mark in pairs(marcacoes) do
			local x,y,z = table.unpack(mark)
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),x,y,z,true)
			if distance <= 2 then
			DrawText3Ds( x, y, z-0.0,"~g~E ~w~  PARA USAR O ELEVADOR")
			end
			if distance <= 1.2 then
				
				if IsControlJustPressed(0,38) then
					ToggleActionMenu()
				end
			end
		end
	end
end)

function DrawText3Ds(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,150)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text))/370
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,80)
end