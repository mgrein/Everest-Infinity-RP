local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
hppf = Tunnel.getInterface("vrp_colete")

vRP = Proxy.getInterface("vRP")

usoucolete = false
local currentarmor = 7
local currentcolour = 0
RegisterCommand("scolete",function(source,args)
	local ped = GetPlayerPed(-1)
	if args[1] then
		vRP._playAnim(true,{{"clothingshirt","try_shirt_positive_d"}},false)
		Citizen.Wait(1000)
		currentarmor = tonumber(args[1])
		--SetPedComponentVariation(ped, 9, currentarmor, currentcolour, 2)
	end
	if args[2] then	
		vRP._playAnim(true,{{"clothingshirt","try_shirt_positive_d"}},false)
		Citizen.Wait(1000)
		currentcolour = tonumber(args[2])
		--SetPedComponentVariation(ped, 9, currentarmor, currentcolour, 2)
	end	
end)

RegisterCommand("colete", function()
	local ped = GetPlayerPed(-1)
	if not usoucolete then
		if hppf.checkitems() then
			SetPedArmour(ped,100)
			TriggerEvent("Notify","sucesso","Colete equipado com sucesso")
			usoucolete = true
			Citizen.Wait(30000)
			usoucolete = false
		else
			TriggerEvent("Notify","negado","Você não possuí um colete balistico")	
		end
	else
		TriggerEvent("Notify","importante","Você deve esperar para equipar o colete")	
	end		
end)

redeem = false
RegisterCommand("gcolete", function()
	local ped = GetPlayerPed(-1)
	local armourlevel = GetPedArmour(ped)
	if not redeem and armourlevel >= 90 then
		SetPedArmour(ped,0)
		redeem = true
		hppf.redeemarmour()
		Citizen.Wait(5000)
		redeem = false
		TriggerEvent("Notify","sucesso","Você guardou seu colete!")
	else
		TriggerEvent("Notify","negado","Seu colete está muito estragado!")	
	end		
end)

RegisterCommand("dcolete", function()
	local ped = GetPlayerPed(-1)
	SetPedArmour(ped,0)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		local ped = PlayerPedId()
		local armourlevel = GetPedArmour(ped)
		if armourlevel >= 1 then
			if not hppf.checkPF() then
				if hppf.checkpermission("sheriff.permissao") then
					if (GetEntityModel(ped) == GetHashKey("mp_m_freemode_01")) then
						SetPedComponentVariation(ped, 9, currentarmor, currentcolour, 2)
					elseif (GetEntityModel(player) == GetHashKey("mp_f_freemode_01")) then
						SetPedComponentVariation(ped, 9, currentarmor, currentcolour, 2)
					end
				elseif hppf.checkpermission("patamo.permissao") then
					if (GetEntityModel(ped) == GetHashKey("mp_m_freemode_01")) then
						SetPedComponentVariation(ped, 9, currentarmor, currentcolour, 2)
					elseif (GetEntityModel(player) == GetHashKey("mp_f_freemode_01")) then
						SetPedComponentVariation(ped, 9, currentarmor, currentcolour, 2)
					end	
				elseif hppf.checkpermission("policia.permissao") then
					if (GetEntityModel(ped) == GetHashKey("mp_m_freemode_01")) then
						SetPedComponentVariation(ped, 9, currentarmor, currentcolour, 2)
					elseif (GetEntityModel(player) == GetHashKey("mp_f_freemode_01")) then
						SetPedComponentVariation(ped, 9, currentarmor, currentcolour, 2)
					end	
				else
					if (GetEntityModel(ped) == GetHashKey("mp_m_freemode_01")) then
						SetPedComponentVariation(ped, 9, currentarmor, currentcolour, 2)
					elseif (GetEntityModel(player) == GetHashKey("mp_f_freemode_01")) then
						SetPedComponentVariation(ped, 9, currentarmor, currentcolour, 2)
					end		
				end		
			end		
		end
		--print(currentarmor)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		local ped = PlayerPedId()
		local armourlevel = GetPedArmour(ped)
		if armourlevel < 1 then
			if (GetEntityModel(ped) == GetHashKey("mp_m_freemode_01")) then
					SetPedComponentVariation(ped, 9, 0, 1, 2)
			end
			
			if (GetEntityModel(player) == GetHashKey("mp_f_freemode_01")) then
				SetPedComponentVariation(ped, 9, 0, 1, 2)	
			end		
		end
	end
end)