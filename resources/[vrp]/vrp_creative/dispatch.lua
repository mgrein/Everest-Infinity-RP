-----------------------------------------------------------------------------------------------------------------------------------------
-- DISPATCH
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	for i = 1,120 do
		EnableDispatchService(i,false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVER ARMA ABAIXO DE 40MPH DENTRO DO CARRO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local ped = PlayerPedId()
		local vehicle = GetVehiclePedIsIn(ped)
		if IsEntityAVehicle(vehicle) then
			local speed = GetEntitySpeed(vehicle)*2.236936
			if GetPedInVehicleSeat(vehicle,-1) == ped then
				if speed >= 50 then
					SetPlayerCanDoDriveBy(PlayerId(),false)
				else
					SetPlayerCanDoDriveBy(PlayerId(),true)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STATUS DO DISCORD
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10000)
		players = {}
		for i = 0,256 do
			if NetworkIsPlayerActive(i) then
				table.insert(players,i)
			end
		end
		SetDiscordAppId(633867412437073930)
		SetDiscordRichPresenceAsset('logo_name')
        SetRichPresence("Moradores : "..#players.."| 99")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ESTOURAR OS PNEUS
-----------------------------------------------------------------------------------------------------------------------------------------
--[[Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10000)
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			local vehicle = GetVehiclePedIsIn(PlayerPedId())
			if GetPedInVehicleSeat(vehicle,-1) == ped then
				local random = math.random(100)
				local speed = GetEntitySpeed(vehicle)*2.236936
				if speed >= 100 and random >= 97 then
					if GetVehicleTyresCanBurst(vehicle) == false then return end
					local pneus = GetVehicleNumberOfWheels(vehicle)
					local pneusEffects
					if pneus == 2 then
						pneusEffects = (math.random(2)-1)*4
					elseif pneus == 4 then
						pneusEffects = (math.random(4)-1)
						if pneusEffects > 1 then
							pneusEffects = pneusEffects + 2
						end
					elseif pneus == 6 then
						pneusEffects = (math.random(6)-1)
					else
						pneusEffects = 0
					end
					SetVehicleTyreBurst(vehicle,pneusEffects,false,1000.0)
				end
			end
		end
	end
end)]]
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLACKOUT
-----------------------------------------------------------------------------------------------------------------------------------------
local isBlackout = false
local oldSpeed = 0
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local vehicle = GetVehiclePedIsIn(PlayerPedId())
		if IsEntityAVehicle(vehicle) and GetPedInVehicleSeat(vehicle,-1) == PlayerPedId() then
			local currentSpeed = GetEntitySpeed(vehicle)*2.236936
			if currentSpeed ~= oldSpeed then
				if not isBlackout and (currentSpeed < oldSpeed) and ((oldSpeed - currentSpeed) >= 50) then
					blackout()
				end
				oldSpeed = currentSpeed
			end
		else
			if oldSpeed ~= 0 then
				oldSpeed = 0
			end
		end

		if isBlackout then
			DisableControlAction(0,71,true)
			DisableControlAction(0,72,true)
			DisableControlAction(0,63,true)
			DisableControlAction(0,64,true)
			DisableControlAction(0,75,true)
		end
	end
end)

