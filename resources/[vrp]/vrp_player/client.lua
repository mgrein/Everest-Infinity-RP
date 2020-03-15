local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- SALÁRIO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(15*60000)
		TriggerServerEvent('salario:pagamento')
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOCARJACK
-----------------------------------------------------------------------------------------------------------------------------------------
--[[Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if DoesEntityExist(GetVehiclePedIsTryingToEnter(PlayerPedId())) then
			local veh = GetVehiclePedIsTryingToEnter(PlayerPedId())
			if GetVehicleDoorLockStatus(veh) >= 2 or GetPedInVehicleSeat(veh,-1) then
				TriggerServerEvent("TryDoorsEveryone",veh,2,GetVehicleNumberPlateText(veh))
			end
		end
	end
end)

RegisterNetEvent("SyncDoorsEveryone")
AddEventHandler("SyncDoorsEveryone",function(veh,doors)
	SetVehicleDoorsLocked(veh,doors)
end)]]
-----------------------------------------------------------------------------------------------------------------------------------------
-- /ATTACHS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("attachs",function(source,args)
	local ped = PlayerPedId()
	if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_COMBATPISTOL") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPISTOL"),GetHashKey("COMPONENT_AT_PI_FLSH"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SMG") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG"),GetHashKey("COMPONENT_AT_AR_FLSH"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_SMG"),GetHashKey("COMPONENT_AT_SCOPE_MACRO_02"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_COMBATPDW") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPDW"),GetHashKey("COMPONENT_AT_AR_FLSH"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPDW"),GetHashKey("COMPONENT_AT_SCOPE_SMALL"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_COMBATPDW"),GetHashKey("COMPONENT_AT_AR_AFGRIP"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PUMPSHOTGUN_MK2") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN_MK2"),GetHashKey("COMPONENT_AT_SIGHTS"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN_MK2"),GetHashKey("COMPONENT_AT_SCOPE_SMALL_MK2"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN_MK2"),GetHashKey("COMPONENT_AT_AR_FLSH"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_CARBINERIFLE") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_AT_AR_FLSH"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),GetHashKey("COMPONENT_AT_AR_AFGRIP"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_MICROSMG") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MICROSMG"),GetHashKey("COMPONENT_AT_PI_FLSH"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_MICROSMG"),GetHashKey("COMPONENT_AT_SCOPE_MACRO"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_ASSAULTRIFLE") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE"),GetHashKey("COMPONENT_AT_AR_FLSH"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE"),GetHashKey("COMPONENT_AT_SCOPE_MACRO"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE"),GetHashKey("COMPONENT_AT_AR_AFGRIP"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTRIFLE"),GetHashKey("COMPONENT_ASSAULTRIFLE_VARMOD_LUXE"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PISTOL_MK2") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL_MK2"),GetHashKey("COMPONENT_AT_PI_RAIL"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL_MK2"),GetHashKey("COMPONENT_AT_PI_FLSH_02"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL_MK2"),GetHashKey("COMPONENT_AT_PI_COMP"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_REVOLVER_MK2") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_REVOLVER_MK2"),GetHashKey("COMPONENT_AT_PI_FLSH"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_REVOLVER_MK2"),GetHashKey("COMPONENT_AT_SIGHTS"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_REVOLVER_MK2"),GetHashKey("COMPONENT_REVOLVER_MK2_CAMO_IND_01"))	
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_ASSAULTSMG") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTSMG"),GetHashKey("COMPONENT_AT_AR_FLSH"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTSMG"),GetHashKey("COMPONENT_AT_SCOPE_MACRO"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_ASSAULTSMG"),GetHashKey("COMPONENT_ASSAULTSMG_VARMOD_LOWRIDER"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_PISTOL") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_PISTOL"),GetHashKey("COMPONENT_AT_PI_FLSH"))
	elseif GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_CARBINERIFLE_MK2") then
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"),GetHashKey("COMPONENT_CARBINERIFLE_MK2_CAMO_IND_01"))	
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"),GetHashKey("COMPONENT_AT_MUZZLE_04"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"),GetHashKey("COMPONENT_AT_SIGHTS"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_AFGRIP_02"))
		GiveWeaponComponentToPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"),GetHashKey("COMPONENT_AT_AR_FLSH"))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BEBIDAS ENERGETICAS
-----------------------------------------------------------------------------------------------------------------------------------------
local energetico = false
RegisterNetEvent('energeticos')
AddEventHandler('energeticos',function(status)
	energetico = status
	if energetico then
		SetRunSprintMultiplierForPlayer(PlayerId(),1.15)
	else
		SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if energetico then
			RestorePlayerStamina(PlayerId(),1.0)
		end
	end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- /RMASCARA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("rmascara")
AddEventHandler("rmascara",function()
	SetPedComponentVariation(PlayerPedId(),1,0,0,2)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- Cloneplates
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('cloneplates')
AddEventHandler('cloneplates',function()
	local vehicle = GetVehiclePedIsUsing(PlayerPedId())
    if IsEntityAVehicle(vehicle) then
    	SetVehicleNumberPlateText(vehicle,"EVE3T723")
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VROUPAS
-----------------------------------------------------------------------------------------------------------------------------------------
local player_customs = {}
RegisterCommand('vroupas',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local custom = vRPclient.getCustomization(source)
    if vRP.hasPermission(user_id,"polpar.permissao") then
        if player_customs[source] then
            player_customs[source] = nil
            vRPclient._removeDiv(source,"customization")
        else 
            local content = ""
            for k,v in pairs(custom) do
                content = content..k.." => "..json.encode(v).."<br/>" 
            end

            player_customs[source] = true
            vRPclient._setDiv(source,"customization",".div_customization{ margin: auto; padding: 4px; width: 250px; margin-top: 100px; margin-right: 50px; background: rgba(15,15,15,0.7); color: #ffff; font-weight: bold; }",content)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELANDO O F6
-----------------------------------------------------------------------------------------------------------------------------------------
local cancelando = false
RegisterNetEvent('cancelando')
AddEventHandler('cancelando',function(status)
    cancelando = status
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if cancelando then
			BlockWeaponWheelThisFrame()
			DisableControlAction(0,288,true)
			DisableControlAction(0,289,true)
			DisableControlAction(0,170,true)
			DisableControlAction(0,166,true)
			DisableControlAction(0,187,true)
			DisableControlAction(0,189,true)
			DisableControlAction(0,190,true)
			DisableControlAction(0,188,true)
			DisableControlAction(0,57,true)
			DisableControlAction(0,73,true)
			DisableControlAction(0,167,true)
			DisableControlAction(0,311,true)
			DisableControlAction(0,344,true)
			DisableControlAction(0,29,true)
			DisableControlAction(0,182,true)
			DisableControlAction(0,245,true)
			DisableControlAction(0,257,true)
			DisableControlAction(0,47,true)
			DisableControlAction(0,38,true)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AFKSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
        if x == px and y == py then
            if tempo > 0 then
                tempo = tempo - 1
                if tempo == 60 then
                    TriggerEvent("Notify","importante","Você vai ser desconectado em <b>60 segundos</b>.",8000)
                end
            else
                TriggerServerEvent("kickAFK")
            end
        else
            tempo = 1800
        end
        px = x
        py = y
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ABRIR PORTA-MALAS DO VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("pmalas",function(source,args)
	local vehicle = vRP.getNearestVehicle(7)
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("trytrunk",VehToNet(vehicle))
	end
end)

RegisterNetEvent("synctrunk")
AddEventHandler("synctrunk",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		local isopen = GetVehicleDoorAngleRatio(v,5)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				if isopen == 0 then
					SetVehicleDoorOpen(v,5,0,0)
				else
					SetVehicleDoorShut(v,5,0)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ABRIR CAPO DO VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hood",function(source,args)
	local vehicle = vRP.getNearestVehicle(7)
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("tryhood",VehToNet(vehicle))
	end
end)

RegisterNetEvent("synchood")
AddEventHandler("synchood",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		local isopen = GetVehicleDoorAngleRatio(v,4)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				if isopen == 0 then
					SetVehicleDoorOpen(v,4,0,0)
				else
					SetVehicleDoorShut(v,4,0)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ABRE E FECHA OS VIDROS
-----------------------------------------------------------------------------------------------------------------------------------------
local vidros = false
RegisterCommand("wins",function(source,args)
	local vehicle = vRP.getNearestVehicle(7)
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("trywins",VehToNet(vehicle))
	end
end)

RegisterNetEvent("syncwins")
AddEventHandler("syncwins",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				if vidros then
					vidros = false
					RollUpWindow(v,0)
					RollUpWindow(v,1)
					RollUpWindow(v,2)
					RollUpWindow(v,3)
				else
					vidros = true
					RollDownWindow(v,0)
					RollDownWindow(v,1)
					RollDownWindow(v,2)
					RollDownWindow(v,3)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ABRIR PORTAS DO VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("doors",function(source,args)
	local vehicle = vRP.getNearestVehicle(7)
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("trydoors",VehToNet(vehicle),args[1])
	end
end)

RegisterNetEvent("syncdoors")
AddEventHandler("syncdoors",function(index,door)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		local isopen = GetVehicleDoorAngleRatio(v,0) and GetVehicleDoorAngleRatio(v,1)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				if door == "1" then
					if GetVehicleDoorAngleRatio(v,0) == 0 then
						SetVehicleDoorOpen(v,0,0,0)
					else
						SetVehicleDoorShut(v,0,0)
					end
				elseif door == "2" then
					if GetVehicleDoorAngleRatio(v,1) == 0 then
						SetVehicleDoorOpen(v,1,0,0)
					else
						SetVehicleDoorShut(v,1,0)
					end
				elseif door == "3" then
					if GetVehicleDoorAngleRatio(v,2) == 0 then
						SetVehicleDoorOpen(v,2,0,0)
					else
						SetVehicleDoorShut(v,2,0)
					end
				elseif door == "4" then
					if GetVehicleDoorAngleRatio(v,3) == 0 then
						SetVehicleDoorOpen(v,3,0,0)
					else
						SetVehicleDoorShut(v,3,0)
					end
				elseif door == nil then
					if isopen == 0 then
						SetVehicleDoorOpen(v,0,0,0)
						SetVehicleDoorOpen(v,1,0,0)
						SetVehicleDoorOpen(v,2,0,0)
						SetVehicleDoorOpen(v,3,0,0)
					else
						SetVehicleDoorShut(v,0,0)
						SetVehicleDoorShut(v,1,0)
						SetVehicleDoorShut(v,2,0)
						SetVehicleDoorShut(v,3,0)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /ME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('chatME')
AddEventHandler('chatME',function(id,name,message)
	local myId = PlayerId()
	local pid = GetPlayerFromServerId(id)
	if pid == myId then
		TriggerEvent('chatMessage',"",{},"* "..name.." "..message)
	elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)),GetEntityCoords(GetPlayerPed(pid))) < 3.999 then
		TriggerEvent('chatMessage',"",{},"* "..name.." "..message)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /MASCARA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("mascara")
AddEventHandler("mascara",function(index,color)
	local ped = GetPlayerPed(-1)
	if index == nil then
		vRP.playAnim(true,{{"misscommon@std_take_off_masks","take_off_mask_ps",1}},false)
		Wait(700)
		ClearPedTasks(ped)
		SetPedComponentVariation(ped,1,0,0,2)
		return
	end
	if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") or GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
		vRP.playAnim(true,{{"misscommon@van_put_on_masks","put_on_mask_ps",1}},false)
		Wait(1500)
		ClearPedTasks(ped)
		SetPedComponentVariation(ped,1,parseInt(index),parseInt(color),2)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /blusa
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("blusa")
AddEventHandler("blusa",function(index,color)
	local ped = GetPlayerPed(-1)
	if index == nil then
		vRP.playAnim(true,{{"misscommon@std_take_off_masks","take_off_mask_ps",1}},false)
		Wait(700)
		SetPedComponentVariation(ped,8,15,0,2)
		return
	end
	if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
		SetPedComponentVariation(ped,8,parseInt(index),parseInt(color),2)
	elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
		SetPedComponentVariation(ped,8,parseInt(index),parseInt(color),2)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /jaqueta
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("jaqueta")
AddEventHandler("jaqueta",function(index,color)
	local ped = GetPlayerPed(-1)
	if index == nil then
		vRP._playAnim(true,{{"clothingshirt","try_shirt_positive_d"}},false)
		Wait(2500)
		SetPedComponentVariation(ped,11,15,0,2)
		return
	end
	if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
		vRP._playAnim(true,{{"clothingshirt","try_shirt_positive_d"}},false)
		Wait(2500)
		SetPedComponentVariation(ped,11,parseInt(index),parseInt(color),2)
	elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
		vRP._playAnim(true,{{"clothingshirt","try_shirt_positive_d"}},false)
		Wait(2500)
		SetPedComponentVariation(ped,11,parseInt(index),parseInt(color),2)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /calca
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("calca")
AddEventHandler("calca",function(index,color)
	local ped = GetPlayerPed(-1)
	if index == nil then
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP._playAnim(true,{{"clothingtrousers","try_trousers_neutral_c"}},false)
			Wait(2500)
			SetPedComponentVariation(ped,4,18,0,2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(true,{{"clothingtrousers","try_trousers_neutral_c"}},false)
			Wait(2500)
			SetPedComponentVariation(ped,4,15,0,2)
		end
		return
	end
	if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
		vRP._playAnim(true,{{"clothingtrousers","try_trousers_neutral_c"}},false)
		Wait(2500)
		SetPedComponentVariation(ped,4,parseInt(index),parseInt(color),2)
	elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
		vRP._playAnim(true,{{"clothingtrousers","try_trousers_neutral_c"}},false)
		Wait(2500)
		SetPedComponentVariation(ped,4,parseInt(index),parseInt(color),2)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /maos
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("maos")
AddEventHandler("maos",function(index,color)
	local ped = GetPlayerPed(-1)
	if index == nil then
		SetPedComponentVariation(ped,3,15,0,2)
		return
	end
	if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
		SetPedComponentVariation(ped,3,parseInt(index),parseInt(color),2)
	elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
		SetPedComponentVariation(ped,3,parseInt(index),parseInt(color),2)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /acess
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("acessorios")
AddEventHandler("acessorios",function(index,color)
	local ped = GetPlayerPed(-1)
	if index == nil then
		SetPedComponentVariation(ped,7,0,0,2)
		return
	end
	if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
		SetPedComponentVariation(ped,7,parseInt(index),parseInt(color),2)
	elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
		SetPedComponentVariation(ped,7,parseInt(index),parseInt(color),2)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /colete
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("colete")
AddEventHandler("colete",function(index,color)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101  then
		if not modelo then
			vRP._playAnim(true,{{"clothingshirt","try_shirt_positive_d"}},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,9,0,0,2)
			return
		end
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP._playAnim(true,{{"clothingshirt","try_shirt_positive_d"}},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,9,parseInt(modelo),parseInt(cor),2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(true,{{"clothingshirt","try_shirt_positive_d"}},false)
			Wait(2500)
			ClearPedTasks(ped)
			SetPedComponentVariation(ped,9,parseInt(modelo),parseInt(cor),2)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /sapatos
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("sapatos")
AddEventHandler("sapatos",function(index,color)
	local ped = GetPlayerPed(-1)
	if index == nil then
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			vRP._playAnim(false,{{"clothingshoes","try_shoes_positive_d"}},false)
		Wait(1700)
			SetPedComponentVariation(ped,6,34,0,2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			vRP._playAnim(false,{{"clothingshoes","try_shoes_positive_d"}},false)
		Wait(1700)
			SetPedComponentVariation(ped,6,35,0,2)
			
		end
		return
	end
	if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
		vRP._playAnim(false,{{"clothingshoes","try_shoes_positive_d"}},false)
		Wait(1700)
		SetPedComponentVariation(ped,6,parseInt(index),parseInt(color),2)
	elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
		vRP._playAnim(false,{{"clothingshoes","try_shoes_positive_d"}},false)
		Wait(1700)
		SetPedComponentVariation(ped,6,parseInt(index),parseInt(color),2)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /CHAPEU
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chapeu")
AddEventHandler("chapeu",function(index,color)
	local ped = GetPlayerPed(-1)
	if index == nil then
		vRP.playAnim(true,{{"veh@common@fp_helmet@","take_off_helmet_stand",1}},false)
		Wait(700)
		ClearPedProp(ped,0)
		return
	end
	if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
		vRP.playAnim(true,{{"veh@common@fp_helmet@","put_on_helmet",1}},false)
		Wait(1700)
		SetPedPropIndex(ped,0,parseInt(index),parseInt(color),2)
	elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
		vRP.playAnim(true,{{"veh@common@fp_helmet@","put_on_helmet",1}},false)
		Wait(1700)
		SetPedPropIndex(ped,0,parseInt(index),parseInt(color),2)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /OCULOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("oculos")
AddEventHandler("oculos",function(index,color)
	local ped = GetPlayerPed(-1)
	if index == nil then
		vRP.playAnim(true,{{"misscommon@std_take_off_masks","take_off_mask_ps",1}},false)
		Wait(400)
		ClearPedTasks(ped)
		ClearPedProp(ped,1)
		return
	end
	if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
		vRP.playAnim(true,{{"misscommon@van_put_on_masks","put_on_mask_ps",1}},false)
		Wait(800)
		ClearPedTasks(ped)
		SetPedPropIndex(ped,1,parseInt(index),parseInt(color),2)
	elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
		vRP.playAnim(true,{{"misscommon@van_put_on_masks","put_on_mask_ps",1}},false)
		Wait(800)
		ClearPedTasks(ped)
		SetPedPropIndex(ped,1,parseInt(index),parseInt(color),2)
	end
end)
------
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANDAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("homem",function(source,args)
	vRP.loadAnimSet("move_m@confident")
end)

RegisterCommand("mulher",function(source,args)
	vRP.loadAnimSet("move_f@heels@c")
end)

RegisterCommand("depressivo",function(source,args)
	vRP.loadAnimSet("move_m@depressed@a")
end)

RegisterCommand("depressiva",function(source,args)
	vRP.loadAnimSet("move_f@depressed@a")
end)

RegisterCommand("empresario",function(source,args)
	vRP.loadAnimSet("move_m@business@a")
end)

RegisterCommand("determinado",function(source,args)
	vRP.loadAnimSet("move_m@brave@a")
end)

RegisterCommand("descontraido",function(source,args)
	vRP.loadAnimSet("move_m@casual@a")
end)

RegisterCommand("farto",function(source,args)
	vRP.loadAnimSet("move_m@fat@a")
end)

RegisterCommand("estiloso",function(source,args)
	vRP.loadAnimSet("move_m@hipster@a")
end)

RegisterCommand("ferido",function(source,args)
	vRP.loadAnimSet("move_m@injured")
end)

RegisterCommand("nervoso",function(source,args)
	vRP.loadAnimSet("move_m@hurry@a")
end)

RegisterCommand("desleixado",function(source,args)
	vRP.loadAnimSet("move_m@hobo@a")
end)

RegisterCommand("infeliz",function(source,args)
	vRP.loadAnimSet("move_m@sad@a")
end)

RegisterCommand("musculoso",function(source,args)
	vRP.loadAnimSet("move_m@muscle@a")
end)


RegisterCommand("desligado",function(source,args)
	vRP.loadAnimSet("move_m@shadyped@a")
end)

RegisterCommand("fadiga",function(source,args)
	vRP.loadAnimSet("move_m@buzzed")
end)

RegisterCommand("apressado",function(source,args)
	vRP.loadAnimSet("move_m@hurry_butch@a")
end)

RegisterCommand("descolado",function(source,args)
	vRP.loadAnimSet("move_m@money")
end)

RegisterCommand("corridinha",function(source,args)
	vRP.loadAnimSet("move_m@quick")
end)

RegisterCommand("piriguete",function(source,args)
	vRP.loadAnimSet("move_f@maneater")
end)

RegisterCommand("petulante",function(source,args)
	vRP.loadAnimSet("move_f@sassy")
end)

RegisterCommand("arrogante",function(source,args)
	vRP.loadAnimSet("move_f@arrogant@a")
end)

RegisterCommand("bebado",function(source,args)
	vRP.loadAnimSet("move_m@drunk@slightlydrunk")
end)

RegisterCommand("bebado2",function(source,args)
	vRP.loadAnimSet("move_m@drunk@verydrunk")
end)

RegisterCommand("bebado3",function(source,args)
	vRP.loadAnimSet("move_m@drunk@moderatedrunk")
end)

RegisterCommand("irritado",function(source,args)
	vRP.loadAnimSet("move_m@fire")
end)

RegisterCommand("intimidado",function(source,args)
	vRP.loadAnimSet("move_m@intimidation@cop@unarmed")
end)

RegisterCommand("poderosa",function(source,args)
	vRP.loadAnimSet("move_f@handbag")
end)

RegisterCommand("chateado",function(source,args)
	vRP.loadAnimSet("move_f@injured")
end)

RegisterCommand("estilosa",function(source,args)
	vRP.loadAnimSet("move_f@posh@")
end)

RegisterCommand("sensual",function(source,args)
	vRP.loadAnimSet("move_f@sexy@a")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /TOW
-----------------------------------------------------------------------------------------------------------------------------------------
local reboque = nil
local rebocado = nil
RegisterCommand("tow",function(source,args)
	local vehicle = GetPlayersLastVehicle()
	local vehicletow = IsVehicleModel(vehicle,GetHashKey("flatbed"))

	if vehicletow and not IsPedInAnyVehicle(PlayerPedId()) then
		rebocado = getVehicleInDirection(GetEntityCoords(PlayerPedId()),GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,5.0,0.0))
		if reboque == nil then
			if vehicle ~= rebocado then
				local min,max = GetModelDimensions(GetEntityModel(rebocado))
				AttachEntityToEntity(rebocado,vehicle,GetEntityBoneIndexByName(vehicle,"bodyshell"),0,-2.2,0.4-min.z,0,0,0,1,1,0,1,0,1)
				reboque = rebocado
			end
		else
			AttachEntityToEntity(reboque,vehicle,20,-0.5,-15.0,-0.3,0.0,0.0,0.0,false,false,true,false,20,true)
			DetachEntity(reboque,false,false)
			PlaceObjectOnGroundProperly(reboque)
			reboque = nil
			rebocado = nil
		end
	end
end)

function getVehicleInDirection(coordsfrom,coordsto)
	local handle = CastRayPointToPoint(coordsfrom.x,coordsfrom.y,coordsfrom.z,coordsto.x,coordsto.y,coordsto.z,10,PlayerPedId(),false)
	local a,b,c,d,vehicle = GetRaycastResult(handle)
	return vehicle
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPARAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('reparar')
AddEventHandler('reparar',function()
	local vehicle = vRP.getNearestVehicle(7)
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("tryreparar",VehToNet(vehicle))
	end
end)

RegisterNetEvent('syncreparar')
AddEventHandler('syncreparar',function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		local fuel = GetVehicleFuelLevel(v)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				SetVehicleFixed(v)
				SetVehicleDirtLevel(v,0.0)
				SetVehicleUndriveable(v,false)
				Citizen.InvokeNative(0xAD738C3085FE7E11,v,true,true)
				SetVehicleOnGroundProperly(v)
				SetVehicleFuelLevel(v,fuel)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPARAR MOTOR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('repararmotor')
AddEventHandler('repararmotor',function()
	local vehicle = vRP.getNearestVehicle(7)
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("trymotor",VehToNet(vehicle))
	end
end)

RegisterNetEvent('syncmotor')
AddEventHandler('syncmotor',function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				SetVehicleEngineHealth(v,1000.0)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /CARTAS
-----------------------------------------------------------------------------------------------------------------------------------------
local card = {
	[1] = "A",
	[2] = "2",
	[3] = "3",
	[4] = "4",
	[5] = "5",
	[6] = "6",
	[7] = "7",
	[8] = "8",
	[9] = "9",
	[10] = "10",
	[11] = "J",
	[12] = "Q",
	[13] = "K"
}

local tipos = {
	[1] = "^8♣",
	[2] = "^8♠",
	[3] = "^9♦",
	[4] = "^9♥"
}

RegisterNetEvent('CartasMe')
AddEventHandler('CartasMe',function(id,name,cd,naipe)
	local monid = PlayerId()
	local sonid = GetPlayerFromServerId(id)
	if sonid == monid then
		TriggerEvent('chatMessage',"",{},"^3* "..name.." tirou do baralho a carta: "..card[cd]..""..tipos[naipe])
	elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(monid)),GetEntityCoords(GetPlayerPed(sonid)),true) < 5.999 then
		TriggerEvent('chatMessage',"",{},"^3* "..name.." tirou do baralho a carta: "..card[cd]..""..tipos[naipe])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /CARREGAR
-----------------------------------------------------------------------------------------------------------------------------------------
local carregado = false
RegisterCommand("carregar",function(source,args)
	local ped = PlayerPedId()
	local randomico,npcs = FindFirstPed()
	repeat
		local distancia = GetDistanceBetweenCoords(GetEntityCoords(ped),GetEntityCoords(npcs),true)
		if not IsPedAPlayer(npcs) and distancia <= 3 and not IsPedInAnyVehicle(ped) and not IsPedInAnyVehicle(npcs) then
			if carregado then
				ClearPedTasksImmediately(carregado)
				DetachEntity(carregado,true,true)
				TaskWanderStandard(carregado,10.0,10)
				Citizen.InvokeNative(0xAD738C3085FE7E11,carregado,true,true)
				carregado = false
			else
				Citizen.InvokeNative(0xAD738C3085FE7E11,npcs,true,true)
				AttachEntityToEntity(npcs,ped,4103,11816,0.48,0.0,0.0,0.0,0.0,0.0,false,false,true,false,2,true)
				carregado = npcs
				sucess = true
			end
		end
	sucess,npcs = FindNextPed(randomico)
	until not sucess
	EndFindPed(randomico)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /sequestro2
-----------------------------------------------------------------------------------------------------------------------------------------
local sequestrado = nil
RegisterCommand("sequestro2",function(source,args)
	local ped = PlayerPedId()
	local random,npc = FindFirstPed()
	repeat
		local distancia = GetDistanceBetweenCoords(GetEntityCoords(ped),GetEntityCoords(npc),true)
		if not IsPedAPlayer(npc) and distancia <= 3 and not IsPedInAnyVehicle(npc) then
			vehicle = vRP.getNearestVehicle(7)
			if IsEntityAVehicle(vehicle) then
				if vRP.getCarroClass(vehicle) then
					if sequestrado then
						AttachEntityToEntity(sequestrado,vehicle,GetEntityBoneIndexByName(vehicle,"bumper_r"),0.6,-1.2,-0.6,60.0,-90.0,180.0,false,false,false,true,2,true)
						DetachEntity(sequestrado,true,true)
						SetEntityVisible(sequestrado,true)
						SetEntityInvincible(sequestrado,false)
						Citizen.InvokeNative(0xAD738C3085FE7E11,sequestrado,true,true)
						ClearPedTasksImmediately(sequestrado)
						sequestrado = nil
					elseif not sequestrado then
						Citizen.InvokeNative(0xAD738C3085FE7E11,npc,true,true)
						AttachEntityToEntity(npc,vehicle,GetEntityBoneIndexByName(vehicle,"bumper_r"),0.6,-0.4,-0.1,60.0,-90.0,180.0,false,false,false,true,2,true)
						SetEntityVisible(npc,false)
						SetEntityInvincible(npc,true)
						sequestrado = npc
						complet = true
					end
					TriggerServerEvent("trymala",VehToNet(vehicle))
				end
			end
		end
		complet,npc = FindNextPed(random)
	until not complet
	EndFindPed(random)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EMPURRAR
-----------------------------------------------------------------------------------------------------------------------------------------
local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end
		enum.destructor = nil
		enum.handle = nil
	end
}

local function EnumerateEntities(initFunc,moveFunc,disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = { handle = iter, destructor = disposeFunc }
		setmetatable(enum, entityEnumerator)

		local next = true
		repeat
		coroutine.yield(id)
		next,id = moveFunc(iter)
		until not next

		enum.destructor,enum.handle = nil,nil
		disposeFunc(iter)
	end)
end

function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle,FindNextVehicle,EndFindVehicle)
end

function GetVeh()
    local vehicles = {}
    for vehicle in EnumerateVehicles() do
        table.insert(vehicles,vehicle)
    end
    return vehicles
end

function GetClosestVeh(coords)
	local vehicles = GetVeh()
	local closestDistance = -1
	local closestVehicle = -1
	local coords = coords

	if coords == nil then
		local ped = PlayerPedId()
		coords = GetEntityCoords(ped)
	end

	for i=1,#vehicles,1 do
		local vehicleCoords = GetEntityCoords(vehicles[i])
		local distance = GetDistanceBetweenCoords(vehicleCoords,coords.x,coords.y,coords.z,true)
		if closestDistance == -1 or closestDistance > distance then
			closestVehicle  = vehicles[i]
			closestDistance = distance
		end
	end
	return closestVehicle,closestDistance
end

local First = vector3(0.0,0.0,0.0)
local Second = vector3(5.0,5.0,5.0)
local Vehicle = { Coords = nil, Vehicle = nil, Dimension = nil, IsInFront = false, Distance = nil }

Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local closestVehicle,Distance = GetClosestVeh()
		if Distance < 6.1 and not IsPedInAnyVehicle(ped) then
			Vehicle.Coords = GetEntityCoords(closestVehicle)
			Vehicle.Dimensions = GetModelDimensions(GetEntityModel(closestVehicle),First,Second)
			Vehicle.Vehicle = closestVehicle
			Vehicle.Distance = Distance
			if GetDistanceBetweenCoords(GetEntityCoords(closestVehicle) + GetEntityForwardVector(closestVehicle), GetEntityCoords(ped), true) > GetDistanceBetweenCoords(GetEntityCoords(closestVehicle) + GetEntityForwardVector(closestVehicle) * -1, GetEntityCoords(ped), true) then
				Vehicle.IsInFront = false
			else
				Vehicle.IsInFront = true
			end
		else
			Vehicle = { Coords = nil, Vehicle = nil, Dimensions = nil, IsInFront = false, Distance = nil }
		end
		Citizen.Wait(500)
	end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(500)
		if Vehicle.Vehicle ~= nil then
			local ped = PlayerPedId()
			if IsControlPressed(0,244) and GetEntityHealth(ped) > 100 and IsVehicleSeatFree(Vehicle.Vehicle,-1) and not IsEntityAttachedToEntity(ped,Vehicle.Vehicle) and not (GetEntityRoll(Vehicle.Vehicle) > 75.0 or GetEntityRoll(Vehicle.Vehicle) < -75.0) then
				RequestAnimDict('missfinale_c2ig_11')
				TaskPlayAnim(ped,'missfinale_c2ig_11','pushcar_offcliff_m',2.0,-8.0,-1,35,0,0,0,0)
				NetworkRequestControlOfEntity(Vehicle.Vehicle)

				if Vehicle.IsInFront then
					AttachEntityToEntity(ped,Vehicle.Vehicle,GetPedBoneIndex(6286),0.0,Vehicle.Dimensions.y*-1+0.1,Vehicle.Dimensions.z+1.0,0.0,0.0,180.0,0.0,false,false,true,false,true)
				else
					AttachEntityToEntity(ped,Vehicle.Vehicle,GetPedBoneIndex(6286),0.0,Vehicle.Dimensions.y-0.3,Vehicle.Dimensions.z+1.0,0.0,0.0,0.0,0.0,false,false,true,false,true)
				end

				while true do
					Citizen.Wait(5)
					if IsDisabledControlPressed(0,34) then
						TaskVehicleTempAction(ped,Vehicle.Vehicle,11,100)
					end

					if IsDisabledControlPressed(0,9) then
						TaskVehicleTempAction(ped,Vehicle.Vehicle,10,100)
					end

					if Vehicle.IsInFront then
						SetVehicleForwardSpeed(Vehicle.Vehicle,-1.0)
					else
						SetVehicleForwardSpeed(Vehicle.Vehicle,1.0)
					end

					if not IsDisabledControlPressed(0,244) then
						DetachEntity(ped,false,false)
						StopAnimTask(ped,'missfinale_c2ig_11','pushcar_offcliff_m',2.0)
						break
					end
				end
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- VTUNING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("vtuning",function(source,args)
	local vehicle = GetVehiclePedIsUsing(PlayerPedId())
	if IsEntityAVehicle(vehicle) then
		local motor = GetVehicleMod(vehicle,11)
		local freio = GetVehicleMod(vehicle,12)
		local transmissao = GetVehicleMod(vehicle,13)
		local turbo = IsToggleModOn(vehicle,18)
		local turbotxt = ""
		local suspensao = GetVehicleMod(vehicle,15)
		local blindagem = GetVehicleMod(vehicle,16)
		local body = GetVehicleBodyHealth(vehicle)
		local engine = GetVehicleEngineHealth(vehicle)
		local fuel = GetVehicleFuelLevel(vehicle)

		if motor == -1 then
			motor = "Desativado"
		elseif motor == 0 then
			motor = "Nível 1 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 1 then
			motor = "Nível 2 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 2 then
			motor = "Nível 3 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 3 then
			motor = "Nível 4 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 4 then
			motor = "Nível 5 / "..GetNumVehicleMods(vehicle,11)
		end

		if freio == -1 then
			freio = "Desativado"
		elseif freio == 0 then
			freio = "Nível 1 / "..GetNumVehicleMods(vehicle,12)
		elseif freio == 1 then
			freio = "Nível 2 / "..GetNumVehicleMods(vehicle,12)
		elseif freio == 2 then
			freio = "Nível 3 / "..GetNumVehicleMods(vehicle,12)
		end

		if transmissao == -1 then
			transmissao = "Desativada"
		elseif transmissao == 0 then
			transmissao = "Nível 1 / "..GetNumVehicleMods(vehicle,13)
		elseif transmissao == 1 then
			transmissao = "Nível 2 / "..GetNumVehicleMods(vehicle,13)
		elseif transmissao == 2 then
			transmissao = "Nível 3 / "..GetNumVehicleMods(vehicle,13)
		elseif transmissao == 3 then
			transmissao = "Nível 4 / "..GetNumVehicleMods(vehicle,13)
		end

		if turbo == false then
			turbotxt = "Desativado"
		else 
			turbotxt = "Instalado"
		end
		
		if suspensao == -1 then
			suspensao = "Desativada"
		elseif suspensao == 0 then
			suspensao = "Nível 1 / "..GetNumVehicleMods(vehicle,15)
		elseif suspensao == 1 then
			suspensao = "Nível 2 / "..GetNumVehicleMods(vehicle,15)
		elseif suspensao == 2 then
			suspensao = "Nível 3 / "..GetNumVehicleMods(vehicle,15)
		elseif suspensao == 3 then
			suspensao = "Nível 4 / "..GetNumVehicleMods(vehicle,15)
		end

		if blindagem == -1 then
			blindagem = "Desativada"
		elseif blindagem == 0 then
			blindagem = "Nível 1 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 1 then
			blindagem = "Nível 2 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 2 then
			blindagem = "Nível 3 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 3 then
			blindagem = "Nível 4 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 4 then
			blindagem = "Nível 5 / "..GetNumVehicleMods(vehicle,16)
		end

		TriggerEvent("Notify","aviso","<b>Motor:</b> "..motor.."<br><b>Freio:</b> "..freio.."<br><b>Transmissão:</b> "..transmissao.."<br><b>Turbo:</b> "..turbotxt.."<br><b>Suspensão:</b> "..suspensao.."<br><b>Blindagem:</b> "..blindagem.."<br><b>Chassi:</b> "..parseInt(body/10).."%<br><b>Engine:</b> "..parseInt(engine/10).."%<br><b>Gasolina:</b> "..parseInt(fuel).."%",8000)
	end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- RASTREAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('rastrear')
AddEventHandler('rastrear',function() 
	local player = GetPlayerPed(-1)
	if (IsPedSittingInAnyVehicle(player)) then 
		saveVehicle = GetVehiclePedIsIn(player,true)
		local vehicle = saveVehicle
		targetBlip = AddBlipForEntity(vehicle)
		SetBlipSprite(targetBlip,161)
		if not i then i = 0 end
		SetBlipColour(targetBlip,i)
		i=i+1
		SetBlipScale(targetBlip,0.1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Rastreador")
		EndTextCommandSetBlipName(targetBlip)
		ShowNotification("~g~Instalando rastreador.")
	else ShowNotification("~r~Você deve instalar um rastreador em um veículo.") end
end)

function ShowNotification( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
end
---------------------------------------------------------------------------------------------------------------------------------------
-----------------AGACHAR---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------
local crouch = false
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local ped = PlayerPedId()
        DisableControlAction(0, 36, true)
        if not IsPedInAnyVehicle(ped) then
            RequestAnimSet("move_ped_crouched")
            RequestAnimSet("move_ped_crouched_strafing")
            if IsDisabledControlJustPressed(0, 36) then
                if crouch then
                    ResetPedMovementClipset(ped, 0.25)
                    ResetPedStrafeClipset(ped)
                    crouch = false
                else
                    SetPedMovementClipset(ped, "move_ped_crouched", 0.25)
                    SetPedStrafeClipset(ped, "move_ped_crouched_strafing")
                    crouch = true
                end
            end
        end
    end
end)
----------------------
--- Taser Cartridge Limit ---
---     Made by FAXES     ---
-----------------------------

--- Config ---

maxTaserCarts = 5 -- The amount of taser cartridges a person can have.
refillCommand = "tazer" -- The command to refill taser cartridges
longerTazeTime = true -- Want longer taze times? true/false
longerTazeSecTime = 10 -- Time in SECONDS to extend the longer taze time.

--- Code ---

local taserCartsLeft = maxTaserCarts

function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

RegisterCommand(refillCommand, function(source, args, rawCommand)
    taserCartsLeft = maxTaserCarts
    print("[Fax Taser Cartridge] Taser Cartridges Left = " .. taserCartsLeft)
    ShowNotification("~g~Cartuchos do tazer recarregados.")
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = GetPlayerPed(-1)
        local taserModel = GetHashKey("WEAPON_STUNGUN")

        if GetSelectedPedWeapon(ped) == taserModel then
            if IsPedShooting(ped) then
                taserCartsLeft = taserCartsLeft - 1
                print("[Fax Cartucho Tazer] Cartuchos de Tazer Restantes = " .. taserCartsLeft)
            end
        end

        if taserCartsLeft <= 0 then
            if GetSelectedPedWeapon(ped) == taserModel then
                SetPlayerCanDoDriveBy(ped, false)
                DisablePlayerFiring(ped, true)
                if IsControlPressed(0, 106) then
                    ShowNotification("~y~Tazer sem cartucho. Por favor use /" .. refillCommand)
                end
            else
                -- Do nothing
            end
        end

        if longerTazeTime then
            SetPedMinGroundTimeForStungun(ped, longerTazeSecTime * 1000)
        end
    end
end)

RegisterNetEvent("updateRoupas")
AddEventHandler("updateRoupas",function(custom)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 then
		if custom[1] == -1 then
			SetPedComponentVariation(ped,1,0,0,2)
		else
			SetPedComponentVariation(ped,1,custom[1],custom[2],2)
		end

		if custom[3] == -1 then
			SetPedComponentVariation(ped,5,0,0,2)
		else
			SetPedComponentVariation(ped,5,custom[3],custom[4],2)
		end

		if custom[5] == -1 then
			SetPedComponentVariation(ped,7,0,0,2)
		else
			SetPedComponentVariation(ped,7,custom[5],custom[6],2)
		end

		if custom[7] == -1 then
			SetPedComponentVariation(ped,3,15,0,2)
		else
			SetPedComponentVariation(ped,3,custom[7],custom[8],2)
		end

		if custom[9] == -1 then
			if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
				SetPedComponentVariation(ped,4,18,0,2)
			elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
				SetPedComponentVariation(ped,4,15,0,2)
			end
		else
			SetPedComponentVariation(ped,4,custom[9],custom[10],2)
		end

		if custom[11] == -1 then
			SetPedComponentVariation(ped,8,15,0,2)
		else
			SetPedComponentVariation(ped,8,custom[11],custom[12],2)
		end

		if custom[13] == -1 then
			if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
				SetPedComponentVariation(ped,6,34,0,2)
			elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
				SetPedComponentVariation(ped,6,35,0,2)
			end
		else
			SetPedComponentVariation(ped,6,custom[13],custom[14],2)
		end

		if custom[15] == -1 then
			SetPedComponentVariation(ped,11,15,0,2)
		else
			SetPedComponentVariation(ped,11,custom[15],custom[16],2)
		end

		if custom[17] == -1 then
			SetPedComponentVariation(ped,9,0,0,2)
		else
			SetPedComponentVariation(ped,9,custom[17],custom[18],2)
		end

		if custom[19] == -1 then
			SetPedComponentVariation(ped,10,0,0,2)
		else
			SetPedComponentVariation(ped,10,custom[19],custom[20],2)
		end

		if custom[21] == -1 then
			ClearPedProp(ped,0)
		else
			SetPedPropIndex(ped,0,custom[21],custom[22],2)
		end

		if custom[23] == -1 then
			ClearPedProp(ped,1)
		else
			SetPedPropIndex(ped,1,custom[23],custom[24],2)
		end

		if custom[25] == -1 then
			ClearPedProp(ped,2)
		else
			SetPedPropIndex(ped,2,custom[25],custom[26],2)
		end

		if custom[27] == -1 then
			ClearPedProp(ped,6)
		else
			SetPedPropIndex(ped,6,custom[27],custom[28],2)
		end

		if custom[29] == -1 then
			ClearPedProp(ped,7)
		else
			SetPedPropIndex(ped,7,custom[29],custom[30],2)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRATAMENTO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('tratamento')
AddEventHandler('tratamento',function()
	repeat
		SetEntityHealth(PlayerPedId(),GetEntityHealth(PlayerPedId())+4)
		Citizen.Wait(3600)
	until GetEntityHealth(PlayerPedId()) >= 400 or GetEntityHealth(PlayerPedId()) <= 101
		TriggerEvent("Notify","sucesso","Tratamento concluido.")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COLORSWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cor",function(source,args)
	local tinta = parseInt(args[1])
	local ped = PlayerPedId()
	local arma = GetSelectedPedWeapon(ped)
	if tinta >= 0 then
		SetPedWeaponTintIndex(ped,arma,tinta)
	end
end,false)
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PEGAR NEVE
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("neve", function(source,args)
    RequestAnimDict('anim@mp_snowball')
    if IsNextWeatherType('XMAS') and not IsPedInAnyVehicle(GetPlayerPed(-1), true) and not IsPlayerFreeAiming(PlayerId()) and not IsPedSwimming(PlayerPedId()) and not IsPedSwimmingUnderWater(PlayerPedId()) and not IsPedRagdoll(PlayerPedId()) and not IsPedFalling(PlayerPedId()) and not IsPedRunning(PlayerPedId()) and not IsPedSprinting(PlayerPedId()) and GetInteriorFromEntity(PlayerPedId()) == 0 and not IsPedShooting(PlayerPedId()) and not IsPedUsingAnyScenario(PlayerPedId()) and not IsPedInCover(PlayerPedId(), 0) then -- check if the snowball should be picked up
        TaskPlayAnim(PlayerPedId(), 'anim@mp_snowball', 'pickup_snowball', 8.0, -1, -1, 0, 1, 0, 0, 0) -- pickup the snowball
        Citizen.Wait(1950) -- wait 1.95 seconds to prevent spam clicking and getting a lot of snowballs without waiting for animatin to finish.
        GiveWeaponToPed(GetPlayerPed(-1), GetHashKey('WEAPON_SNOWBALL'), 5, false, true) -- get 2 snowballs each time.
    end
end)
-----------------------------------------------------
--------------------- PUXAR ARMA --------------------
-----------------------------------------------------
local holstered = true
local weapon
local disabled

local weapons = {
		"WEAPON_PISTOL",
		"WEAPON_PISTOL_MK2",
		"WEAPON_COMBATPISTOL",
		"WEAPON_APPISTOL",
		"WEAPON_HEAVYREVOLVER",
		"WEAPON_REVOLVER",
		"WEAPON_PISTOL50",
		"WEAPON_SNSPISTOL",
		"WEAPON_HEAVYPISTOL",
		"WEAPON_VINTAGEPISTOL",
		"WEAPON_STUNGUN",
		"WEAPON_MARKSMANPISTOL",
}

function CheckWeapon(ped)
	for i = 1, #weapons do
		if GetHashKey(weapons[i]) == GetSelectedPedWeapon(ped) then
			weapon = weapons[i]
			return true
		end
	end
	return false
end
 
 Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local ped = PlayerPedId()
		local holster = GetPedDrawableVariation(GetPlayerPed(-1), 8)
		local holster2 = GetPedDrawableVariation(GetPlayerPed(-1), 7)
		local sex = GetEntityModel(ped)
		if DoesEntityExist( ped ) and not IsEntityDead( ped ) and not IsPedInAnyVehicle(PlayerPedId(), true) then
			loadAnimDict( "reaction@intimidation@1h" )
			loadAnimDict( "rcmjosh4" )
			loadAnimDict( "anim@weapons@pistol@doubleaction_holster" )
			if holster ~= 122 and holster ~= 130 and holster2 ~= 8 and holster2 ~= 1 and holster2 ~= 110 and sex == 1885233650 then
				if CheckWeapon(ped) then
					if holstered then
						disabled = true	
						SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
						TaskPlayAnim(ped, "reaction@intimidation@1h", "intro", 8.0, 2.0, -1, 48, 0, 0, 0, 0 )
						Citizen.Wait(1800)
						SetCurrentPedWeapon(ped, GetHashKey(weapon), true)
						StopAnimTask(ped, "reaction@intimidation@1h", "intro", 1.0)
						Citizen.Wait(1000)
						disabled = false
						holstered = false
					end
				elseif not CheckWeapon(ped) then
					if not holstered then
						SetCurrentPedWeapon(ped, GetHashKey(weapon), true)
						disabled = true			
						if weapon == "WEAPON_REVOLVER" then
							TaskPlayAnim(ped, "anim@weapons@pistol@doubleaction_holster", "holster", 8.0, 2.0, -1, 48, 0, 0, 0, 0 )
						else
							TaskPlayAnim(ped, "reaction@intimidation@1h", "outro", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
						end						
						Citizen.Wait(1800)
						StopAnimTask(ped, "reaction@intimidation@1h", "outro", 1.0)
						SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
						disabled = false
						holstered = true
					end
				end
			elseif holster ~= 160 and holster ~= 152 and holster2 ~= 81 and holster2 ~= 8 and holster2 ~= 1 and sex == -1667301416 then
				if CheckWeapon(ped) then
					if holstered then
						disabled = true	
						SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
						TaskPlayAnim(ped, "reaction@intimidation@1h", "intro", 8.0, 2.0, -1, 48, 0, 0, 0, 0 )
						Citizen.Wait(1400)
						SetCurrentPedWeapon(ped, GetHashKey(weapon), true)
						StopAnimTask(ped, "reaction@intimidation@1h", "intro", 1.0)
						Citizen.Wait(1000)
						disabled = false
						holstered = false
					end
				elseif not CheckWeapon(ped) then
					if not holstered then
						SetCurrentPedWeapon(ped, GetHashKey(weapon), true)
						disabled = true
						TaskPlayAnim(ped, "reaction@intimidation@1h", "outro", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
						Citizen.Wait(1600)
						StopAnimTask(ped, "reaction@intimidation@1h", "intro", 1.0)
						SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
						disabled = false
						holstered = true
					end
				end
			elseif holster ~= 160 or holster == 152 or holster2 == 81 or holster2 == 8 or holster2 == 1 and sex == -1667301416 then
				if CheckWeapon(ped) then
					if holstered then
						disabled = true	
						TaskPlayAnim(ped, "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
						Citizen.Wait(800)
						StopAnimTask(ped, "rcmjosh4", "josh_leadout_cop2", 1.0)
						Citizen.Wait(100)
						disabled = false
						holstered = false
					end
				elseif not CheckWeapon(ped) then
					if not holstered then
						SetCurrentPedWeapon(ped, GetHashKey(weapon), true)
						disabled = true
						TaskPlayAnim(ped, "weapons@pistol@", "aim_2_holster", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
						Citizen.Wait(800)
						StopAnimTask(ped, "weapons@pistol@", "aim_2_holster", 1.0)
						SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
						disabled = false
						holstered = true
					end
				end			
			elseif holster == 160 or holster == 152 and sex == -1667301416 then
				if CheckWeapon(ped) then
					if holstered then
						disabled = true	
						TaskPlayAnim(ped, "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
						Citizen.Wait(800)
						StopAnimTask(ped, "rcmjosh4", "josh_leadout_cop2", 1.0)
						Citizen.Wait(100)
						disabled = false
						holstered = false
					end
				elseif not CheckWeapon(ped) then
					if not holstered then
						SetCurrentPedWeapon(ped, GetHashKey(weapon), true)
						disabled = true
						TaskPlayAnim(ped, "weapons@pistol@", "aim_2_holster", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
						Citizen.Wait(800)
						StopAnimTask(ped, "weapons@pistol@", "aim_2_holster", 1.0)
						SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
						disabled = false
						holstered = true
					end
				end			
			end
		end
	end
end)

function loadAnimDict( dict )
	while ( not HasAnimDictLoaded( dict ) ) do
		RequestAnimDict( dict )
		Citizen.Wait( 0 )
	end
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if disabled then
      DisableControlAction(1,243,true) -- disable sprint
      DisableControlAction(1,213,true) -- disable sprint
      DisableControlAction(0,21,true) -- disable sprint
      DisableControlAction(0,24,true) -- disable attack
      DisableControlAction(0,25,true) -- disable aim
      --DisableControlAction(0,47,true) -- disable weapon
      DisableControlAction(0,49,true) -- disable weapon
      DisableControlAction(0,44,true) -- disable weapon
      DisableControlAction(0,303,true) -- disable weapon
      DisableControlAction(0,246,true) -- disable weapon
      DisableControlAction(0,311,true) -- disable weapon
      DisableControlAction(0,58,true) -- disable weapon
      DisableControlAction(0,263,true) -- disable melee
      DisableControlAction(0,264,true) -- disable melee
      DisableControlAction(0,257,true) -- disable melee
      DisableControlAction(0,140,true) -- disable melee
      DisableControlAction(0,141,true) -- disable melee
      DisableControlAction(0,142,true) -- disable melee
      DisableControlAction(0,143,true) -- disable melee
      DisableControlAction(0,75,true) -- disable exit vehicle
      DisableControlAction(27,75,true) -- disable exit vehicle
    end
  end
end)