local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPserver = Tunnel.getInterface("vRP")
emP = Tunnel.getInterface("emp_raceexplosive")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local inrace = false
local timerace = 0
local racepoint = 1
local racepos = 0
local CoordenadaX = 1652.05
local CoordenadaY = 3236.13
local CoordenadaZ = 40.53
local PlateIndex = nil
local bomba = nil
local explosive = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local races = {
		[1] = {
		    ['time'] = 200,
            [1] = { ['x'] = 1959.94, ['y'] = 3131.52, ['z'] = 46.3 },
            [2] = { ['x'] = 2568.52, ['y'] = 3049.28, ['z'] = 43.67 },
            [3] = { ['x'] = 2442.76, ['y'] = 2865.13, ['z'] = 48.43 },
            [4] = { ['x'] = 1917.25, ['y'] = 2432.59, ['z'] = 53.91 },
            [5] = { ['x'] = 1693.87, ['y'] = 1388.0, ['z'] = 86.07 },
            [6] = { ['x'] = 1525.89, ['y'] = 826.97, ['z'] = 76.78 },
            [7] = { ['x'] = 1087.01, ['y'] = 422.85, ['z'] = 90.83 },
            [8] = { ['x'] = 842.18, ['y'] = 229.08, ['z'] = 82.18 },
            [9] = { ['x'] = 577.62, ['y'] = 169.02, ['z'] = 99.37 },
            [10] = { ['x'] = 355.07, ['y'] = 138.34, ['z'] = 102.43 },
            [11] = { ['x'] = 233.26, ['y'] = 45.03, ['z'] = 83.28 },
            [12] = { ['x'] = 264.67, ['y'] = -22.78, ['z'] = 72.83 },
            [13] = { ['x'] = 191.74, ['y'] = -340.74, ['z'] = 43.4 },
            [14] = { ['x'] = 244.48, ['y'] = -607.73, ['z'] = 41.73 },
            [15] = { ['x'] = 281.85, ['y'] = -855.7, ['z'] = 28.63 },
            [16] = { ['x'] = 434.44, ['y'] = -825.05, ['z'] = 28.08 },
            [17] = { ['x'] = 499.53, ['y'] = -974.96, ['z'] = 26.82 },
            [18] = { ['x'] = 383.29, ['y'] = -1153.52, ['z'] = 28.63 },
            [19] = { ['x'] = 195.96, ['y'] = -1234.19, ['z'] = 37.62 },
            [20] = { ['x'] = 3.27, ['y'] = -1310.43, ['z'] = 30.17 },
			[21] = { ['x'] = -29.74, ['y'] = -1233.65, ['z'] = 28.67 },
    },
	[2] = { 
		    ['time'] = 280,
		    [1] = { ['x'] = 1534.58, ['y'] = 3204.93, ['z'] = 39.75 },
		    [2] = { ['x'] = 1067.24, ['y'] = 3039.9, ['z'] = 40.77 },
		    [3] = { ['x'] = 1545.3, ['y'] = 3146.53, ['z'] = 39.86 },
		    [4] = { ['x'] = 2067.37, ['y'] = 3066.72, ['z'] = 45.69 },
		    [5] = { ['x'] = 2174.6, ['y'] = 2965.66, ['z'] = 45.84 },
		    [6] = { ['x'] = 2517.84, ['y'] = 3034.67, ['z'] = 41.96 },
		    [7] = { ['x'] = 2706.33, ['y'] = 3199.92, ['z'] = 53.08 },
		    [8] = { ['x'] = 2440.34, ['y'] = 2862.83, ['z'] = 48.39 },
		    [9] = { ['x'] = 1936.74, ['y'] = 2486.07, ['z'] = 54.04 },
		    [10] = { ['x'] = 1761.79, ['y'] = 2013.12, ['z'] = 68.4 },
		    [11] = { ['x'] = 1664.06, ['y'] = 1333.5, ['z'] = 86.38 },
		    [12] = { ['x'] = 1486.5, ['y'] = 1185.44, ['z'] = 113.52 },
		    [13] = { ['x'] = 1025.11, ['y'] = 489.61, ['z'] = 95.92 },
		    [14] = { ['x'] = 908.84, ['y'] = 456.69, ['z'] = 119.82 },
		    [15] = { ['x'] = 625.98, ['y'] = 267.68, ['z'] = 102.43 },
		    [16] = { ['x'] = 648.02, ['y'] = 134.71, ['z'] = 90.59 },
		    [17] = { ['x'] = 398.74, ['y'] = -131.58, ['z'] = 64.22 },
		    [18] = { ['x'] = 286.24, ['y'] = -168.65, ['z'] = 58.83 },
		    [19] = { ['x'] = 322.33, ['y'] = -190.92, ['z'] = 60.92 },
		    [20] = { ['x'] = 381.8, ['y'] = -213.09, ['z'] = 57.02 },
		    [21] = { ['x'] = 473.96, ['y'] = -312.77, ['z'] = 46.2 },
		    [22] = { ['x'] = 242.95, ['y'] = -621.43, ['z'] = 40.67 },
		    [23] = { ['x'] = 137.92, ['y'] = -711.21, ['z'] = 32.47 },
		    [24] = { ['x'] = -34.0, ['y'] = -949.34, ['z'] = 28.73 },
		    [25] = { ['x'] = 214.79, ['y'] = -1038.96, ['z'] = 28.71 },
		    [26] = { ['x'] = 281.72, ['y'] = -855.54, ['z'] = 28.6 },
		    [27] = { ['x'] = 171.1, ['y'] = -816.21, ['z'] = 30.5 },
		    [28] = { ['x'] = 170.83, ['y'] = -1026.2, ['z'] = 28.7 },
		    [29] = { ['x'] = 255.23, ['y'] = -952.73, ['z'] = 28.65 },
		    [30] = { ['x'] = 233.99, ['y'] = -836.26, ['z'] = 29.47 },
		    [31] = { ['x'] = 136.15, ['y'] = -906.86, ['z'] = 29.57 },
			[32] = { ['x'] = 169.65, ['y'] = -1085.4, ['z'] = 28.53 },
    },
	[3] = { 
		    ['time'] = 420,
			[1] = { ['x'] = 1724.97, ['y'] = 3462.04, ['z'] = 38.33 },
			[2] = { ['x'] = 1278.35, ['y'] = 3537.55, ['z'] = 34.59 }, 
			[3] = { ['x'] = 510.01, ['y'] = 3497.75, ['z'] = 33.59 },
			[4] = { ['x'] = 224.54, ['y'] = 2988.53, ['z'] = 41.9 },
			[5] = { ['x'] = -77.74, ['y'] = 2825.41, ['z'] = 52.54 },
			[6] = { ['x'] = -266.94, ['y'] = 2640.0, ['z'] = 60.12 },
			[7] = { ['x'] = -369.78, ['y'] = 2731.3, ['z'] = 62.14 },
			[8] = { ['x'] = -437.18, ['y'] = 2756.04, ['z'] = 44.95 },
			[9] = { ['x'] = -561.67, ['y'] = 2605.66, ['z'] = 46.13 },
			[10] = { ['x'] = -723.51, ['y'] = 2354.48, ['z'] = 67.4 },
			[11] = { ['x'] = -774.27, ['y'] = 2214.64, ['z'] = 90.39 },
			[12] = { ['x'] = -795.74, ['y'] = 2114.69, ['z'] = 110.24 },
			[13] = { ['x'] = -688.21, ['y'] = 1924.37, ['z'] = 145.3 },
			[14] = { ['x'] = -896.92, ['y'] = 1693.88, ['z'] = 186.54 },
			[15] = { ['x'] = -778.33, ['y'] = 1533.45, ['z'] = 221.95 },
			[16] = { ['x'] = -762.69, ['y'] = 1179.79, ['z'] = 261.68 },
			[17] = { ['x'] = -712.62, ['y'] = 860.54, ['z'] = 222.48 },
			[18] = { ['x'] = -694.41, ['y'] = 810.6, ['z'] = 205.64 },
			[19] = { ['x'] = -581.46, ['y'] = 786.96, ['z'] = 187.32 },
			[20] = { ['x'] = -695.73, ['y'] = 760.32, ['z'] = 168.28 },
			[21] = { ['x'] = -528.01, ['y'] = 663.72, ['z'] = 140.77 },
			[22] = { ['x'] = -397.69, ['y'] = 529.63, ['z'] = 121.49 },
			[23] = { ['x'] = -101.21, ['y'] = 421.02, ['z'] = 112.56 },
			[24] = { ['x'] = 142.65, ['y'] = 299.23, ['z'] = 110.17 },
			[25] = { ['x'] = 195.9, ['y'] = 331.68, ['z'] = 104.83 },
			[26] = { ['x'] = 361.79, ['y'] = 263.91, ['z'] = 102.34 },
			[27] = { ['x'] = 457.86, ['y'] = 232.7, ['z'] = 102.54 },
			[28] = { ['x'] = 357.13, ['y'] = -263.51, ['z'] = 53.29 },
			[29] = { ['x'] = 759.71, ['y'] = -1005.74, ['z'] = 25.61 },
			[30] = { ['x'] = 705.07, ['y'] = -1088.04, ['z'] = 21.78 },
			[31] = { ['x'] = 726.2, ['y'] = -1161.23, ['z'] = 23.62 },
			[32] = { ['x'] = 903.4, ['y'] = -1790.05, ['z'] = 29.89 },
			[33] = { ['x'] = 869.37, ['y'] = -2076.42, ['z'] = 29.75 },
			[34] = { ['x'] = 833.36, ['y'] = -2363.18, ['z'] = 29.74 },
			[35] = { ['x'] = 739.77, ['y'] = -2470.18, ['z'] = 19.59 },
			[36] = { ['x'] = 712.88, ['y'] = -3204.84, ['z'] = 18.82 },
			[37] = { ['x'] = 1188.29, ['y'] = -3340.63, ['z'] = 5.16 },
			[38] = { ['x'] = 1253.1, ['y'] = -3091.81, ['z'] = 5.14 },
			[39] = { ['x'] = 1187.86, ['y'] = -2957.01, ['z'] = 5.9 },
			[40] = { ['x'] = 789.3, ['y'] = -2911.17, ['z'] = 6.41 },
			[41] = { ['x'] = 632.22, ['y'] = -2891.26, ['z'] = 5.38 },
	},
	[4] = { 
		   ['time'] = 400,
		   [1] = { ['x'] = 2061.48, ['y'] = 3069.8, ['z'] = 45.8 },
		   [2] = { ['x'] = 2574.85, ['y'] = 3052.61, ['z'] = 44.0 }, 
		   [3] = { ['x'] = 2933.28, ['y'] = 3934.76, ['z'] = 51.24 },
		   [4] = { ['x'] = 2843.52, ['y'] = 4422.63, ['z'] = 48.43 },
		   [5] = { ['x'] = 2944.07, ['y'] = 4730.12, ['z'] = 49.67 }, 
		   [6] = { ['x'] = 2865.84, ['y'] = 4896.17, ['z'] = 62.76 },
		   [7] = { ['x'] = 2609.48, ['y'] = 5507.63, ['z'] = 61.35 },
		   [8] = { ['x'] = 2438.47, ['y'] = 5825.31, ['z'] = 60.03 },
		   [9] = { ['x'] = 1829.32, ['y'] = 6280.4, ['z'] = 50.51 },
		   [10] = { ['x'] = 1542.04, ['y'] = 6427.68, ['z'] = 23.18 },
		   [11] = { ['x'] = 660.82, ['y'] = 6515.86, ['z'] = 27.51 },
		   [12] = { ['x'] = -183.37, ['y'] = 6204.7, ['z'] = 30.56 },
		   [13] = { ['x'] = -449.49, ['y'] = 6071.28, ['z'] = 30.73 },
		   [14] = { ['x'] = -733.1, ['y'] = 5759.3,17, ['z'] = 17.91 },
		   [15] = { ['x'] = -783.57, ['y'] = 5497.59, ['z'] = 33.84 },
		   [16] = { ['x'] = -1321.03, ['y'] = 5179.21, ['z'] = 59.16 },
		   [17] = { ['x'] = -2161.18, ['y'] = 4454.63, ['z'] = 62.55 },
		   [18] = { ['x'] = -2531.9, ['y'] = 3691.61, ['z'] = 9.29 },
		   [19] = { ['x'] = -2678.68, ['y'] = 3476.06, ['z'] = 13.09 },
		   [20] = { ['x'] = -2753.63, ['y'] = 3095.33, ['z'] = 8.58 },
		   [21] = { ['x'] = -2611.66, ['y'] = 2941.99, ['z'] = 16.01 },
		   [22] = { ['x'] = -3032.0, ['y'] = 1887.12, ['z'] = 28.69 },
		   [23] = { ['x'] = -3090.36, ['y'] = 742.96, ['z'] = 20.34 },
		   [24] = { ['x'] = -3039.5, ['y'] = 214.15, ['z'] = 15.48 },
		   [25] = { ['x'] = -2181.71, ['y'] = -356.75, ['z'] = 12.46 },
		   [26] = { ['x'] = -2021.25, ['y'] = -455.53, ['z'] = 10.85 },
		   [27] = { ['x'] = -1646.35, ['y'] = -1087.38, ['z'] = 2.1 },
		   [28] = { ['x'] = -1205.43, ['y'] = -1795.78, ['z'] = 3.25 }
			
	},
	[5] = { 
		   ['time'] = 350,
		   [1] = { ['x'] = 1872.55, ['y'] = 3309.08, ['z'] = 43.15 },
		   [2] = { ['x'] = 2323.4, ['y'] = 3237.64, ['z'] = 47.12 },
		   [3] = { ['x'] = 2683.71, ['y'] = 3262.27, ['z'] = 54.57 },
		   [4] = { ['x'] = 2451.42, ['y'] = 2875.9, ['z'] = 48.34 },
		   [5] = { ['x'] = 2534.89, ['y'] = 1893.38, ['z'] = 20.13 },
		   [6] = { ['x'] = 2660.84, ['y'] = 1638.09, ['z'] = 23.92 },
		   [7] = { ['x'] = 2817.9, ['y'] = 1695.48, ['z'] = 24.02 },
		   [8] = { ['x'] = 2750.05, ['y'] = 1404.6, ['z'] = 23.83 },
		   [9] = { ['x'] = 2687.15, ['y'] = 1494.01, ['z'] = 23.92 },
		   [10] = { ['x'] = 2660.94, ['y'] = 1646.44, ['z'] = 23.92 },
		   [11] = { ['x'] = 2275.78, ['y'] = 1086.42, ['z'] = 65.81 },
		   [12] = { ['x'] = 2397.08, ['y'] = 813.63, ['z'] = 120.78 },
		   [13] = { ['x'] = 2368.44, ['y'] = 279.21, ['z'] = 185.61 },
		   [14] = { ['x'] = 2020.04, ['y'] = -10.97, ['z'] = 201.69 },
		   [15] = { ['x'] = 1930.44, ['y'] = -75.46, ['z'] = 192.58 },
		   [16] = { ['x'] = 1705.47, ['y'] = -82.26, ['z'] = 176.37 },
		   [17] = { ['x'] = 1337.12, ['y'] = -121.31, ['z'] = 117.8 },
		   [18] = { ['x'] = 1221.67, ['y'] = -282.8, ['z'] = 68.83 },
		   [19] = { ['x'] = 1207.16, ['y'] = -354.67, ['z'] = 68.43 },
		   [20] = { ['x'] = 1140.21, ['y'] = -944.55, ['z'] = 47.98 },
		   [21] = { ['x'] = 154.75, ['y'] = -1012.64, ['z'] = 28.72 },
		   [22] = { ['x'] = -353.29, ['y'] = -805.78, ['z'] = 31.95 },
		   [23] = { ['x'] = -273.8, ['y'] = -770.78, ['z'] = 55.76 },
		   [24] = { ['x'] = 82.5, ['y'] = -543.4, ['z'] = 33.16 },
		   [25] = { ['x'] = 315.81, ['y'] = -406.43, ['z'] = 44.57 },
		   [26] = { ['x'] = 316.6, ['y'] = -178.86, ['z'] = 56.96 },
		   [27] = { ['x'] = 191.54, ['y'] = 60.81, ['z'] = 82.93 },
		   [28] = { ['x'] = 68.13, ['y'] = 125.12, ['z'] = 78.51 }
	},	 
	[6] = {
		   ['time'] = 400,
		   [1] = { ['x'] = 1915.51, ['y'] = 3314.56, ['z'] = 43.86 },
		   [2] = { ['x'] = 2238.54, ['y'] = 3259.84, ['z'] = 47.32 },
		   [3] = { ['x'] = 2115.23, ['y'] = 3569.66, ['z'] = 41.51 },
		   [4] = { ['x'] = 2072.03, ['y'] = 3710.52, ['z'] = 32.27 },
		   [5] = { ['x'] = 2645.92, ['y'] = 4327.33, ['z'] = 43.98 },
		   [6] = { ['x'] = 2719.07, ['y'] = 4755.65, ['z'] = 43.8 },
		   [7] = { ['x'] = 2589.28, ['y'] = 5105.05, ['z'] = 44.08 },
		   [8] = { ['x'] = 2371.29, ['y'] = 5115.65, ['z'] = 46.79 },
		   [9] = { ['x'] = 2210.21, ['y'] = 5148.3, ['z'] = 55.51 },
		   [10] = { ['x'] = 1947.66, ['y'] = 4916.54, ['z'] = 43.86 },
		   [11] = { ['x'] = 1783.8, ['y'] = 4914.6, ['z'] = 41.77 },
		   [12] = { ['x'] = 1961.6, ['y'] = 4605.33, ['z'] = 39.57 },
		   [13] = { ['x'] = 1490.21, ['y'] = 4517.64, ['z'] = 52.31 },
		   [14] = { ['x'] = 1088.3, ['y'] = 4438.42, ['z'] = 60.52 },
		   [15] = { ['x'] = 812.97, ['y'] = 4472.66, ['z'] = 51.89 },
		   [16] = { ['x'] = 708.71, ['y'] = 4218.54, ['z'] = 50.21 },
		   [17] = { ['x'] = 375.71, ['y'] = 4447.3, ['z'] = 62.27 },
		   [18] = { ['x'] = -60.14, ['y'] = 4386.99, ['z'] = 54.46 },
		   [19] = { ['x'] = -196.79, ['y'] = 3743.09, ['z'] = 42.09 },
		   [20] = { ['x'] = 129.11, ['y'] = 3418.86, ['z'] = 39.67 },
		   [21] = { ['x'] = 265.71, ['y'] = 2632.92, ['z'] = 44.06 },
		   [22] = { ['x'] = -751.66, ['y'] = 2792.4, ['z'] = 24.78 },
		   [23] = { ['x'] = -1315.96, ['y'] = 2552.64, ['z'] = 17.33 },
		   [24] = { ['x'] = -1687.93, ['y'] = 2990.32, ['z'] = 32.18 },
		   [25] = { ['x'] = -1739.83, ['y'] = 2884.49, ['z'] = 32.14 },
		   [26] = { ['x'] = -1944.65, ['y'] = 2813.5, ['z'] = 32.12 }
	},
	[7] = {
		   ['time'] = 400,
		   [1] = { ['x'] = 1879.47, ['y'] = 3204.98, ['z'] = 45.0 },
		   [2] = { ['x'] = 2422.19, ['y'] = 2888.17, ['z'] = 48.59 },
		   [3] = { ['x'] = 2346.75, ['y'] = 2814.11, ['z'] = 41.79 },
		   [4] = { ['x'] = 1918.23, ['y'] = 2433.11, ['z'] = 53.91 },
		   [5] = { ['x'] = 1723.8, ['y'] = 1497.39, ['z'] = 84.14 },
		   [6] = { ['x'] = 1967.5, ['y'] = 1584.97, ['z'] = 76.22 },
		   [7] = { ['x'] = 2458.65, ['y'] = 911.69, ['z'] = 89.09 },
		   [8] = { ['x'] = 2567.9, ['y'] = 363.07, ['z'] = 107.79 },
		   [9] = { ['x'] = 2484.06, ['y'] = -7.69, ['z'] = 93.54 },
		   [10] = { ['x'] = 1899.58, ['y'] = -748.49, ['z'] = 83.73 },
		   [11] = { ['x'] = 1295.08, ['y'] = -1108.66, ['z'] = 50.55 },
		   [12] = { ['x'] = 1023.44, ['y'] = -1279.65, ['z'] = 40.53 },
		   [13] = { ['x'] = 844.96, ['y'] = -1059.28, ['z'] = 40.01 },
		   [14] = { ['x'] = 786.86, ['y'] = -1025.85, ['z'] = 25.55 },
		   [15] = { ['x'] = 757.29, ['y'] = -476.14, ['z'] = 35.66 },
		   [16] = { ['x'] = 515.66, ['y'] = -371.01, ['z'] = 43.09 },
		   [17] = { ['x'] = 563.84, ['y'] = -585.99, ['z'] = 43.49 },
		   [18] = { ['x'] = 569.83, ['y'] = -944.63, ['z'] = 9.98 },
		   [19] = { ['x'] = 613.52, ['y'] = -1915.07, ['z'] = 16.08 },
		   [20] = { ['x'] = 546.73, ['y'] = -2035.61, ['z'] = 27.78 },
		   [21] = { ['x'] = 345.89, ['y'] = -2368.21, ['z'] = 9.46 },
		   [22] = { ['x'] = 479.07, ['y'] = -2529.16, ['z'] = 8.53 },
		   [23] = { ['x'] = 680.37, ['y'] = -2788.26, ['z'] = 5.28 },
		   [24] = { ['x'] = 797.99, ['y'] = -3045.59, ['z'] = 5.07 },
		   [25] = { ['x'] = 1192.89, ['y'] = -2993.65, ['z'] = 5.23 },
		   [26] = { ['x'] = 869.35, ['y'] = -2913.37, ['z'] = 5.23 },
		   [27] = { ['x'] = 628.45, ['y'] = -2889.92, ['z'] = 5.38 },
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTRACES
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if not inrace then
			local ped = PlayerPedId()
			local vehicle = GetVehiclePedIsUsing(ped)
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(CoordenadaX,CoordenadaY,CoordenadaZ)
			local distance = GetDistanceBetweenCoords(CoordenadaX,CoordenadaY,cdz,x,y,z,true)

			if distance <= 30.0 then
				if IsEntityAVehicle(vehicle) and GetVehicleClass(vehicle) ~= 8 and GetPedInVehicleSeat(vehicle,-1) == ped then
					DrawMarker(23,CoordenadaX,CoordenadaY,CoordenadaZ-0.96,0,0,0,0,0,0,10.0,10.0,1.0,255,0,0,50,0,0,0,0)
					if distance <= 5.9 then
						drawTxt("PRESSIONE  ~r~E~w~  PARA INICIAR A CORRIDA",4,0.5,0.93,0.50,255,255,255,180)
						if IsControlJustPressed(0,38) and  emP.ticketCheck() 	then
							emP.setSearchTimer()
							inrace = true
							racepos = 1
							racepoint = emP.getRacepoint()
							timerace = races[racepoint].time
							CriandoBlip(races,racepoint,racepos)
							explosive = math.random(100)
							if explosive >= 80 then
								emP.startBombRace()
								bomba = CreateObject(GetHashKey("prop_c4_final_green"),x,y,z,true,true,true)
								AttachEntityToEntity(bomba,vehicle,GetEntityBoneIndexByName(vehicle,"exhaust"),0.0,0.0,0.0,180.0,-90.0,180.0,false,false,false,true,2,true)
								PlaySoundFrontend(-1,"Oneshot_Final","MP_MISSION_COUNTDOWN_SOUNDSET",false)
								TriggerEvent("Notify","negado","Você começou uma corrida <b>Explosiva</b>, não saia do veículo e termine no tempo estimado, ou então seu veículo vai explodir com você dentro.",8000)
								end
							end
						end
					end
				end
			end
		end
	end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPOINTS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if inrace then
			local ped = PlayerPedId()
			local vehicle = GetVehiclePedIsUsing(ped)
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(races[racepoint][racepos].x,races[racepoint][racepos].y,races[racepoint][racepos].z)
			local distance = GetDistanceBetweenCoords(races[racepoint][racepos].x,races[racepoint][racepos].y,cdz,x,y,z,true)

			if distance <= 100.0 then
				if IsEntityAVehicle(vehicle) and GetVehicleClass(vehicle) ~= 8 then
					DrawMarker(1,races[racepoint][racepos].x,races[racepoint][racepos].y,races[racepoint][racepos].z-3,0,0,0,0,0,0,12.0,12.0,8.0,255,255,255,25,0,0,0,0)
					DrawMarker(21,races[racepoint][racepos].x,races[racepoint][racepos].y,races[racepoint][racepos].z+1,0,0,0,0,180.0,130.0,3.0,3.0,2.0,255,0,0,50,1,0,0,1)
					if distance <= 15.1 then
						RemoveBlip(blips)
						if racepos == #races[racepoint] then
							inrace = false
							PlaySoundFrontend(-1,"RACE_PLACED","HUD_AWARDS",false)
							if explosive >= 80 then
								explosive = 0
								DeleteObject(bomba)
								emP.removeBombRace()
								emP.paymentCheck(racepoint,2)
							else
								emP.paymentCheck(racepoint,1)
							end
						else
							racepos = racepos + 1
							CriandoBlip(races,racepoint,racepos)
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMEDRAWN
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if inrace and timerace > 0 and GetVehiclePedIsUsing(PlayerPedId()) then
			drawTxt("RESTAM ~g~"..timerace.." SEGUNDOS ~w~PARA CHEGAR AO DESTINO FINAL DA CORRIDA",4,0.5,0.905,0.45,255,255,255,100)
			drawTxt("VENÇA A CORRIDA E SUPERE SEUS PROPRIOS RECORDES ANTES DO TEMPO ACABAR",4,0.5,0.93,0.38,255,255,255,50)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMERACE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if inrace and timerace > 0 then
			timerace = timerace - 1
			if timerace <= 0 or not IsPedInAnyVehicle(PlayerPedId()) then
				inrace = false
				RemoveBlip(blips)
				if explosive >= 80 then
					SetTimeout(3000,function()
						explosive = 0
						DeleteObject(bomba)
						emP.removeBombRace()
						AddExplosion(GetEntityCoords(GetPlayersLastVehicle()),1,1.0,true,true,true)
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEBOMB
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("emp_race:unbomb")
AddEventHandler("emp_race:unbomb",function()
	inrace = false
	RemoveBlip(blips)
	if explosive >= 80 then
		explosive = 0
		DeleteObject(bomba)
		emP.removeBombRace()
		TriggerEvent("Notify","importante","A <b>Bomba</b> foi desarmada com sucesso.")
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

function CriandoBlip(races,racepoint,racepos)
	blips = AddBlipForCoord(races[racepoint][racepos].x,races[racepoint][racepos].y,races[racepoint][racepos].z)
	SetBlipSprite(blips,1)
	SetBlipColour(blips,1)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Corrida Clandestina")
	EndTextCommandSetBlipName(blips)
end