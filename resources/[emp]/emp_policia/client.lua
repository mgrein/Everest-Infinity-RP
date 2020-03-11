local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emP = Tunnel.getInterface("emp_policia")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local servico = false
local selecionado = 0

local coordenadas = {
	{ ['id'] = 1, ['x'] = -1097.47, ['y'] = -839.87, ['z'] = 19.01 },
	{ ['id'] = 2, ['x'] = -449.96, ['y'] = 6010.79, ['z'] = 31.72 }, 
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESIDENCIAS
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	[1] = { ['x'] = -1000.25, ['y'] = -836.29, ['z'] = 14.62 }, 
    [2] = { ['x'] = -1210.66, ['y'] = -601.5, ['z'] = 26.86 }, 
    [3] = { ['x'] = -1426.88, ['y'] = -725.65, ['z'] = 23.14 }, 
    [4] = { ['x'] = -1626.23, ['y'] = -593.06, ['z'] = 33.03 }, 
    [5] = { ['x'] = -2045.53, ['y'] = -379.04, ['z'] = 10.71 }, 
    [6] = { ['x'] = -1949.81, ['y'] = -187.71, ['z'] = 32.83 }, 
    [7] = { ['x'] = -1611.97, ['y'] = -317.61, ['z'] = 50.44 }, 
    [8] = { ['x'] = -1483.63, ['y'] = -419.33, ['z'] = 36.33 }, 
    [9] = { ['x'] = -1052.56, ['y'] = -212.82, ['z'] = 37.5 }, 
    [10] = { ['x'] = -810.16, ['y'] = -80.66, ['z'] = 37.58 }, 
    [11] = { ['x'] = -101.34, ['y'] = -107.62, ['z'] = 57.46 }, 
    [12] = { ['x'] = 332.31, ['y'] = -259.44, ['z'] = 53.65 }, 
    [13] = { ['x'] = 497.31, ['y'] =  56.8, ['z'] = 95.05 }, 
    [14] = { ['x'] = 224.01, ['y'] = 192.85, ['z'] = 105.25 }, 
    [15] = { ['x'] = 257.01, ['y'] = 324.05, ['z'] = 105.2 }, 
    [16] = { ['x'] = 546.7, ['y'] = 248.56, ['z'] = 102.81 }, 
    [17] = { ['x'] = 765.43, ['y'] = 153.1, ['z'] = 80.45 }, 
    [18] = { ['x'] = 776.62, ['y'] = -48.37, ['z'] = 80.35 }, 
    [19] = { ['x'] = 997.65, ['y'] = -188.34, ['z'] = 71.24 }, 
    [20] = { ['x'] = 1210.74, ['y'] = -356.58, ['z'] = 68.84 }, 
    [21] = { ['x'] = 1263.7, ['y'] = -530.61, ['z'] = 68.75 }, 
    [22] = { ['x'] = 1220.96, ['y'] = -755.41, ['z'] = 58.52 }, 
    [23] = { ['x'] = 1150.81, ['y'] = -932.35, ['z'] = 49.23 }, 
    [24] = { ['x'] = 1242.57, ['y'] = -1418.46, ['z'] = 34.74 }, 
    [25] = { ['x'] = 1317.26, ['y'] = -1600.32, ['z'] = 52.11 }, 
    [26] = { ['x'] = 1397.58, ['y'] = -1748.38, ['z'] = 65.37 }, 
    [27] = { ['x'] = 1197.14, ['y'] = -1816.14, ['z'] = 37.19 }, 
    [28] = { ['x'] = 1150.26, ['y'] = -1742.59, ['z'] = 35.4 }, 
    [29] = { ['x'] = 969.37, ['y'] = -1757.08, ['z'] = 30.92 }, 
    [30] = { ['x'] = 551.55, ['y'] = -1692.79, ['z'] = 28.92 }, 
    [31] = { ['x'] = 346.94, ['y'] = -1528.6, ['z'] = 29.04 }, 
    [32] = { ['x'] = 67.09, ['y'] = -1181.34, ['z'] = 29.05 }, 
    [33] = { ['x'] = 107.53, ['y'] = -1027.55, ['z'] = 29.04 }, 
    [34] = { ['x'] = 199.03, ['y'] = -1032.16, ['z'] = 29.08 }, 
    [35] = { ['x'] = 280.64, ['y'] = -878.75, ['z'] = 28.96 }, 
    [36] = { ['x'] = 200.84, ['y'] = -816.54, ['z'] = 30.64 }, 
    [37] = { ['x'] = 243.94, ['y'] = -639.76, ['z'] = 39.77 }, 
    [38] = { ['x'] = 312.6, ['y'] = -410.41, ['z'] = 44.86 }, 
    [39] = { ['x'] = 51.94, ['y'] = -285.37, ['z'] = 47.34 }, 
    [40] = { ['x'] = -256.12, ['y'] = -166.19, ['z'] = 40.14 }, 
    [41] = { ['x'] = -615.7, ['y'] = -326.28, ['z'] = 34.54 }, 
    [42] = { ['x'] = -780.69, ['y'] = -322.96, ['z'] = 36.54 }, 
    [43] = { ['x'] = -943.95, ['y'] = -419.83, ['z'] = 37.43 }, 
    [44] = { ['x'] = -1083.95, ['y'] = -410.6, ['z'] = 36.3 }, 
    [45] = { ['x'] = -1281.18, ['y'] = -482.76, ['z'] = 33.04 }, 
    [46] = { ['x'] = -1151.22, ['y'] = -697.45, ['z'] = 21.3 }, 
    [47] = { ['x'] = -1147.05, ['y'] = -851.24, ['z'] = 13.8 }, 
    [48] = { ['x'] = -1065.13, ['y'] = -873.36, ['z'] = 4.71 }, 
-----------------------------------------------------------------------------------------------------------------------------------------
-- COORDS PALETO
-----------------------------------------------------------------------------------------------------------------------------------------
	[49] = { ['x'] = -412.21, ['y'] = 6002.37, ['z'] = 31.17 }, 
	[50] = { ['x'] = -762.69, ['y'] = 5506.55, ['z'] = 34.75 }, 
	[51] = { ['x'] = -708.68, ['y'] = 5433.09, ['z'] = 44.56 }, 
	[52] = { ['x'] = -709.57, ['y'] = 5300.94, ['z'] = 71.69 }, 
	[53] = { ['x'] = -572.95, ['y'] = 5254.12, ['z'] = 70.04 }, 
	[54] = { ['x'] = -574.2, ['y'] = 5450.14, ['z'] = 60.52 }, 
	[55] = { ['x'] = -500.15, ['y'] = 5747.03, ['z'] = 48.31 }, 
	[56] = { ['x'] = -307.58, ['y'] = 6025.62, ['z'] = 31.77 }, 
	[57] = { ['x'] = 152.54, ['y'] = 6517.07, ['z'] = 31.18 }, 
	[58] = { ['x'] = 1028.89, ['y'] = 6480.93, ['z'] = 20.56 }, 
	[59] = { ['x'] = 1489.83, ['y'] = 6435.95, ['z'] = 21.87 }, 
	[60] = { ['x'] = 2528.07, ['y'] = 5400.32, ['z'] = 44.14 }, 
	[61] = { ['x'] = 2593.1, ['y'] = 5134.5, ['z'] = 44.33 }, 
	[62] = { ['x'] = 1972.56, ['y'] = 5140.56, ['z'] = 42.76 }, 
	[63] = { ['x'] = 1733.16, ['y'] = 4593.94, ['z'] = 40.5 }, 
	[64] = { ['x'] = 1453.72, ['y'] = 4501.05, ['z'] = 49.98 }, 
	[65] = { ['x'] = 824.2, ['y'] = 4424.81, ['z'] = 52.17 }, 
	[66] = { ['x'] = 498.08, ['y'] = 4314.52, ['z'] = 55.41 }, 
	[67] = { ['x'] = 159.13, ['y'] = 4421.58, ['z'] = 75.41 }, 
	[68] = { ['x'] = -227.33, ['y'] = 3877.26, ['z'] = 37.3 }, 
	[69] = { ['x'] = 113.11, ['y'] = 3424.78, ['z'] = 39.0 }, 
	[70] = { ['x'] = 916.13, ['y'] = 3532.2, ['z'] = 33.61 }, 
	[71] = { ['x'] = 1688.11, ['y'] = 3499.61, ['z'] = 36.03 }, 
	[72] = { ['x'] = 2029.44, ['y'] = 3759.51, ['z'] = 31.89 }, 
	[73] = { ['x'] = 1864.66, ['y'] = 3952.19, ['z'] = 32.65 }, 
	[74] = { ['x'] = 1582.01, ['y'] = 3724.29, ['z'] = 34.15 }, 
	[75] = { ['x'] = 938.06, ['y'] = 3636.31, ['z'] = 32.07 }, 
	[76] = { ['x'] = 411.18, ['y'] = 3491.25, ['z'] = 34.22 }, 
	[77] = { ['x'] = -120.25, ['y'] = 3630.95, ['z'] = 44.43 }, 
	[78] = { ['x'] = -202.92, ['y'] = 4206.0, ['z'] = 44.15 }, 
	[79] = { ['x'] = -703.0, ['y'] = 4400.04, ['z'] = 23.46 }, 
	[80] = { ['x'] = -1023.67, ['y'] = 4422.08, ['z'] = 25.57 }, 
	[81] = { ['x'] = -1348.62, ['y'] = 4471.77, ['z'] = 22.73 }, 
	[82] = { ['x'] = -1559.39, ['y'] = 4602.06, ['z'] = 20.11 }, 
	[83] = { ['x'] = -1495.97, ['y'] = 4985.22, ['z'] = 62.28 }, 
	[84] = { ['x'] = -781.91, ['y'] = 5486.34, ['z'] = 33.96 }, 
	[85] = { ['x'] = -615.6, ['y'] = 6079.34, ['z'] = 7.72 }, 
	[86] = { ['x'] = -315.78, ['y'] = 6216.54, ['z'] = 30.97 }, 
	[87] = { ['x'] = 59.5, ['y'] = 6618.77, ['z'] = 31.16 }, 
	[88] = { ['x'] = -166.38, ['y'] = 6372.5, ['z'] = 31.0 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRABALHAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if not servico then
			for _,v in pairs(coordenadas) do
				local ped = PlayerPedId()
				local x,y,z = table.unpack(GetEntityCoords(ped))
				local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
				local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)

				if distance <= 30 then
					DrawMarker(23,v.x,v.y,v.z-0.97,0,0,0,0,0,0,1.0,1.0,0.5,255,0,0,50,0,0,0,0)
					if distance <= 1.2 then
						drawTxt("PRESSIONE  ~r~E~w~  PARA INICIAR A ROTA",4,0.5,0.93,0.50,255,255,255,180)
						if IsControlJustPressed(0,38) and emP.checkPermission() then
							servico = true
							if v.id == 2 then
								selecionado = 48
							else
								selecionado = 1
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
-- SERVIÇO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if servico then
				local ped = PlayerPedId()
				local x,y,z = table.unpack(GetEntityCoords(ped))
				local bowz,cdz = GetGroundZFor_3dCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
				local distance = GetDistanceBetweenCoords(locs[selecionado].x,locs[selecionado].y,cdz,x,y,z,true)

			if distance <= 30.0 then
				DrawMarker(21,locs[selecionado].x,locs[selecionado].y,locs[selecionado].z+0.30,0,0,0,0,180.0,130.0,2.0,2.0,1.0,255,0,0,100,1,0,0,1)
				if distance <= 4.5 then
					if emP.checkPermission() then
						if IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiabmwr1200")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiacapricesid")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiaschaftersid")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiamustanggt")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiacharger2018")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiavictoria")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiaexplorer")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiatahoe")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("policiasilverado")) or IsVehicleModel(GetVehiclePedIsUsing(PlayerPedId()),GetHashKey("fbi2")) then
							RemoveBlip(blips)
							if selecionado == 48 then
								selecionado = 1
							elseif selecionado == 88 then
								selecionado = 49
							else
								selecionado = selecionado + 1
							end							
							emP.checkPayment()
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
			drawTxt("PRESSIONE ~r~F7~w~ SE DESEJA FINALIZAR A PATRULHA",4,0.25,0.958,0.448,255,255,255,100)
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
	SetBlipColour(blips,49)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Rota de Patrulha")
	EndTextCommandSetBlipName(blips)
end