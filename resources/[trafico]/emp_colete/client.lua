local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emP = Tunnel.getInterface("emp_colete")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local servico = false
local selecionado = 0

local Coordenadas = {
	{-1866.5,2061.3,135.44},-- LIBERTY
}

local inicio = 0
local fim = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCALIZACAO
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	[1] = { ['x'] = 1355.12, ['y'] = -1690.60, ['z'] = 60.49 },-- 1355.12,-1690.60,60.49
	[2] = { ['x'] = 970.78, ['y'] = -199.50, ['z'] = 73.20 }, -- 970.78,-199.50,73.20
	[3] = { ['x'] = -3093.80, ['y'] = 349.27, ['z'] = 7.54 }, -- -3093.80,349.27,7.54
	[4] = { ['x'] = -1097.43, ['y'] = -1672.99, ['z'] = 8.39 }, -- -1097.43,-1672.99,8.39
	[5] = { ['x'] = -295.06, ['y'] = -2604.96, ['z'] = 6.19 }, -- -295.06,-2604.96,6.19
	[6] = { ['x'] = -1303.15, ['y'] = -390.50, ['z'] = 36.69 }, -- -1303.15,-390.50,36.69
	[7] = { ['x'] = 819.59, ['y'] = -2155.35, ['z'] = 29.62 }, -- 819.59,-2155.35,29.62
	[8] = { ['x'] = -1055.94, ['y'] = -1001.01, ['z'] = 2.16 }, -- -1055.94,-1001.01,2.16
	[9] = { ['x'] = -68.12, ['y'] = 214.31, ['z'] = 97.23 }, -- -68.12,214.31,97.23
	[10] = { ['x'] = 1240.70, ['y'] = -3238.82, ['z'] = 6.02 }, --1240.7052001953,-3238.82,6.02
	[11] = { ['x'] = 191.43, ['y'] = -2226.55, ['z'] = 6.97 }, --191.43740844727,-2226.55,6.97

	[12] = { ['x'] = -1642.75, ['y'] = -1046.89, ['z'] = 13.30 }, ---1642.75,-1046.89,13.30
	[13] = { ['x'] = -3089.38, ['y'] = 221.18, ['z'] = 14.12 }, -- -3089.38,221.18,14.12
	[14] = { ['x'] = 1160.70, ['y'] = -311.57, ['z'] = 69.27 }, --1160.70,-311.57,69.27
	[15] = { ['x'] = 1086.49, ['y'] = -2400.11, ['z'] = 30.57 }, --1086.49,-2400.11,30.57
	[16] = { ['x'] = -429.16, ['y'] = -1728.11, ['z'] = 19.78 }, -- -429.16,-1728.11,19.78
	[17] = { ['x'] = -1816.20, ['y'] = -636.42, ['z'] = 10.93 }, -- -1816.20,-636.42,10.93
	[18] = { ['x'] = 1082.45, ['y'] = -788.12, ['z'] = 58.26 },-- 1082.45,-788.12,58.26
	[19] = { ['x'] = -430.94, ['y'] = 289.01, ['z'] = 86.06 }, -- -430.94,289.01,86.06
	[20] = { ['x'] = 210.25, ['y'] = -1989.9, ['z'] = 19.72 },-- 210.25,-1989.9,19.72
	[21] = { ['x'] = -328.41, ['y'] = -2700.41, ['z'] = 7.54 },-- -328.41,-2700.41,7.54
	[22] = { ['x'] = -1244.10, ['y'] = -1240.34, ['z'] = 11.02 },-- -1244.10,-1240.34,11.02

}
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAL PARA INICIAR COLETA
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		Citizen.Wait(1)
		if not servico then
			for _,mark in pairs(Coordenadas) do
				local x,y,z = table.unpack(mark)
				local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),x,y,z,true)
				if distance <= 30.0 then
					if distance <= 1.2 then
						drawTxt("PRESSIONE  ~b~E~w~  PARA INICIAR COLETA",4,0.5,0.93,0.50,255,255,255,180)
						if IsControlJustPressed(0,38) and emP.checkPermission() then
							if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),-1866.5,2061.3,135.44,true) <= 1.2 then
								servico = true	
								inicio = 1
								fim = 22						
								selecionado = math.random(inicio,fim)
								CriandoBlip(locs,selecionado)
							end				
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COLETAR COMPONENTES 
-----------------------------------------------------------------------------------------------------------------------------------------	
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
			local distance = GetDistanceBetweenCoords(locs[selecionado].x,locs[selecionado].y,cdz,x,y,z,true)
			if distance <= 30.0 then
				DrawMarker(21,locs[selecionado].x,locs[selecionado].y,locs[selecionado].z-0.27,0,0,0,0,0,0,0.5,0.5,-0.5,255,0,0,50,1,0,0,1)
				if distance <= 1.2 then
					drawTxt("PRESSIONE  ~b~E~w~  PARA COLETAR",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) then
						if emP.checkPayment() then

							RemoveBlip(blips)
							backentrega = selecionado
							while true do
								if backentrega == selecionado then
									selecionado = math.random(inicio,fim)
								else
									break
								end
								Citizen.Wait(1)
							end
							CriandoBlip(locs,selecionado)
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if servico then
			drawTxt("PRESSIONE ~r~F7~w~ SE DESEJA FINALIZAR",4,0.227,0.935,0.448,255,255,255,100)
			drawTxt("VA ATÉ O DESTINO E COLETE OS ~g~COMPONENTES~w~.",4,0.252,0.956,0.48,255,255,255,220)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if servico then
			if IsControlJustPressed(0,168) then
				servico = false
				RemoveBlip(blips)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

function CriandoBlip(locs,selecionado)
	blips = AddBlipForCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
	SetBlipSprite(blips,1)
	SetBlipColour(blips,5)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Coleta de Componentes")
	EndTextCommandSetBlipName(blips)
end