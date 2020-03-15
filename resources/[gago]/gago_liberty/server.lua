-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("gago_liberty",src)
vCLIENT = Tunnel.getInterface("gago_liberty")
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIBERTY
-----------------------------------------------------------------------------------------------------------------------------------------
local liberty = {
	["ticketcorrida"] = { ['price'] = 50 },
	["placa"] = { ['price'] = 55 },
	["rastreador"] = { ['price'] = 100 },
	["lockpick"] = { ['price'] = 55 },
	["masterpick"] = { ['price'] = 55 },
	["pendrive"] = { ['price'] = 55 },
	["rebite"] = { ['price'] = 55 },
	["rubberducky"] = { ['price'] = 55 },
	["chavemestra"] = { ['price'] = 55 },
	["serra"] = { ['price'] = 55 },
	["furadeira"] = { ['price'] = 55 }
    
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- LIBERTYLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function src.libertyList()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local itemlist = {}
		for k,v in pairs(liberty) do
			table.insert(itemlist,{ index = k, name = vRP.itemNameList(k), price = parseInt(v.price) })
		end
		return itemlist
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPBUY
-----------------------------------------------------------------------------------------------------------------------------------------
function src.shopBuy(index,price,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(index)*parseInt(amount) <= vRP.getInventoryMaxWeight(user_id) then
			if vRP.getPremium(user_id) then
				if vRP.tryGetInventoryItem(user_id,"yellowcard",(price*amount)*1.0) then
					vRP.giveInventoryItem(user_id,index,parseInt(amount))
					TriggerClientEvent("Notify",source,"sucesso","Comprou <b>"..vRP.format(parseInt(amount)).."x "..vRP.itemNameList(index).."</b> por <b>x"..vRP.format(parseInt((price*amount)*0.95)).."Yellow Card</b>.",8000)
				else
					TriggerClientEvent("Notify",source,"negado","Yellow Card insuficiente.",8000)
				end
			else
				if vRP.tryGetInventoryItem(user_id,"yellowcard",(price*amount)*1.0) then
					vRP.giveInventoryItem(user_id,index,parseInt(amount))
					TriggerClientEvent("Notify",source,"sucesso","Comprou <b>"..vRP.format(parseInt(amount)).."x "..vRP.itemNameList(index).."</b> por <b>x"..vRP.format(parseInt(price*amount)).." Yellow Card</b>.",8000)
				else
					TriggerClientEvent("Notify",source,"negado","Yellow Card insuficiente.",8000)
				end
			end
		else
			TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",8000)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKSEARCH
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkPermission()
  local source = source
  local user_id = vRP.getUserId(source)
  return vRP.hasPermission(user_id,"liberty.permissao")
end