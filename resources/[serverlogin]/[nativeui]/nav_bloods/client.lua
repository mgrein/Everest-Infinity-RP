local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emP = Tunnel.getInterface("nav_bloods")
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
	if data == "bloods-comprar-lockpick" then
		TriggerServerEvent("bloods-comprar","lockpick")
	elseif data == "bloods-comprar-masterpick" then
		TriggerServerEvent("bloods-comprar","masterpick")
	elseif data == "bloods-comprar-pendrive" then
		TriggerServerEvent("bloods-comprar","pendrive")
	elseif data == "bloods-comprar-rebite" then
		TriggerServerEvent("bloods-comprar","rebite")
	elseif data == "bloods-comprar-rubberducky" then
		TriggerServerEvent("bloods-comprar","rubberducky")	
	elseif data == "bloods-comprar-chavemestra" then
		TriggerServerEvent("bloods-comprar","chavemestra")		
	elseif data == "bloods-comprar-serra" then
		TriggerServerEvent("bloods-comprar","serra")
	elseif data == "bloods-comprar-furadeira" then
		TriggerServerEvent("bloods-comprar","furadeira")

	
	elseif data == "bloods-vender-lockpick" then
		TriggerServerEvent("bloods-vender","lockpick")
	elseif data == "bloods-vender-masterpick" then
		TriggerServerEvent("bloods-vender","masterpick")
	elseif data == "bloods-vender-pendrive" then
		TriggerServerEvent("bloods-vender","pendrive")
	elseif data == "bloods-vender-rebite" then
		TriggerServerEvent("bloods-vender","rebite")
	elseif data == "bloods-vender-rubberducky" then
		TriggerServerEvent("bloods-vender","rubberducky")	
	elseif data == "bloods-vender-chavemestra" then
		TriggerServerEvent("bloods-vender","chavemestra")	
	elseif data == "bloods-vender-serra" then
		TriggerServerEvent("bloods-vender","serra")
	elseif data == "bloods-vender-furadeira" then
		TriggerServerEvent("bloods-vender","furadeira")		

	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS BLOODS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		Citizen.Wait(1)
		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),550.36,-1775.63,29.32,true)
		if distance <= 30 then
			DrawMarker(21,550.36,-1775.63,29.32-0.6,0,0,0,0.0,0,0,0.5,0.5,-0.5,255,0,0,0,0,0,0,1)
			if distance <= 1.1 then
				if IsControlJustPressed(0,38) and emP.checkPermission() then
					ToggleActionMenu()
				end
			end
		end
	end
end)
