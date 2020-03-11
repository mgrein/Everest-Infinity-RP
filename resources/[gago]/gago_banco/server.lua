local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","gago_banco")
isTransfer = false

vRP._prepare("sRP/banco",[[
  CREATE TABLE IF NOT EXISTS vrp_banco(
    id INTEGER AUTO_INCREMENT,
    user_id INTEGER,
    extrato VARCHAR(255),
    data VARCHAR(255),
    CONSTRAINT pk_banco PRIMARY KEY(id)
  )
]])

vRP._prepare("sRP/inserir_table","INSERT INTO vrp_banco(user_id, extrato, data) VALUES(@user_id, @extrato, DATE_FORMAT(CURDATE(), '%d/%m/%Y') )")
vRP._prepare("sRP/get_banco_id","SELECT * FROM vrp_banco WHERE user_id = @user_id")
vRP._prepare("sRP/get_dinheiro","SELECT bank FROM vrp_user_moneys WHERE user_id = @user_id")
vRP._prepare("sRP/set_banco","UPDATE vrp_user_moneys SET bank = @bank WHERE user_id = @user_id")

async(function()
  vRP.execute("sRP/banco")
end)

RegisterServerEvent('get:banco')
AddEventHandler('get:banco', function()
    local banco = {}
    local source = source
    local user_id = vRP.getUserId(source)
    local ban = vRP.query("sRP/get_banco_id", {user_id = user_id})
    for i=1, #ban, 1 do
      table.insert(banco, {
        extrato = ban[i].extrato,
        data = ban[i].data
      })
    end
    TriggerClientEvent('send:banco', source, banco)
end)

AddEventHandler("vRPclient:playerSpawned",function(user_id,source) 
    local bankbalance = vRP.getBankMoney(user_id)
    local multasbalance = vRP.getUData(user_id,"vRP:multas")
    TriggerClientEvent('banking:updateBalance', source, bankbalance, multasbalance)
end)

RegisterServerEvent('playerSpawned')
AddEventHandler('playerSpawned', function()
  local user_id = vRP.getUserId(source)
  local bankbalance = vRP.getBankMoney(user_id)
  local multasbalance = vRP.getUData(user_id,"vRP:multas")

  TriggerClientEvent('banking:updateBalance', source, bankbalance, multasbalance)
end)

function bankBalance(user_id)
  return vRP.getBankMoney(user_id)
end

function multasBalance(user_id)
  return vRP.getUData(user_id,"vRP:multas")
end

function Depositar(user_id, amount)
  local bankbalance = vRP.getBankMoney(user_id)
  local new_balance = bankbalance + math.abs(amount)
  TriggerClientEvent("banking:updateBalance", source, new_balance)
  vRP.tryDeposit(user_id,math.floor(math.abs(amount)))
end

function round(num, numDecimalPlaces)
  local mult = 5^(numDecimalPlaces or 0)
  if num and type(num) == "number" then
    return math.floor(num * mult + 0.5) / mult
  end
end

function addComma(amount)
  local formatted = amount
  while true do  
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1.%2')
    if (k==0) then
      break
    end
  end
  return formatted
end

RegisterServerEvent('bank:update')
AddEventHandler('bank:update', function()
  local source = source
  local user_id = vRP.getUserId(source)
  local bankbalance = vRP.getBankMoney(user_id)
  local identity = vRP.getUserIdentity(user_id)
  local multasbalance = vRP.getUData(user_id,"vRP:multas")
  TriggerClientEvent("banking:updateBalance", source, bankbalance, multasbalance, identity.name.." "..identity.firstname) -- ADICIONAR VALORES AQUI PARA APARECER NA NUI + JAVA SCRIPT + HTML
end)

