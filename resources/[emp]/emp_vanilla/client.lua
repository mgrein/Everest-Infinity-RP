local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emP = Tunnel.getInterface("emp_vanilla")

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÃO LAVAGEM 
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Wait(0)
		DrawMarker(21, 37.18,-1278.87,29.3, 0, 0, 0, 0, 180.0, 130.0, 0.6, 0.8, 0.5, 120, 250, 20, 160, 1, 0, 0, 1, 0, 0, 0)
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 37.18,-1278.87,29.3, true) <= 1.0 then	
            DisplayHelpText("~f~Pressione ~g~E~f~ para Lavar o Dinheiro")		
			if IsControlJustPressed(0, 38) and emP.CartaoCheck() then		
				DisplayHelpText("LAVANDO O ~g~DINHEIRO")
                TaskStartScenarioInPlace(GetPlayerPed(-1), "prop_human_bum_bin", 0, true)
                Citizen.Wait(10000)
                TriggerEvent("Notify","sucesso","Lavado com sucesso!")
                ClearPedTasksImmediately(GetPlayerPed(-1))
				TriggerServerEvent('receber:Dinheiro')
			end
		end		
	end
end)
