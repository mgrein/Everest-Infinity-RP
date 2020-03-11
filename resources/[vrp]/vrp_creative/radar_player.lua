local radar = {
	shown = false,
	freeze = false,
	info = "INICIANDO O SISTEMA DO RADAR",
	info2 = "INICIANDO O SISTEMA DO RADAR"
}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if IsControlJustPressed(1,306) and IsPedInAnyVehicle(PlayerPedId()) then
			if radar.shown then
				radar.shown = false
			else
				radar.shown = true
			end
		end

		if IsControlJustPressed(1,301) and IsPedInAnyVehicle(PlayerPedId()) then
			if radar.freeze then
				radar.freeze = false
			else
				radar.freeze = true
			end
		end

		if radar.shown then
			if radar.freeze == false then
				local veh = GetVehiclePedIsIn(PlayerPedId(),false)
				local coordA = GetOffsetFromEntityInWorldCoords(veh,0.0,1.0,1.0)
				local coordB = GetOffsetFromEntityInWorldCoords(veh,0.0,105.0,0.0)
				local frontcar = StartShapeTestCapsule(coordA,coordB,3.0,10,veh,7)
				local a,b,c,d,e = GetShapeTestResult(frontcar)

				if IsEntityAVehicle(e) then
					local fmodel = GetDisplayNameFromVehicleModel(GetEntityModel(e))
					local fvspeed = GetEntitySpeed(e)*2.236936
					local fplate = GetVehicleNumberPlateText(e)
					radar.info = string.format("~y~MODELO: ~w~%s   ~y~VELOCIDADE: ~w~%s MP/H",fmodel,math.ceil(fvspeed))
				end

				local bcoordB = GetOffsetFromEntityInWorldCoords(veh,0.0,-105.0,0.0)
				local rearcar = StartShapeTestCapsule(coordA,bcoordB,3.0,10,veh,7)
				local f,g,h,i,j = GetShapeTestResult(rearcar)

				if IsEntityAVehicle(j) then
					local bmodel = GetDisplayNameFromVehicleModel(GetEntityModel(j))
					local bvspeed = GetEntitySpeed(j)*2.236936
					local bplate = GetVehicleNumberPlateText(j)
					radar.info2 = string.format("~y~MODELO: ~w~%s   ~y~VELOCIDADE: ~w~%s MP/H",bmodel,math.ceil(bvspeed))
				end
			end
			drawTxt(radar.info,6,0.8,0.82,0.40,255,255,255,180)
			drawTxt(radar.info2,6,0.8,0.84,0.40,255,255,255,180)
		end

		if not IsPedInAnyVehicle(PlayerPedId()) and radar.shown then
			radar.shown = false
		end
	end
end)

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