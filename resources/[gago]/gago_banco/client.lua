local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","gago_banco")


local giveCashAnywhere = false 
local withdraWAnywhere = false 
local depositAnywhere = false 
local displayBankBlips = true 
local enableBankingGui = true 

local banks = {
  {name="Banco", x=-1213.44, y=-331.02, z=37.78},
  {name="Banco", x=-351.59, y=-49.68, z=49.04},
  {name="Banco", x=235.12, y=216.84, z=106.28},
  {name="Banco", x=313.47, y=-278.81, z=54.17},
  {name="Banco", x=149.35, y=-1040.53, z=29.37},
  {name="Banco", x=-2962.60, y=482.17, z=15.70},
  {name="Banco", x=-112.81, y=6469.91, z=31.62},
  {name="Banco", x=1175.74, y=2706.80, z=38.09},
  {name="Banco", x=418.80, y=-986.38, z=29.38},
}


local atms = {
	{name="ATM", id=277, x=147.64, y=-1035.66, z=29.343},
	{name="ATM", id=277, x=296.11, y=-591.55, z=43.27},
	{name="ATM", id=277, x=-386.733, y=6045.953, z=31.501},
	{name="ATM", id=277, x=-284.037, y=6224.385, z=31.187},
	{name="ATM", id=277, x=-284.037, y=6224.385, z=31.187},
	{name="ATM", id=277, x=-133.35, y=6366.37, z=31.47}, 
	{name="ATM", id=277, x=-110.753, y=6467.703, z=31.784},
	{name="ATM", id=277, x=-94.9690, y=6455.301, z=31.784},
	{name="ATM", id=277, x=155.4300, y=6641.991, z=31.784},
	{name="ATM", id=277, x=174.6720, y=6637.218, z=31.784},
	{name="ATM", id=277, x=1703.138, y=6426.783, z=32.730},
	{name="ATM", id=277, x=1735.114, y=6411.035, z=35.164},
	{name="ATM", id=277, x=1702.842, y=4933.593, z=42.051},
	{name="ATM", id=277, x=1967.333, y=3744.293, z=32.272},
	{name="ATM", id=277, x=1821.917, y=3683.483, z=34.244},
	{name="ATM", id=277, x=1174.532, y=2705.278, z=38.027},
	{name="ATM", id=277, x=540.0420, y=2671.007, z=42.177},
	{name="ATM", id=277, x=2564.399, y=2585.100, z=38.016},
	{name="ATM", id=277, x=2558.683, y=349.6010, z=108.050},
	{name="ATM", id=277, x=2558.051, y=389.4817, z=108.660},
	{name="ATM", id=277, x=1077.692, y=-775.796, z=58.218},
	{name="ATM", id=277, x=1139.018, y=-469.886, z=66.789},
	{name="ATM", id=277, x=1168.975, y=-457.241, z=66.641},
	{name="ATM", id=277, x=1153.884, y=-326.540, z=69.245},
	{name="ATM", id=277, x=381.2827, y=323.2518, z=103.270},
	{name="ATM", id=277, x=236.4638, y=217.4718, z=106.840},
	{name="ATM", id=277, x=265.0043, y=212.1717, z=106.780},
	{name="ATM", id=277, x=285.2029, y=143.5690, z=104.970},
	{name="ATM", id=277, x=157.7698, y=233.5450, z=106.450},
	{name="ATM", id=277, x=-164.568, y=233.5066, z=94.919},
	{name="ATM", id=277, x=-1827.04, y=785.5159, z=138.020},
	{name="ATM", id=277, x=-1409.39, y=-99.2603, z=52.473},
	{name="ATM", id=277, x=-1205.35, y=-325.579, z=37.870},
	{name="ATM", id=277, x=-1215.64, y=-332.231, z=37.881},
	{name="ATM", id=277, x=-2072.41, y=-316.959, z=13.345},
	{name="ATM", id=277, x=-2975.72, y=379.7737, z=14.992},
	{name="ATM", id=277, x=-2962.60, y=482.1914, z=15.762},
	{name="ATM", id=277, x=-2955.70, y=488.7218, z=15.486},
	{name="ATM", id=277, x=-3044.22, y=595.2429, z=7.595},
	{name="ATM", id=277, x=-3144.13, y=1127.415, z=20.868},
	{name="ATM", id=277, x=-254.112, y=-692.483, z=33.616},
	{name="ATM", id=277, x=-1570.197, y=-546.651, z=34.955},
	{name="ATM", id=277, x=-1415.909, y=-211.825, z=46.500},
	{name="ATM", id=277, x=-1430.112, y=-211.014, z=46.500},
	{name="ATM", id=277, x=33.232, y=-1347.849, z=29.497},
	{name="ATM", id=277, x=287.645, y=-1282.646, z=29.659},
	{name="ATM", id=277, x=289.012, y=-1256.545, z=29.440},
	{name="ATM", id=277, x=295.839, y=-895.640, z=29.217},
	{name="ATM", id=277, x=1686.753, y=4815.809, z=42.008},
	{name="ATM", id=277, x=-302.408, y=-829.945, z=32.417},
	{name="ATM", id=277, x=5.134, y=-919.949, z=29.557},
	{name="ATM", id=277, x=418.98, y=-986.21, z=29.39},
	{name="ATM", id=277, x=1050.76, y=3643.0, z=34.26}





}



