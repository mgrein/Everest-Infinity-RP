local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emP = Tunnel.getInterface("nav_crips")
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
	if data == "crips-comprar-lockpick" then
		TriggerServerEvent("crips-comprar","lockpick")
	elseif data == "crips-comprar-masterpick" then
		TriggerServerEvent("crips-comprar","masterpick")
	elseif data == "crips-comprar-pendrive" then
		TriggerServerEvent("crips-comprar","pendrive")
	elseif data == "crips-comprar-rebite" then
		TriggerServerEvent("crips-comprar","rebite")
	elseif data == "crips-comprar-rubberducky" then
		TriggerServerEvent("crips-comprar","rubberducky")	
	elseif data == "crips-comprar-chavemestra" then
		TriggerServerEvent("crips-comprar","chavemestra")		
	elseif data == "crips-comprar-serra" then
		TriggerServerEvent("crips-comprar","serra")
	elseif data == "crips-comprar-furadeira" then
		TriggerServerEvent("crips-comprar","furadeira")

	
	elseif data == "crips-vender-lockpick" then
		TriggerServerEvent("crips-vender","lockpick")
	elseif data == "crips-vender-masterpick" then
		TriggerServerEvent("crips-vender","masterpick")
	elseif data == "crips-vender-pendrive" then
		TriggerServerEvent("crips-vender","pendrive")
	elseif data == "crips-vender-rebite" then
		TriggerServerEvent("crips-vender","rebite")
	elseif data == "crips-vender-rubberducky" then
		TriggerServerEvent("crips-vender","rubberducky")	
	elseif data == "crips-vender-chavemestra" then
		TriggerServerEvent("crips-vender","chavemestra")	
	elseif data == "crips-vender-serra" then
		TriggerServerEvent("crips-vender","serra")
	elseif data == "crips-vender-furadeira" then
		TriggerServerEvent("crips-vender","furadeira")		

	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS crips
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		Citizen.Wait(1)
		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),1395.47,-1509.36,58.13,true)
		if distance <= 30 then
			DrawMarker(21,1395.47,-1509.36,58.13-0.6,0,0,0,0.0,0,0,0.5,0.5,-0.5,255,0,0,0,0,0,0,1)
			if distance <= 1.1 then
				if IsControlJustPressed(0,38) and emP.checkPermission() then
					ToggleActionMenu()
				end
			end
		end
	end
end)
