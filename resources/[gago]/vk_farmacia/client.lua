-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vk_farmacia",src)
vSERVER = Tunnel.getInterface("vk_farmacia")
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCALIDADES
-----------------------------------------------------------------------------------------------------------------------------------------
local localidades = {
	{318.1,-1076.98,29.48},
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		Citizen.Wait(5)
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local x,y,z = table.unpack(GetEntityCoords(ped))
			for k,v in pairs(localidades) do
				local distance = Vdist(x,y,z,v[1],v[2],v[3])
				if distance <= 1.2 and IsControlJustPressed(0,38) and vSERVER.checkSearch() then
					SetNuiFocus(true,true)
					SendNUIMessage({ action = "showMenu" })
					vRP._CarregarObjeto("amb@code_human_in_bus_passenger_idles@female@tablet@idle_a","idle_b","prop_cs_tablet",49,28422)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("shopClose",function(data)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
	vRP._DeletarObjeto()
	vRP._stopAnim(false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UTILIDADESLIST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("utilidadesList",function(data,cb)
	local shopitens = vSERVER.utilidadesList()
	if shopitens then
		cb({ shopitens = shopitens })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VESTUARIOLIST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("vestuarioList",function(data,cb)
	local shopitens = vSERVER.vestuarioList()
	if shopitens then
		cb({ shopitens = shopitens })
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPBUY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("shopBuy",function(data)
	if data.index ~= nil then
		vSERVER.shopBuy(data.index,data.price,data.amount)
	end
end)