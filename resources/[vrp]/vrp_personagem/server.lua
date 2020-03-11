-- vRP Tunnel/Proxy
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

-- Resource Tunnel/Proxy
vRPcr = {}
Tunnel.bindInterface("vrp_personagem",vRPcr)
Proxy.addInterface("vrp_personagem",vRPcr)
CRclient = Tunnel.getInterface("vrp_personagem")

RegisterNetEvent('skinCreator:criarIndentidade')
AddEventHandler('skinCreator:criarIndentidade', function(data, custom)
    local source = source
    local user_id = vRP.getUserId(source)
    if data then
        local nome = data.nome
        local foto = data.foto
        local sobrenome = data.sobrenome
        local idade = data.idade
        local registration = vRP.generateRegistrationNumber()
        local phone = vRP.generatePhoneNumber()
        vRP.setUData(user_id,"vRP:CriacaoDePersonagem",json.encode(os.date("%x")))
        vRP.setUData(user_id,"vRP:Customization", json.encode(custom))
        vRP.execute("vRP/update_user_identity", {
            ['user_id'] = user_id,
            ['age'] = idade,
            ['name'] = nome,
            ['firstname'] = sobrenome,
            ['carma'] = 0,
            ['phone'] = phone,
            ['registration'] = registration,
            ['foto'] = "http://painelcontabil.com.br/contador/painel/img/login.png"
        })
        vRPclient._teleport(source, -212.887, -1029.531, 30.140)
        vRPclient.setRegistrationNumber(source,registration)
    end
end)

AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
    if first_spawn then
        local user_id = vRP.getUserId(source)
        local data = vRP.getUData(user_id,"vRP:CriacaoDePersonagem")
		if not data then
            TriggerClientEvent('skinCreator:abrirCriacao', source)
        else
            local ldate = json.decode(data)
            if not ldate then
                TriggerClientEvent('skinCreator:abrirCriacao', source)
            end
        end
        local custom = vRP.getUData(user_id,"vRP:Customization")
        local lcustom = json.decode(custom)
        if custom then
            CRclient.setOverlay(source, lcustom)
        end
    end
end)