local atBank = false
local bankOpen = false

RegisterNetEvent('send:banco')
AddEventHandler('send:banco', function(banco)
  TransitionToBlurred(1000)
	SetNuiFocus(true, true)
	SendNUIMessage({
    openBank = true,
		banco = banco
	})
end)


function closeGui()
  TransitionFromBlurred(1000)
  SetNuiFocus(false)
  SendNUIMessage({openBank = false})
  bankOpen = false
  atmOpen = false
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2)
		local pos = GetEntityCoords(PlayerPedId(), true)
		for k, j in pairs(banks) do
			if(Vdist(pos.x, pos.y, pos.z, j.x, j.y, j.z) < 120.0) then
				if(Vdist(pos.x, pos.y, pos.z, j.x, j.y, j.z) < 1.0) then
					draw3DText(j.x, j.y, j.z, "Pressione [~g~E~w~] para acessar o banco")
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2)
		local pos = GetEntityCoords(PlayerPedId(), true)
		for k, j in pairs(atms) do
			if(Vdist(pos.x, pos.y, pos.z, j.x, j.y, j.z) < 120.0) then
				if(Vdist(pos.x, pos.y, pos.z, j.x, j.y, j.z) < 1.0) then
					draw3DText(j.x, j.y, j.z, "Pressione [~g~E~w~] para acessar o caixa eletronico")
				end
			end
		end
	end
end)



if enableBankingGui then
  Citizen.CreateThread(function()
    while true do
      Citizen.Wait(0)
      if(IsNearBank()) then
        atBank = true
        if IsControlJustPressed(1, 51) and not vRP.isHandcuffed()  then 

          vRP.playAnim(false,{{"amb@prop_human_atm@male@enter", "enter",}},false)

          TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
          Wait(4000)
            if bankOpen then
              closeGui()
              bankOpen = false
            else
              TriggerServerEvent("bank:update")
              TriggerServerEvent("get:banco")
              bankOpen = true
          end
      	end
      else
        if(bankOpen) then
          closeGui()
        end
        atmsBank = false
        bankOpen = false
      end
    end
  end)
end

if enableBankingGui then
  Citizen.CreateThread(function()
    while true do
      Citizen.Wait(0)
      if(IsNearAtm()) then
        atBank = true
        if IsControlJustPressed(1, 51) and not vRP.isHandcuffed()  then 

          vRP.playAnim(false,{{"amb@prop_human_atm@male@enter", "enter",}},false)

          TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
          Wait(4000)
            if bankOpen then
              closeGui()
              bankOpen = false
            else
              TriggerServerEvent("bank:update")
              TriggerServerEvent("get:banco")
              bankOpen = true
          end
      	end
      else
        if(bankOpen) then
          closeGui()
        end
        atmsBank = false
        bankOpen = false
      end
    end
  end)
end


Citizen.CreateThread(function()
  while true do
    if bankOpen then
      local ply = PlayerPedId()
      local active = true
      DisableControlAction(0, 1, active) 
      DisableControlAction(0, 2, active) 
      DisableControlAction(0, 24, active) 
      DisablePlayerFiring(ply, true) 
      DisableControlAction(0, 142, active)
      DisableControlAction(0, 106, active) 
    end
    Citizen.Wait(0)
  end
end)

-- NUI Callback Methods
RegisterNUICallback('pagarMultass', function(data, cb)
  TriggerServerEvent('bank:pagarmulta', data.amount)
  cb('ok')
end)

RegisterNUICallback('close', function(data, cb)
  closeGui()
  cb('ok')
end)

RegisterNUICallback('balance', function(data, cb)
  SendNUIMessage({openSection = "balance"})
  cb('ok')
end)

