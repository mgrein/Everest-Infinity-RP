--------------------------------------------------------
-------------VENDA DE DROGA PRA NPC-------------------
-------------------------------------------------------

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

emP = {}
Tunnel.bindInterface("emp_drogas",emP)
local idgens = Tools.newIDGenerator()
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {}
local quantidade = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- QUANTIDADE
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.Quantidade()
	local source = source
	if quantidade[source] == nil then
		quantidade[source] = math.random(2,4)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECAGEM 
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkItens()
	emP.Quantidade()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRP.hasPermission(user_id,"vagos.permissao") and not vRP.hasPermission(user_id,"groove.permissao") and not vRP.hasPermission(user_id,"ballas.permissao") and not vRP.hasPermission(user_id,"bahamas.permissao")  then
			return vRP.getInventoryItemAmount(user_id,"cocaina") >= quantidade[source] or vRP.getInventoryItemAmount(user_id,"maconha") >= quantidade[source] or vRP.getInventoryItemAmount(user_id,"moonshine") >= quantidade[source] or vRP.getInventoryItemAmount(user_id,"metanfetamina") >= quantidade[source]  
		else 
			TriggerClientEvent("Notify",source,"negado","Venda proibida.")	
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAGAMENTO 
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment()
    local source = source
	local user_id = vRP.getUserId(source)
    local item1 = "cocaina" 
    local item2 = "maconha" 
	local item3 = "metanfetamina"
	local item4 = "moonshine"
    if user_id then
        local policia = vRP.getUsersByPermission("policia.permissao")
        if vRP.tryGetInventoryItem(user_id,item1,quantidade[source]) or vRP.tryGetInventoryItem(user_id,item2,quantidade[source]) or vRP.tryGetInventoryItem(user_id,item3,quantidade[source]) or vRP.tryGetInventoryItem(user_id,item4,quantidade[source]) then
			local pagamento = math.random(600,800)*quantidade[source]+(#policia*90)
			vRP.giveInventoryItem(user_id,"dinheirosujo",pagamento)
			TriggerClientEvent("Notify",source,"sucesso", "Você vendeu <b>"..quantidade[source].."x Drogas</b> e recebeu <b>$"..pagamento.." dólares</b>.")
			TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
            vRPclient._playAnim(source,true,{{"mp_common","givetake1_a"}},false)
			quantidade[source] = nil
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OCORRENCIA
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.MarcarOcorrencia()
	local source = source
	local user_id = vRP.getUserId(source)
	local x,y,z = vRPclient.getPosition(source)
	if user_id then
		TriggerClientEvent("Notify",source,"aviso","A policia foi acionada.")
		TriggerEvent("global:avisarPolicia", "Recebemos uma denuncia de drogas, verifique o ocorrido.",x,y,z, 1)
	end
end
