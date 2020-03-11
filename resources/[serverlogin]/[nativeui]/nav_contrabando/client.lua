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
	if data == "utilidades-comprar-algemas" then
		TriggerServerEvent("contrabando-comprar","algemas")
	elseif data == "utilidades-comprar-capuz" then
		TriggerServerEvent("contrabando-comprar","capuz")
	elseif data == "utilidades-comprar-lockpick" then
		TriggerServerEvent("contrabando-comprar","lockpick")
	elseif data == "utilidades-comprar-masterpick" then
		TriggerServerEvent("contrabando-comprar","masterpick")
	elseif data == "utilidades-comprar-pendrive" then
		TriggerServerEvent("contrabando-comprar","pendrive")
	elseif data == "utilidades-comprar-rebite" then
		TriggerServerEvent("contrabando-comprar","rebite")
	elseif data == "utilidades-comprar-placa" then
		TriggerServerEvent("contrabando-comprar","placa")
	elseif data == "utilidades-comprar-rubberducky" then
		TriggerServerEvent("contrabando-comprar","rubberducky")	
	elseif data == "utilidades-comprar-chavemestra" then
		TriggerServerEvent("contrabando-comprar","chavemestra")		
	elseif data == "utilidades-comprar-serra" then
		TriggerServerEvent("contrabando-comprar","serra")
	elseif data == "utilidades-comprar-furadeira" then
		TriggerServerEvent("contrabando-comprar","furadeira")

	elseif data == "utilidades-vender-algemas" then
		TriggerServerEvent("contrabando-vender","algemas")
	elseif data == "utilidades-vender-capuz" then
		TriggerServerEvent("contrabando-vender","capuz")
	elseif data == "utilidades-vender-lockpick" then
		TriggerServerEvent("contrabando-vender","lockpick")
	elseif data == "utilidades-vender-masterpick" then
		TriggerServerEvent("contrabando-vender","masterpick")
	elseif data == "utilidades-vender-pendrive" then
		TriggerServerEvent("contrabando-vender","pendrive")
	elseif data == "utilidades-vender-rebite" then
		TriggerServerEvent("contrabando-vender","rebite")
	elseif data == "utilidades-vender-rubberducky" then
		TriggerServerEvent("contrabando-vender","rubberducky")	
	elseif data == "utilidades-vender-chavemestra" then
		TriggerServerEvent("contrabando-vender","chavemestra")	
	elseif data == "utilidades-vender-serra" then
		TriggerServerEvent("contrabando-vender","serra")
	elseif data == "utilidades-vender-furadeira" then
		TriggerServerEvent("contrabando-vender","furadeira")		

	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS 1230.01,-2911.31,9.32
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		Citizen.Wait(1)
		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),1230.01,-2911.31,9.32,true)
		if distance <= 2.0 then
			if IsControlJustPressed(0,38) then
				ToggleActionMenu()
			end
		end
	end
end)