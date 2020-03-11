local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("nav_bloods",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARRAY
-----------------------------------------------------------------------------------------------------------------------------------------
local valores = {
	{ item = "lockpick", quantidade = 1, compra = 50, venda = 25},
	{ item = "masterpick", quantidade = 1, compra = 100, venda = 50 },
	{ item = "pendrive", quantidade = 1, compra = 50, venda = 25 },
	{ item = "rebite", quantidade = 1, compra = 10, venda = 5 },
	{ item = "rubberducky", quantidade = 1, compra = 100, venda = 50 },
	{ item = "chavemestra", quantidade = 1, compra = 30, venda = 15 },
	{ item = "serra", quantidade = 1, compra = 300, venda = 150 },
	{ item = "furadeira", quantidade = 1, compra = 300, venda = 150 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPRAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("bloods-comprar")
AddEventHandler("bloods-comprar",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(valores) do
			if item == v.item then
				if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item)*v.quantidade <= vRP.getInventoryMaxWeight(user_id) then
					if vRP.tryGetInventoryItem(user_id,"chavedeacesso",v.compra) then
						vRP.giveInventoryItem(user_id,v.item,parseInt(v.quantidade))
						TriggerClientEvent("Notify",source,"sucesso","Comprou <b>"..parseInt(v.quantidade).."x "..vRP.getItemName(v.item).."</b> por <b>x"..vRP.format(parseInt(v.compra)).." Chave de Acesso</b>.")
					else
						TriggerClientEvent("Notify",source,"negado","Chave de Acesso insuficiente.")
					end
				else
					TriggerClientEvent("Notify",source,"negado","Espaço insuficiente.")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VENDER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("bloods-vender")
AddEventHandler("bloods-vender",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(valores) do
			if item == v.item then
				if vRP.tryGetInventoryItem(user_id,v.item,parseInt(v.quantidade)) then
					vRP.giveInventoryItem(user_id,"chavedeacesso",parseInt(v.venda))
					TriggerClientEvent("Notify",source,"sucesso","Vendeu <b>"..parseInt(v.quantidade).."x "..vRP.getItemName(v.item).."</b> por <b>x"..vRP.format(parseInt(v.venda)).."Chave de Acesso</b>.")
				else
					TriggerClientEvent("Notify",source,"negado","Não possui <b>"..parseInt(v.quantidade).."x "..vRP.getItemName(v.item).."</b> em sua mochila.")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECK PERMISSAO
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"bloods.permissao")
end

