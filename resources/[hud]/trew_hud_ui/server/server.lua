local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface('vRP')

local Config = module('trew_hud_ui', 'config')

local Locales = module('trew_hud_ui', 'locales/languages')

func = {}
Tunnel.bindInterface("trew_hud_ui", func)

function _U(entry) return Locales['br'][entry] end

function func.getFomeSede()
    local source = source
    local playerID = vRP.getUserId(source)

    local getFomeSede = vRP.getUData(playerID, "fomeSede")
    local data = json.decode(getFomeSede)
    return data
end

function func.setFomeSede(fome, sede)
    local source = source
    local playerID = vRP.getUserId(source)

    local fomeSede = {}
    fomeSede.fome = fome
    fomeSede.sede = sede
    vRP.setUData(playerID, "fomeSede", json.encode(fomeSede))
end

RegisterServerEvent('trew_hud_ui:getServerInfo')
AddEventHandler('trew_hud_ui:getServerInfo', function()

    local source = source
    local playerID = vRP.getUserId(source)

    local getFomeSede = vRP.getUData(playerID, "fomeSede")
    local data = json.decode(getFomeSede)
    if data ~= nil then
        local info = {
            hunger = data.fome,
            thirst = data.sede,

            job = vRP.getUserGroupByType(playerID, 'job'),

            money = vRP.getMoney(playerID),
            bankMoney = vRP.getBankMoney(playerID),
            blackMoney = vRP.getInventoryItemAmount(playerID,
                                                    Config.vRP.items.blackMoney)
        }

        TriggerClientEvent('trew_hud_ui:setInfo', source, info)
    end
end)

RegisterServerEvent('trew_hud_ui:syncCarLights')
AddEventHandler('trew_hud_ui:syncCarLights', function(status)
    TriggerClientEvent('trew_hud_ui:syncCarLights', -1, source, status)
end)

AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
    local getFomeSede = vRP.getUData(user_id, "fomeSede")
    if getFomeSede == nil then
        local fomeSede = {}
        fomeSede.fome = fome
        fomeSede.sede = sede
        vRP.setUData(user_id, "fomeSede", json.encode(fomeSede))
    end
end)