local webhookdepositado1 = "https://discordapp.com/api/webhooks/676604827085832214/gKzlinlog2nQkzvfQyLAO5aKflUgB7T8keuXYdbse2c7YZEMQlr6puhX-zV864bM71yU"
local webhooksacar = "https://discordapp.com/api/webhooks/676604827085832214/gKzlinlog2nQkzvfQyLAO5aKflUgB7T8keuXYdbse2c7YZEMQlr6puhX-zV864bM71yU"
local webhooktrans = "https://discordapp.com/api/webhooks/676604827085832214/gKzlinlog2nQkzvfQyLAO5aKflUgB7T8keuXYdbse2c7YZEMQlr6puhX-zV864bM71yU"
local webhookmultapaym = "https://discordapp.com/api/webhooks/676604827085832214/gKzlinlog2nQkzvfQyLAO5aKflUgB7T8keuXYdbse2c7YZEMQlr6puhX-zV864bM71yU"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end


RegisterServerEvent('bank:pagarmulta')
AddEventHandler('bank:pagarmulta', function()
  local source = source
  local user_id = vRP.getUserId(source)
  local valor = vRP.getUData(user_id,"vRP:multas")
  local identity = vRP.getUserIdentity(user_id)
  local int = parseInt(valor)
  if int <= 0 then TriggerClientEvent("Notify", source, "aviso","Voce nao tem multas pendentes") return end
  if vRP.tryFullPayment(user_id,int) then
    vRP.setUData(user_id,"vRP:multas",json.encode(0))
    local newvalor = vRP.getUData(user_id,"vRP:multas")
    local bank = vRP.getBankMoney(user_id)
    TriggerClientEvent("banking:updateBalance", source, bank, newvalor)
    TriggerClientEvent("banking:removeMulta", source, int)
    TriggerClientEvent("Notify", source, "sucesso","Voce pagou <b>$"..valor.." em multas </b>")
    TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
    SendWebhookMessage(webhookmultapaym,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[Pagou em Multa]: "..valor.." \n"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
  else
    TriggerClientEvent("Notify", source, "negado","Não tem esse dinheiro em sua conta!")
  end
end)
RegisterServerEvent('bank:deposit')
AddEventHandler('bank:deposit', function(amount)
  local source = source
  local user_id = vRP.getUserId(source)
  local identity = vRP.getUserIdentity(user_id)
  if user_id then
    if amount and type(amount) == "number" then
      local rounded = math.ceil(amount)
      if (rounded > 0) then
        local wallet = vRP.getMoney(user_id)
        local bankbalance = vRP.getBankMoney(user_id)
        if (rounded <= wallet) then
          Depositar(user_id, rounded)
          TriggerClientEvent("banking:updateBalance", source, (bankbalance + rounded))
          TriggerClientEvent("banking:addBalance", source, rounded)
          vRP.execute("sRP/inserir_table", {user_id = user_id, extrato = "Você depositou <strong>$"..addComma(math.floor(rounded)).."</strong>, e seu saldo ficou em <strong>$"..addComma(math.floor(bankbalance + rounded)).."</strong>"})
          TriggerClientEvent("Notify", source, "sucesso","Você acabou de depositar <b>$"..addComma(amount))
	        TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
          SendWebhookMessage(webhookdepositado1,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[Depositou]: "..amount.." \n"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
        else
          TriggerClientEvent("Notify", source, "negado","Não tem esse dinheiro em sua conta!")
        end
      end
    end
  end
end)

RegisterServerEvent('bank:withdraw')
AddEventHandler('bank:withdraw', function(amount)
  local source = source
  local user_id = vRP.getUserId(source)
  local identity = vRP.getUserIdentity(user_id)
  if user_id then
    if amount and type(amount) == "number" then
      local rounded = math.ceil(amount)
      local bankbalance = vRP.getBankMoney(user_id)
      if (rounded <= bankbalance) then
        -- Saca o Dinheiro
        local new_balance = bankbalance - math.abs(rounded)
        vRP.tryWithdraw(user_id,rounded)
        vRP.execute("sRP/inserir_table", {user_id = user_id, extrato = "Você fez um saque de <strong>$"..addComma(math.floor(rounded)).."</strong>, e seu saldo ficou em <strong>$" .. addComma(math.floor(bankbalance - rounded)) .. "</strong>"})
        -- Update NUI
        TriggerClientEvent("banking:updateBalance", source, new_balance)
        TriggerClientEvent("banking:removeBalance", source, rounded)
        -- Salva o extrato
        TriggerClientEvent("Notify", source, "sucesso","Você acabou de sacar <b>$"..addComma(amount))
        TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
        SendWebhookMessage(webhooksacar,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[Sacou]: "..amount.." \n"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
      else
        vRPclient._notify(source, "Não tem esse dinheiro em sua conta!")
        TriggerClientEvent("Notify", source, "negado","Não tem esse dinheiro em sua conta!")
      end

    end
  end
end)

RegisterServerEvent('bank:quickCash')
AddEventHandler('bank:quickCash', function()
  local source = source
  local user_id = vRP.getUserId(source)
  local source = vRP.getUserSource(user_id)
  local bankbalance = vRP.getBankMoney(user_id)
  local identity = vRP.getUserIdentity(user_id)
  local quantia = 1000
  if (bankbalance >= quantia) then
    local new_balance = bankbalance - math.abs(quantia)
    vRP.tryWithdraw(user_id,quantia)
    TriggerClientEvent("banking:updateBalance", source, new_balance)
    TriggerClientEvent("banking:removeBalance", source, quantia)
    TriggerClientEvent("Notify", source, "sucesso","Você acabou de sacar <b>$"..addComma(quantia))
    TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
    vRP.execute("sRP/inserir_table", {user_id = user_id, extrato = "Você fez um saque rapído de <strong>$" .. "1.000" .. "</strong>, e seu saldo ficou em <strong>$" .. addComma(bankbalance - 1000) .. "</strong>"})
      SendWebhookMessage(webhooksacar,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[Sacou]: "..quantia.." \n"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
  else
    TriggerClientEvent("Notify", source, "negado","Não tem esse dinheiro em sua conta!")
  end
end)

RegisterServerEvent('bank:transfer')
AddEventHandler('bank:transfer', function(toPlayer, amount)
  local source = source
  local user_id = vRP.getUserId(source)
  local nuser_id = tonumber(toPlayer)
  local identity = vRP.getUserIdentity(user_id)
  if user_id ~= nuser_id then
    if amount and type(amount) == "number" then
      local rounded = math.ceil(amount)
      if (rounded > 0) then
        local bankbalance = vRP.getBankMoney(user_id)
        if (rounded <= bankbalance) then
          local aleatorio = math.random(10000, 99999)
          -- user_id
          local newBalance = bankbalance - math.abs(rounded)
          -- nuser_id
          local player = vRP.getUserSource(nuser_id)
          local bank = vRP.getBankMoney(nuser_id)
          local newBalance_Player = bank + math.abs(amount)
          if player then -- Está online
            vRP.setBankMoney(user_id, newBalance)
            vRP.setBankMoney(nuser_id, newBalance_Player)
            -- Seta o dinheiro pro player
            TriggerClientEvent("banking:updateBalance", player, newBalance_Player)
            TriggerClientEvent("banking:addBalance", player, rounded)
          else
            local bank = vRP.scalar('sRP/get_dinheiro', {user_id = nuser_id})
            vRP.setBankMoney(user_id, newBalance)
            vRP.execute('sRP/set_banco', {user_id = nuser_id, bank = bank + tonumber(amount) })
          end
          -- Remove o dinheiro do player que enviou
          TriggerClientEvent("banking:updateBalance", source, newBalance)
          TriggerClientEvent("banking:removeBalance", source, rounded)
          -- Extrato
          vRP.execute("sRP/inserir_table", {user_id = user_id, extrato = "Você Transferiu <strong>$"..addComma(math.floor(rounded)).."</strong> para o ID: "..toPlayer..", e seu saldo ficou em <strong>$"..addComma(math.floor(bankbalance - rounded)).."</strong> comprovante <strong>NL"..aleatorio.."</strong>"})
          vRPclient._notify(source, "Você transferiu <b>$"..rounded.."</b> para o <b>ID: "..nuser_id.."</b>")
	        TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
          SendWebhookMessage(webhooktrans,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[Transferiu]: "..rounded.."\n [Para] "..nuser_id.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
        else
          vRPclient._notify(source, "Não tem esse dinheiro em sua conta!")
        end
      else
        vRPclient._notify(source, "Você não pode transferir esse valor!")
      end
    end
  else
    vRPclient._notify(source, "Impossivel transferir para você mesmo!")
  end
end)