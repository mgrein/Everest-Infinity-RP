local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

local flanela = false
local flaneladois = false

local flanelapos = 0

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if not flanela then
			local distance01 = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),480.50518798828,-1336.2198486328,29.265825271606,true)
			local distance02 = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),472.58142089844,-1311.6285400391,29.21489906311,true)
			local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),472.58142089844,-1311.6285400391,29.21489906311,true)

			if distance01 <= 100 and not flaneladois and flanelapos == 0 then
				DrawMarker(21,480.50518798828,-1336.2198486328,29.265825271606,0,0,0,0,180.0,130.0,1.0,1.0,0.5,255,255,255,100,1,0,0,1)
				if distance01 <= 1.2 then
					drawTxt("PRESSIONE  ~b~E~w~  PARA COLETAR",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) and not IsPedInAnyVehicle(ped) then
						TriggerEvent("Notify","importante","Recebeu a <b>peça</b>, leve para dentro da loja.")
						flaneladois = true
						flanelapos = 1
						ResetPedMovementClipset(PlayerPedId(),0)
						SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
						vRP._CarregarObjeto("anim@heists@box_carry@","idle","prop_etricmotor_01",50,28422)
					end
				end
			end

			if distance02 <= 100 and flaneladois and flanelapos == 1 then
				DrawMarker(21,472.58142089844,-1311.6285400391,29.21489906311,0,0,0,0,180.0,130.0,1.0,1.0,0.5,255,255,255,100,1,0,0,1)
				if distance02 <= 1.2 then
					drawTxt("PRESSIONE  ~b~E~w~  PARA CONCLUIR",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) then
						flaneladois = false
						flanelapos = 2
						-- TriggerServerEvent("entregarcarga")
						vRP._DeletarObjeto()
					end
				end
			end

			if distance <= 100.0 and not flaneladois and flanelapos == 2 then
				DrawMarker(21,472.58142089844,-1311.6285400391,29.21489906311-0.3,0,0,0,0,180.0,130.0,0.6,0.8,0.5,255,0,0,150,1,0,0,1)
				if distance <= 1.2 and IsControlJustPressed(0,38) and not IsPedInAnyVehicle(ped) then
					flanelapos = 0
					TriggerEvent("Notify","importante","Arrume a <b>peça</b> para efetuar a venda.")
					TriggerEvent("cancelado",true)
					local prop = "prop_etricmotor_01"
					local h = GetEntityHeading(PlayerPedId())
					cone = CreateObject(GetHashKey(prop),471.84652709961,-1312.0275878906,30.272994995117,true,true,true)
					PlaceObjectOnGroundProperly(cone)
					SetModelAsNoLongerNeeded(cone)
					SetEntityAsMissionEntity(cone,true,true)
					SetEntityHeading(cone,h)
					FreezeEntityPosition(cone,true)
					SetEntityAsNoLongerNeeded(cone)
					vRP._playAnim(false,{{"mini@repair","fixing_a_ped"}},true) 
					SetTimeout(10000,function()
						servico = false
						vRP._DeletarObjeto()
						vRP._stopAnim(false)
						DoesObjectOfTypeExistAtCoords(471.84652709961,-1312.0275878906,30.272994995117,0.9,GetHashKey(prop),true)
						cone = GetClosestObjectOfType(471.84652709961,-1312.0275878906,30.272994995117,0.9,GetHashKey(prop),false,false,false)
						TriggerServerEvent("trydeleteobj",ObjToNet(cone))
						TriggerEvent("cancelando",false)
						backentrega = selecionado
					TriggerServerEvent('terminar:Solda')
					TriggerEvent("Notify","sucesso","Processo <b>concluido</b> prossiga para a venda.")
					end)
				end
			end
		
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if flaneladois then
			BlockWeaponWheelThisFrame()
			DisableControlAction(0,21,true)
			DisableControlAction(0,24,true)
			DisableControlAction(0,25,true)
			DisableControlAction(0,58,true)
			DisableControlAction(0,263,true)
			DisableControlAction(0,264,true)
			DisableControlAction(0,257,true)
			DisableControlAction(0,140,true)
			DisableControlAction(0,141,true)
			DisableControlAction(0,142,true)
			DisableControlAction(0,143,true)
			DisableControlAction(0,75,true)
			DisableControlAction(0,22,true)
			DisableControlAction(0,32,true)
			DisableControlAction(0,268,true)
			DisableControlAction(0,33,true)
			DisableControlAction(0,269,true)
			DisableControlAction(0,34,true)
			DisableControlAction(0,270,true)
			DisableControlAction(0,35,true)
			DisableControlAction(0,271,true)
			DisableControlAction(0,288,true)
			DisableControlAction(0,289,true)
			DisableControlAction(0,170,true)
			DisableControlAction(0,166,true)
			DisableControlAction(0,73,true)
			DisableControlAction(0,167,true)
			DisableControlAction(0,177,true)
			DisableControlAction(0,311,true)
			DisableControlAction(0,344,true)
			DisableControlAction(0,29,true)
			DisableControlAction(0,182,true)
			DisableControlAction(0,245,true)
			DisableControlAction(0,246,true)
			DisableControlAction(0,303,true)
			DisableControlAction(0,187,true)
			DisableControlAction(0,189,true)
			DisableControlAction(0,190,true)
			DisableControlAction(0,188,true)
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