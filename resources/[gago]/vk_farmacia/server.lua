-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vk_farmacia", src)
vCLIENT = Tunnel.getInterface("vk_farmacia")
-----------------------------------------------------------------------------------------------------------------------------------------
-- UTILIDADES
-----------------------------------------------------------------------------------------------------------------------------------------
local utilidades = {
    ["adrenalina"] = { ['price'] = 10000 },
    ["bandagem"] = { ['price'] = 4000 },
    ["remedio"] = { ['price'] = 2000 },
    ["agua"] = {['price'] = 120}
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- UTILIDADESLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function src.utilidadesList()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local itemlist = {}
        for k, v in pairs(utilidades) do
            table.insert(itemlist, {
                index = k,
                name = vRP.itemNameList(k),
                price = parseInt(v.price)
            })
        end
        return itemlist
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPBUY
-----------------------------------------------------------------------------------------------------------------------------------------
function src.shopBuy(index, price, amount)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.getInventoryItemAmount(user_id, index) < 5 then
            if vRP.getInventoryWeight(user_id) + vRP.getItemWeight(index) *
                parseInt(amount) <= vRP.getInventoryMaxWeight(user_id) then
                if vRP.getPremium(user_id) then
                    if vRP.tryFullPayment(user_id,
                                          parseInt(price * amount) * 0.95) then
                        vRP.giveInventoryItem(user_id, index, parseInt(amount))
                        TriggerClientEvent("Notify", source, "sucesso",
                                           "Comprou <b>" ..
                                               vRP.format(parseInt(amount)) ..
                                               "x " .. vRP.itemNameList(index) ..
                                               "</b> por <b>$" ..
                                               vRP.format(
                                                   parseInt(
                                                       (price * amount) * 0.95)) ..
                                               " Dolares </b>.", 8000)
                    else
                        TriggerClientEvent("Notify", source, "negado",
                                           "Dinheiro insuficiente.", 8000)
                    end
                else
                    if vRP.tryFullPayment(user_id, parseInt(price * amount)) then
                        vRP.giveInventoryItem(user_id, index, parseInt(amount))
                        TriggerClientEvent("Notify", source, "sucesso",
                                           "Comprou <b>" ..
                                               vRP.format(parseInt(amount)) ..
                                               "x " .. vRP.itemNameList(index) ..
                                               "</b> por <b>$" ..
                                               vRP.format(
                                                   parseInt(price * amount)) ..
                                               " Dolares</b>.", 8000)
                    else
                        TriggerClientEvent("Notify", source, "negado",
                                           "Dinheiro insuficiente.", 8000)
                    end
                end
            else
                TriggerClientEvent("Notify", source, "negado",
                                   "<b>Mochila</b> cheia.", 8000)
            end
        else
            TriggerClientEvent("Notify", source, "negado",
                               "<b>Você atigiu o limite máximo desse item</b>", 8000)
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKSEARCH
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkSearch()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if not vRP.searchReturn(source, user_id) then return true end
        return false
    end
end
