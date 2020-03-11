local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emP = Tunnel.getInterface("nav_vanilla")
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
	if data == "vanilla-comprar-algemas" then
		TriggerServerEvent("vanilla-comprar","algemas")
	elseif data == "vanilla-comprar-capuz" then
		TriggerServerEvent("vanilla-comprar","capuz")
	elseif data == "vanilla-comprar-c4flare" then
		TriggerServerEvent("vanilla-comprar","c4flare")	
	

	elseif data == "vanilla-vender-algemas" then
		TriggerServerEvent("vanilla-vender","algemas")
	elseif data == "vanilla-vender-capuz" then
		TriggerServerEvent("vanilla-vender","capuz")
	elseif data == "vanilla-comprar-c4flare" then
		TriggerServerEvent("vanilla-comprar","c4flare")	


	

	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS  vanilla
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		Citizen.Wait(1)
		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),96.88,-1292.58,29.27,true)
		if distance <= 30 then
			DrawMarker(21,96.88,-1292.58,29.27-0.6,0,0,0,0.0,0,0,0.5,0.5,-0.5,255,0,0,0,0,0,0,1)
			if distance <= 1.1 then
				if IsControlJustPressed(0,38) and emP.checkPermission() then
					ToggleActionMenu()
				end
			end
		end
	end
end)