RegisterNUICallback('multasbalance', function(data, cb)
  SendNUIMessage({openSection = "multasbalance"})
  cb('ok')
end)

RegisterNUICallback('withdraw', function(data, cb)
  SendNUIMessage({openSection = "withdraw"})
  cb('ok')
end)

RegisterNUICallback('deposit', function(data, cb)
  SendNUIMessage({openSection = "deposit"})
  cb('ok')
end)

RegisterNUICallback('transfer', function(data, cb)
  SendNUIMessage({openSection = "transfer"})
  cb('ok')
end)

RegisterNUICallback('quickCash', function(data, cb)
  TriggerServerEvent('bank:quickCash')
  cb('ok')
end)

RegisterNUICallback('withdrawSubmit', function(data, cb)
  TriggerEvent('bank:withdraw', data.amount)
  cb('ok')
end)

RegisterNUICallback('depositSubmit', function(data, cb)
  TriggerEvent('bank:deposit', data.amount)
  cb('ok')
end)

RegisterNUICallback('pagarMulta', function()
  TriggerEvent('bank:pagarmulta')
end)

RegisterNUICallback('transferSubmit', function(data, cb)
  local toPlayer = data.toPlayer
  local amount = data.amount
  TriggerServerEvent("bank:transfer", toPlayer, tonumber(amount))
end)

function IsNearBank()
  local ply = PlayerPedId()
  local plyCoords = GetEntityCoords(ply, 0)
  for _, item in pairs(banks) do
    local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
    if (distance <= 3) then
      return true
    end
  end
end


function IsNearAtm()
  local ply = PlayerPedId()
  local plyCoords = GetEntityCoords(ply, 0)
  for _, item in pairs(atms) do
    local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
    if (distance <= 3) then
      return true
    end
  end
end

function IsNearPlayer(player)
  local ply = PlayerPedId()
  local plyCoords = GetEntityCoords(ply, 0)
  local ply2 = GetPlayerPed(GetPlayerFromServerId(player))
  local ply2Coords = GetEntityCoords(ply2, 0)
  local distance = GetDistanceBetweenCoords(ply2Coords["x"], ply2Coords["y"], ply2Coords["z"],  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
  if (distance <= 5) then
    return true
  end
end

RegisterNetEvent('bank:pagarmulta')
AddEventHandler('bank:pagarmulta', function()
  if(IsNearBank() == true or depositAnywhere == true ) then
    TriggerServerEvent("bank:pagarmulta")
  else
    vRP.notifyError("Você só pode pagar multa em um banco!")
  end
end)

RegisterNetEvent('bank:deposit')
AddEventHandler('bank:deposit', function(amount)
  if(IsNearBank() == true or depositAnywhere == true ) then
    TriggerServerEvent("bank:deposit", tonumber(amount))
  else
    vRP.notifyError("Você só pode depositar em um banco!")
  end
end)

RegisterNetEvent('bank:withdraw')
AddEventHandler('bank:withdraw', function(amount)
  if (IsNearBank() == true or withdraWAnywhere == true) then
    TriggerServerEvent("bank:withdraw", tonumber(amount))
  else
    vRP.notifyError("Você só pode sacar em um banco!")
  end
end)

RegisterNetEvent('bank:givecash')
AddEventHandler('bank:givecash', function(toPlayer, amount)
  if(IsNearPlayer(toPlayer) == true or giveCashAnywhere == true) then
    local player2 = GetPlayerFromServerId(toPlayer)
    local playing = IsPlayerPlaying(player2)
    if (playing ~= false) then
      TriggerServerEvent("bank:givecash", toPlayer, tonumber(amount))
      vRP.notify("Você transferiu " .. tonumber(amount) .. " para " .. toPlayer)
    else
      vRP.notifyWarning("Cidadão fora da cidade!")
    end
  else
    vRP.notifyWarning("Cidadão não mora nessa cidade!")
  end
end)

RegisterNetEvent('banking:updateBalance')
AddEventHandler('banking:updateBalance', function(balance, multasbalance,identidade)
	SendNUIMessage({
		updateBalance = true,
    balance = balance,
    multasbalance = multasbalance,
    identidade = identidade
    
	})
end)

RegisterNetEvent("banking:addBalance")
AddEventHandler("banking:addBalance", function(amount)
	SendNUIMessage({
		addBalance = true,
		amount = amount
	})
end)

RegisterNetEvent("banking:removeBalance")
AddEventHandler("banking:removeBalance", function(amount)
	SendNUIMessage({
		removeBalance = true,
		amount = amount
	})
end)


function draw3DText(x,y,z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / 370
	DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end