function blackout()
	TriggerEvent("vrp_sound:source",'heartbeat',0.4)
	if not isBlackout then
		isBlackout = true
		SetEntityHealth(PlayerPedId(),GetEntityHealth(PlayerPedId())-25)
		Citizen.CreateThread(function()
			DoScreenFadeOut(900)
			while not IsScreenFadedOut() do
				Citizen.Wait(10)
			end
			Citizen.Wait(5000)
			DoScreenFadeIn(7000)
			isBlackout = false
		end)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {
	{ ['x'] = 265.64, ['y'] = -1261.30, ['z'] = 29.29, ['sprite'] = 361, ['color'] = 13, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = 819.65, ['y'] = -1028.84, ['z'] = 26.40, ['sprite'] = 361, ['color'] = 13, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = 1208.95, ['y'] = -1402.56, ['z'] = 35.22, ['sprite'] = 361, ['color'] = 13, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = 1181.38, ['y'] = -330.84, ['z'] = 69.31, ['sprite'] = 361, ['color'] = 13, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = 620.84, ['y'] = 269.10, ['z'] = 103.08, ['sprite'] = 361, ['color'] = 13, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = 2581.32, ['y'] = 362.03, ['z'] = 108.46, ['sprite'] = 361, ['color'] = 13, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = 176.63, ['y'] = -1562.02, ['z'] = 29.26, ['sprite'] = 361, ['color'] = 13, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = 176.63, ['y'] = -1562.02, ['z'] = 29.26, ['sprite'] = 361, ['color'] = 13, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = -319.29, ['y'] = -1471.71, ['z'] = 30.54, ['sprite'] = 361, ['color'] = 13, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = 1784.32, ['y'] = 3330.55, ['z'] = 41.25, ['sprite'] = 361, ['color'] = 13, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = 49.418, ['y'] = 2778.79, ['z'] = 58.04, ['sprite'] = 361, ['color'] = 13, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = 263.89, ['y'] = 2606.46, ['z'] = 44.98, ['sprite'] = 361, ['color'] = 13, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = 1039.95, ['y'] = 2671.13, ['z'] = 39.55, ['sprite'] = 361, ['color'] = 13, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = 1207.26, ['y'] = 2660.17, ['z'] = 37.89, ['sprite'] = 361, ['color'] = 13, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = 2539.68, ['y'] = 2594.19, ['z'] = 37.94, ['sprite'] = 361, ['color'] = 13, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = 2679.85, ['y'] = 3263.94, ['z'] = 55.24, ['sprite'] = 361, ['color'] = 13, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = 2005.05, ['y'] = 3773.88, ['z'] = 32.40, ['sprite'] = 361, ['color'] = 13, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = 1687.15, ['y'] = 4929.39, ['z'] = 42.07, ['sprite'] = 361, ['color'] = 13, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = 1701.31, ['y'] = 6416.02, ['z'] = 32.76, ['sprite'] = 361, ['color'] = 13, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = 179.85, ['y'] = 6602.83, ['z'] = 31.86, ['sprite'] = 361, ['color'] = 13, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = -94.46, ['y'] = 6419.59, ['z'] = 31.48, ['sprite'] = 361, ['color'] = 13, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = -2554.99, ['y'] = 2334.40, ['z'] = 33.07, ['sprite'] = 361, ['color'] = 13, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = -1800.37, ['y'] = 803.66, ['z'] = 138.65, ['sprite'] = 361, ['color'] = 13, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = -1437.62, ['y'] = -276.74, ['z'] = 46.20, ['sprite'] = 361, ['color'] = 13, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = -2096.24, ['y'] = -320.28, ['z'] = 13.16, ['sprite'] = 361, ['color'] = 13, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = -724.61, ['y'] = -935.16, ['z'] = 19.21, ['sprite'] = 361, ['color'] = 13, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = -526.01, ['y'] = -1211.00, ['z'] = 18.18, ['sprite'] = 361, ['color'] = 13, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 },
	{ ['x'] = -70.21, ['y'] = -1761.79, ['z'] = 29.53, ['sprite'] = 361, ['color'] = 13, ['nome'] = "Posto de Gasolina", ['scale'] = 0.4 }
}

Citizen.CreateThread(function()
	for _,v in pairs(blips) do
		local blip = AddBlipForCoord(v.x,v.y,v.z)
		SetBlipSprite(blip,v.sprite)
		SetBlipAsShortRange(blip,true)
		SetBlipColour(blip,v.color)
		SetBlipScale(blip,v.scale)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(v.nome)
		EndTextCommandSetBlipName(blip)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRIFT
-----------------------------------------------------------------------------------------------------------------------------------------
-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(1)
-- 		local ped = PlayerPedId()
-- 		if IsPedInAnyVehicle(ped) then
-- 			local vehicle = GetVehiclePedIsIn(PlayerPedId())
-- 			local speed = GetEntitySpeed(vehicle) * 2.236936
-- 			if GetPedInVehicleSeat(vehicle,-1) == ped then
-- 				if speed <= 100.0 then
-- 					if IsControlPressed(1,21) then
-- 						SetVehicleReduceGrip(vehicle,true)
-- 					else
-- 						SetVehicleReduceGrip(vehicle,false)
-- 					end
-- 				end
-- 			end
-- 		end
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COOLDOWN BUNNYHOP
-----------------------------------------------------------------------------------------------------------------------------------------
local bunnyhop = 0
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        if bunnyhop > 0 then
            bunnyhop = bunnyhop - 5
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        if IsPedJumping(ped) and bunnyhop <= 0 then
            bunnyhop = 5
        end
        if bunnyhop > 0 then
            DisableControlAction(0,22,true)
        end
        Citizen.Wait(5)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FALL WHILE RUNING AND JUMPING
-----------------------------------------------------------------------------------------------------------------------------------------
local ragdoll_chance = 0.30
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		local ped = PlayerPedId()
		if IsPedOnFoot(ped) and not IsPedSwimming(ped) and (IsPedRunning(ped) or IsPedSprinting(ped)) and not IsPedClimbing(ped) and IsPedJumping(ped) and not IsPedRagdoll(ped) then
			local chance_result = math.random()
			if chance_result < ragdoll_chance then
				Citizen.Wait(600)
                ShakeGameplayCam('SMALL_EXPLOSION_SHAKE',0.6)
				SetPedToRagdoll(ped,5000,1,2)
			else
				Citizen.Wait(2000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WALK SHAKE
-----------------------------------------------------------------------------------------------------------------------------------------
--[[playerMoving = false
Citizen.CreateThread(function()
	while true do 
		Wait(1)
		if not IsPedInAnyVehicle(PlayerPedId(), false) and GetEntitySpeed(PlayerPedId()) >= 0.5 and GetFollowPedCamViewMode() ~= 4 then
			if playerMoving == false then
				ShakeGameplayCam("ROAD_VIBRATION_SHAKE", 1.0)
				playerMoving = true
			end
		else
			if playerMoving == true then
				StopGameplayCamShaking(false)
				playerMoving = false
			end
		end
	end
end)]]