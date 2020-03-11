local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPgc = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
Tunnel.bindInterface("gcPhone", vRPgc)

vRP._prepare("getNumberPhone",
             "SELECT vrp_user_identities.phone FROM vrp_user_identities WHERE vrp_user_identities.user_id = @identifier")
vRP._prepare("getIdentifierByPhoneNumber",
             "SELECT vrp_user_identities.user_id FROM vrp_user_identities WHERE vrp_user_identities.phone = @phone_number")
vRP._prepare("getOrGeneratePhoneNumber",
             "UPDATE vrp_user_identities SET phone = @myPhoneNumber WHERE user_id = @identifier")
vRP._prepare("getContacts",
             "SELECT * FROM phone_users_contacts WHERE phone_users_contacts.identifier = @identifier")
math.randomseed(os.time())

--- Pour les numero du style Xxxx-XXXX
function getPhoneRandomNumber()
    local numBase0 = math.random(100, 999)
    local numBase1 = math.random(1000, 9999)
    local num = string.format("%03d-%04d", numBase0, numBase1)
    return num
end

function vRPgc.possuiPhone()
    local source = source
    local user_id = vRP.getUserId(source)
    return vRP.getInventoryItemAmount(user_id, "celular") >= 1
end

function getNumberPhone(identifier)

    local result = vRP.query("getNumberPhone", {identifier = identifier})
    if result[1] ~= nil then return result[1].phone end
    return nil
end
function getIdentifierByPhoneNumber(phone_number)
    local result = vRP.query("getIdentifierByPhoneNumber",
                             {phone_number = phone_number})

    if result[1] ~= nil then return result[1].user_id end
    return nil
end

function getPlayerID(source)
    local player = vRP.getUserId(source)
    return player
end

function getIdentifiant(id) for _, v in ipairs(id) do return v end end

function getOrGeneratePhoneNumber(sourcePlayer, identifier, cb)
    local sourcePlayer = sourcePlayer
    local identifier = identifier
    local myPhoneNumber = getNumberPhone(identifier)
    if myPhoneNumber == '0' or myPhoneNumber == nil then
        repeat
            myPhoneNumber = getPhoneRandomNumber()
            local id = getIdentifierByPhoneNumber(myPhoneNumber)
        until id == nil
        vRP.execute("getOrGeneratePhoneNumber",
                    {myPhoneNumber = myPhoneNumber, identifier = identifier})
        cb(myPhoneNumber)
    else
        cb(myPhoneNumber)
    end
end
-- ====================================================================================
--  Contacts
-- ====================================================================================
function getContacts(identifier)
    local result = vRP.query("getContacts", {identifier = identifier})
    return result
end

vRP._prepare("addContact",
             "INSERT INTO phone_users_contacts (`identifier`, `number`,`display`) VALUES(@identifier, @number, @display)")
function addContact(source, identifier, number, display)
    local sourcePlayer = tonumber(source)
    vRP.execute("addContact",
                {identifier = identifier, number = number, display = display})
    notifyContactChange(sourcePlayer, identifier)
end

vRP._prepare("updateContact",
             "UPDATE phone_users_contacts SET number = @number, display = @display WHERE id = @id")
function updateContact(source, identifier, id, number, display)
    local sourcePlayer = tonumber(source)
    vRP.execute("updateContact", {number = number, display = display, id = id})
    notifyContactChange(sourcePlayer, identifier)
end

vRP._prepare("deleteContact",
             "DELETE FROM phone_users_contacts WHERE `identifier` = @identifier AND `id` = @id")
function deleteContact(source, identifier, id)
    local sourcePlayer = tonumber(source)
    vRP.execute("deleteContact", {identifier = identifier, id = id})
    notifyContactChange(sourcePlayer, identifier)
end

vRP._prepare("deleteAllContact",
             "DELETE FROM phone_users_contacts WHERE `identifier` = @identifier")
function deleteAllContact(identifier)
    vRP.execute("deleteAllContact", {identifier = identifier})
end

function notifyContactChange(source, identifier)
    local sourcePlayer = tonumber(source)
    local identifier = identifier
    if sourcePlayer ~= nil then
        TriggerClientEvent("gcPhone:contactList", sourcePlayer,
                           getContacts(identifier))
    end
end

RegisterServerEvent('gcPhone:addContact')
AddEventHandler('gcPhone:addContact', function(display, phoneNumber)
    local sourcePlayer = tonumber(source)
    local identifier = getPlayerID(source)
    addContact(sourcePlayer, identifier, phoneNumber, display)
end)

RegisterServerEvent('gcPhone:updateContact')
AddEventHandler('gcPhone:updateContact', function(id, display, phoneNumber)
    local sourcePlayer = tonumber(source)
    local identifier = getPlayerID(source)
    updateContact(sourcePlayer, identifier, id, phoneNumber, display)
end)

RegisterServerEvent('gcPhone:deleteContact')
AddEventHandler('gcPhone:deleteContact', function(id)
    local sourcePlayer = tonumber(source)
    local identifier = getPlayerID(source)
    deleteContact(sourcePlayer, identifier, id)
end)

-- ====================================================================================
--  Messages
-- ====================================================================================
vRP._prepare("getMessages",
             "SELECT phone_messages.* FROM phone_messages LEFT JOIN vrp_user_identities ON vrp_user_identities.user_id = @identifier WHERE phone_messages.receiver = vrp_user_identities.phone")
function getMessages(identifier)
    local result = vRP.query("getMessages", {identifier = identifier})
    return result
end

RegisterServerEvent('gcPhone:_internalAddMessage')
AddEventHandler('gcPhone:_internalAddMessage',
                function(transmitter, receiver, message, owner, cb)
    cb(_internalAddMessage(transmitter, receiver, message, owner))
end)

vRP._prepare("internalAddMessage",
             "INSERT INTO phone_messages (`transmitter`, `receiver`,`message`, `isRead`,`owner`) VALUES(@transmitter, @receiver, @message, @isRead, @owner); SELECT * from phone_messages WHERE `id` = (SELECT LAST_INSERT_ID());")
function _internalAddMessage(transmitter, receiver, message, owner)
    local query = vRP.query("internalAddMessage", {
        transmitter = transmitter,
        receiver = receiver,
        message = message,
        isRead = owner,
        owner = owner
    })
    return query[1]
end

function addMessage(source, identifier, phone_number, message)
    local sourcePlayer = tonumber(source)
    local otherIdentifier = getIdentifierByPhoneNumber(phone_number)
    local myPhone = getNumberPhone(identifier)
    if otherIdentifier ~= nil and vRP.getUserSource(otherIdentifier) ~= nil then
        local tomess = _internalAddMessage(myPhone, phone_number, message, 0)
        --        getSourceFromIdentifier(otherIdentifier, function (osou)
        --          if tonumber(osou) ~= nil then 
        -- TriggerClientEvent("gcPhone:allMessage", osou, getMessages(otherIdentifier))
        TriggerClientEvent("gcPhone:receiveMessage",
                           tonumber(vRP.getUserSource(otherIdentifier)), tomess)
        --        end
        --    end) 
    end
    local memess = _internalAddMessage(phone_number, myPhone, message, 1)
    TriggerClientEvent("gcPhone:receiveMessage", sourcePlayer, memess)
end

vRP._prepare("setReadMessageNumber",
             "UPDATE phone_messages SET phone_messages.isRead = 1 WHERE phone_messages.receiver = @receiver AND phone_messages.transmitter = @transmitter")
function setReadMessageNumber(identifier, num)
    local mePhoneNumber = getNumberPhone(identifier)
    vRP.execute("setReadMessageNumber",
                {receiver = mePhoneNumber, transmitter = num})
end

vRP._prepare("deleteMessage", "DELETE FROM phone_messages WHERE `id` = @id")
function deleteMessage(msgId) vRP.execute("deleteMessage", {id = msgId}) end

vRP._prepare("deleteAllMessageFromPhoneNumber",
             "DELETE FROM phone_messages WHERE `receiver` = @mePhoneNumber and `transmitter` = @phone_number")
function deleteAllMessageFromPhoneNumber(source, identifier, phone_number)
    local source = source
    local identifier = identifier
    local mePhoneNumber = getNumberPhone(identifier)
    vRP.execute("deleteAllMessageFromPhoneNumber",
                {mePhoneNumber = mePhoneNumber, phone_number = phone_number})
end

vRP._prepare("deleteAllMessage",
             "DELETE FROM phone_messages WHERE `receiver` = @mePhoneNumber")
function deleteAllMessage(identifier)
    local mePhoneNumber = getNumberPhone(identifier)
    vRP.execute("deleteAllMessage", {mePhoneNumber = mePhoneNumber})

end

RegisterServerEvent('gcPhone:sendMessage')
AddEventHandler('gcPhone:sendMessage', function(phoneNumber, message)
    local sourcePlayer = tonumber(source)
    local identifier = getPlayerID(source)
    addMessage(sourcePlayer, identifier, phoneNumber, message)
end)

RegisterServerEvent('gcPhone:deleteMessage')
AddEventHandler('gcPhone:deleteMessage',
                function(msgId) deleteMessage(msgId) end)

RegisterServerEvent('gcPhone:deleteMessageNumber')
AddEventHandler('gcPhone:deleteMessageNumber', function(number)
    local sourcePlayer = tonumber(source)
    local identifier = getPlayerID(source)
    deleteAllMessageFromPhoneNumber(sourcePlayer, identifier, number)
    -- TriggerClientEvent("gcphone:allMessage", sourcePlayer, getMessages(identifier))
end)

RegisterServerEvent('gcPhone:deleteAllMessage')
AddEventHandler('gcPhone:deleteAllMessage', function()
    local sourcePlayer = tonumber(source)
    local identifier = getPlayerID(source)
    deleteAllMessage(identifier)
end)

RegisterServerEvent('gcPhone:setReadMessageNumber')
AddEventHandler('gcPhone:setReadMessageNumber', function(num)
    local sourcePlayer = tonumber(source)
    local identifier = getPlayerID(source)
    setReadMessageNumber(identifier, num)
end)

RegisterServerEvent('gcPhone:deleteALL')
AddEventHandler('gcPhone:deleteALL', function()
    local sourcePlayer = tonumber(source)
    local identifier = getPlayerID(source)
    deleteAllMessage(identifier)
    deleteAllContact(identifier)
    appelsDeleteAllHistorique(identifier)
    TriggerClientEvent("gcPhone:contactList", sourcePlayer, {})
    TriggerClientEvent("gcPhone:allMessage", sourcePlayer, {})
    TriggerClientEvent("appelsDeleteAllHistorique", sourcePlayer, {})
end)

-- ====================================================================================
--  Gestion des appels
-- ====================================================================================
local AppelsEnCours = {}
local PhoneFixeInfo = {}
local lastIndexCall = 10

vRP._prepare("getHistoriqueCall",
             "SELECT * FROM phone_calls WHERE phone_calls.owner = @num ORDER BY time DESC LIMIT 120")
function getHistoriqueCall(num)
    local result = vRP.query("getHistoriqueCall", {num = num})
    return result
end

function sendHistoriqueCall(src, num)
    local histo = getHistoriqueCall(num)
    TriggerClientEvent('gcPhone:historiqueCall', src, histo)
end

vRP._prepare("saveAppels",
             "INSERT INTO phone_calls (`owner`, `num`,`incoming`, `accepts`) VALUES(@owner, @num, @incoming, @accepts)")
function saveAppels(appelInfo)
    if appelInfo.extraData == nil or appelInfo.extraData.useNumber == nil then
        vRP.execute("saveAppels", {
            owner = appelInfo.transmitter_num,
            num = appelInfo.receiver_num,
            incoming = 1,
            accepts = appelInfo.is_accepts
        })
        notifyNewAppelsHisto(appelInfo.transmitter_src,
                             appelInfo.transmitter_num)
    end
    if appelInfo.is_valid == true then
        local num = appelInfo.transmitter_num
        if appelInfo.hidden == true then mun = "###-####" end
        vRP.execute("saveAppels", {
            owner = appelInfo.receiver_num,
            num = num,
            incoming = 0,
            accepts = appelInfo.is_accepts
        })
        if appelInfo.receiver_src ~= nil then
            notifyNewAppelsHisto(appelInfo.receiver_src, appelInfo.receiver_num)
        end
    end
end

function notifyNewAppelsHisto(src, num) sendHistoriqueCall(src, num) end

RegisterServerEvent('gcPhone:getHistoriqueCall')
AddEventHandler('gcPhone:getHistoriqueCall', function()
    local sourcePlayer = tonumber(source)
    local srcIdentifier = getPlayerID(source)
    local srcPhone = getNumberPhone(srcIdentifier)
    sendHistoriqueCall(sourcePlayer, num)
end)

RegisterServerEvent('gcPhone:internal_startCall')
AddEventHandler('gcPhone:internal_startCall',
                function(source, phone_number, rtcOffer, extraData)
    if FixePhone[phone_number] ~= nil then
        onCallFixePhone(source, phone_number, rtcOffer, extraData)
        return
    end

    local rtcOffer = rtcOffer
    if phone_number == nil or phone_number == '' then
        print('BAD CALL NUMBER IS NIL')
        return
    end

    local hidden = string.sub(phone_number, 1, 1) == '#'
    if hidden == true then phone_number = string.sub(phone_number, 2) end

    local indexCall = lastIndexCall
    lastIndexCall = lastIndexCall + 1

    local sourcePlayer = tonumber(source)
    local srcIdentifier = getPlayerID(source)

    local srcPhone = ''
    -- print(json.encode(extraData))
    if extraData ~= nil and extraData.useNumber ~= nil then
        srcPhone = extraData.useNumber
    else
        srcPhone = getNumberPhone(srcIdentifier)
    end

    local destPlayer = getIdentifierByPhoneNumber(phone_number)
    local is_valid = destPlayer ~= nil and destPlayer ~= srcIdentifier
    AppelsEnCours[indexCall] = {
        id = indexCall,
        transmitter_src = sourcePlayer,
        transmitter_num = srcPhone,
        receiver_src = nil,
        receiver_num = phone_number,
        is_valid = destPlayer ~= nil,
        is_accepts = false,
        hidden = hidden,
        rtcOffer = rtcOffer,
        extraData = extraData
    }

    if vRP.getInventoryItemAmount(destPlayer, "celular") > 0 then
        if is_valid == true then
            -- getSourceFromIdentifier(destPlayer, function (srcTo)
            if vRP.getUserSource(destPlayer) ~= nil then
                srcTo = tonumber(vRP.getUserSource(destPlayer))

                if srcTo ~= nil then
                    AppelsEnCours[indexCall].receiver_src = srcTo
                    -- TriggerEvent('gcPhone:addCall', AppelsEnCours[indexCall])
                    TriggerClientEvent('gcPhone:waitingCall', sourcePlayer,
                                       AppelsEnCours[indexCall], true)
                    TriggerClientEvent('gcPhone:waitingCall', srcTo,
                                       AppelsEnCours[indexCall], false)
                else
                    -- TriggerEvent('gcPhone:addCall', AppelsEnCours[indexCall])
                    TriggerClientEvent('gcPhone:waitingCall', sourcePlayer,
                                       AppelsEnCours[indexCall], true)
                end

            end
        else
            TriggerEvent('gcPhone:addCall', AppelsEnCours[indexCall])
            TriggerClientEvent('gcPhone:waitingCall', sourcePlayer,
                               AppelsEnCours[indexCall], true)
        end
    else
        TriggerClientEvent("Notify", source, "aviso",
                           "Usuário está sem celular no momento!")
    end

end)

RegisterServerEvent('gcPhone:startCall')
AddEventHandler('gcPhone:startCall', function(phone_number, rtcOffer, extraData)
    TriggerEvent('gcPhone:internal_startCall', source, phone_number, rtcOffer,
                 extraData)
end)

RegisterServerEvent('gcPhone:candidates')
AddEventHandler('gcPhone:candidates', function(callId, candidates)
    -- print('send cadidate', callId, candidates)
    if AppelsEnCours[callId] ~= nil then
        local source = source
        local to = AppelsEnCours[callId].transmitter_src
        if source == to then to = AppelsEnCours[callId].receiver_src end
        -- print('TO', to)
        TriggerClientEvent('gcPhone:candidates', to, candidates)
    end
end)

RegisterServerEvent('gcPhone:acceptCall')
AddEventHandler('gcPhone:acceptCall', function(infoCall, rtcAnswer)
    local id = infoCall.id
    if AppelsEnCours[id] ~= nil then
        if PhoneFixeInfo[id] ~= nil then
            onAcceptFixePhone(source, infoCall, rtcAnswer)
            return
        end
        AppelsEnCours[id].receiver_src =
            infoCall.receiver_src or AppelsEnCours[id].receiver_src
        if AppelsEnCours[id].transmitter_src ~= nil and
            AppelsEnCours[id].receiver_src ~= nil then
            AppelsEnCours[id].is_accepts = true
            AppelsEnCours[id].rtcAnswer = rtcAnswer
            TriggerClientEvent('gcPhone:acceptCall',
                               AppelsEnCours[id].transmitter_src,
                               AppelsEnCours[id], true)
            TriggerClientEvent('gcPhone:acceptCall',
                               AppelsEnCours[id].receiver_src,
                               AppelsEnCours[id], false)
            saveAppels(AppelsEnCours[id])
        end
    end
end)

RegisterServerEvent('gcPhone:rejectCall')
AddEventHandler('gcPhone:rejectCall', function(infoCall)
    local id = infoCall.id
    if AppelsEnCours[id] ~= nil then
        if PhoneFixeInfo[id] ~= nil then
            onRejectFixePhone(source, infoCall)
            return
        end
        if AppelsEnCours[id].transmitter_src ~= nil then
            TriggerClientEvent('gcPhone:rejectCall',
                               AppelsEnCours[id].transmitter_src)
        end
        if AppelsEnCours[id].receiver_src ~= nil then
            TriggerClientEvent('gcPhone:rejectCall',
                               AppelsEnCours[id].receiver_src)
        end

        if AppelsEnCours[id].is_accepts == false then
            saveAppels(AppelsEnCours[id])
        end
        TriggerEvent('gcPhone:removeCall', AppelsEnCours)
        AppelsEnCours[id] = nil
    end
end)

vRP._prepare("appelsDeleteHistorique",
             "DELETE FROM phone_calls WHERE `owner` = @owner AND `num` = @num")
RegisterServerEvent('gcPhone:appelsDeleteHistorique')
AddEventHandler('gcPhone:appelsDeleteHistorique', function(numero)
    local sourcePlayer = tonumber(source)
    local srcIdentifier = getPlayerID(source)
    local srcPhone = getNumberPhone(srcIdentifier)
    vRP.execute("appelsDeleteHistorique", {owner = srcPhone, num = numero})
end)

vRP._prepare("appelsDeleteAllHistorique",
             "DELETE FROM phone_calls WHERE `owner` = @owner")
function appelsDeleteAllHistorique(srcIdentifier)
    local srcPhone = getNumberPhone(srcIdentifier)
    vRP.execute("appelsDeleteAllHistorique", {owner = srcPhone})
end

RegisterServerEvent('gcPhone:appelsDeleteAllHistorique')
AddEventHandler('gcPhone:appelsDeleteAllHistorique', function()
    local sourcePlayer = tonumber(source)
    local srcIdentifier = getPlayerID(source)
    appelsDeleteAllHistorique(srcIdentifier)
end)

-- ====================================================================================
--  OnLoad
-- ====================================================================================
AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
    local sourcePlayer = tonumber(source)
    local identifier = getPlayerID(source)
    getOrGeneratePhoneNumber(sourcePlayer, identifier, function(myPhoneNumber)
        TriggerClientEvent("gcPhone:myPhoneNumber", sourcePlayer, myPhoneNumber)
        TriggerClientEvent("gcPhone:contactList", sourcePlayer,
                           getContacts(identifier))
        TriggerClientEvent('vrp:displayBank', sourcePlayer,
                           vRP.getBankMoney(user_id))
        TriggerClientEvent("gcPhone:allMessage", sourcePlayer,
                           getMessages(identifier))
    end)
end)

-- Just For reload
RegisterServerEvent('gcPhone:allUpdate')
AddEventHandler('gcPhone:allUpdate', function()
    local sourcePlayer = tonumber(source)
    local identifier = getPlayerID(source)
    local num = getNumberPhone(identifier)
    TriggerClientEvent("gcPhone:myPhoneNumber", sourcePlayer, num)
    TriggerClientEvent("gcPhone:contactList", sourcePlayer,
                       getContacts(identifier))
    TriggerClientEvent("gcPhone:allMessage", sourcePlayer,
                       getMessages(identifier))
    TriggerClientEvent('vrp:displayBank', sourcePlayer,
                        vRP.getBankMoney(user_id))
    TriggerClientEvent('gcPhone:getBourse', sourcePlayer, getBourse())
    sendHistoriqueCall(sourcePlayer, num)
end)

vRP._prepare("onServerResourceStart",
             "DELETE FROM phone_messages WHERE (DATEDIFF(CURRENT_DATE,time) > 10)")
AddEventHandler('onServerResourceStart',
                function(resource) vRP.execute("onServerResourceStart", {}) end)

-- ====================================================================================
--  App bourse
-- ====================================================================================
function getBourse()
    --  Format
    --  Array 
    --    Object
    --      -- libelle type String    | Nom
    --      -- price type number      | Prix actuelle
    --      -- difference type number | Evolution 
    -- 
    -- local result = MySQL.Sync.fetchAll("SELECT * FROM `recolt` LEFT JOIN `items` ON items.`id` = recolt.`treated_id` WHERE fluctuation = 1 ORDER BY price DESC",{})
    local result = {
        {libelle = 'Google', price = 125.2, difference = -12.1},
        {libelle = 'Microsoft', price = 132.2, difference = 3.1},
        {libelle = 'Amazon', price = 120, difference = 0}
    }
    return result
end
-- ====================================================================================
--  App ... WIP
-- ====================================================================================

-- SendNUIMessage('ongcPhoneRTC_receive_offer')
-- SendNUIMessage('ongcPhoneRTC_receive_answer')

-- RegisterNUICallback('gcPhoneRTC_send_offer', function (data)

-- end)

-- RegisterNUICallback('gcPhoneRTC_send_answer', function (data)

-- end)

function onCallFixePhone(source, phone_number, rtcOffer, extraData)
    local indexCall = lastIndexCall
    lastIndexCall = lastIndexCall + 1

    local hidden = string.sub(phone_number, 1, 1) == '#'
    if hidden == true then phone_number = string.sub(phone_number, 2) end
    local sourcePlayer = tonumber(source)
    local srcIdentifier = getPlayerID(source)

    local srcPhone = ''
    if extraData ~= nil and extraData.useNumber ~= nil then
        srcPhone = extraData.useNumber
    else
        srcPhone = getNumberPhone(srcIdentifier)
    end

    AppelsEnCours[indexCall] = {
        id = indexCall,
        transmitter_src = sourcePlayer,
        transmitter_num = srcPhone,
        receiver_src = nil,
        receiver_num = phone_number,
        is_valid = false,
        is_accepts = false,
        hidden = hidden,
        rtcOffer = rtcOffer,
        extraData = extraData,
        coords = FixePhone[phone_number].coords
    }

    PhoneFixeInfo[indexCall] = AppelsEnCours[indexCall]

    TriggerClientEvent('gcPhone:notifyFixePhoneChange', -1, PhoneFixeInfo)
    TriggerClientEvent('gcPhone:waitingCall', sourcePlayer,
                       AppelsEnCours[indexCall], true)
end

function onAcceptFixePhone(source, infoCall, rtcAnswer)
    local id = infoCall.id

    AppelsEnCours[id].receiver_src = source
    if AppelsEnCours[id].transmitter_src ~= nil and
        AppelsEnCours[id].receiver_src ~= nil then
        AppelsEnCours[id].is_accepts = true
        AppelsEnCours[id].forceSaveAfter = true
        AppelsEnCours[id].rtcAnswer = rtcAnswer
        PhoneFixeInfo[id] = nil
        TriggerClientEvent('gcPhone:notifyFixePhoneChange', -1, PhoneFixeInfo)
        TriggerClientEvent('gcPhone:acceptCall',
                           AppelsEnCours[id].transmitter_src, AppelsEnCours[id],
                           true)
        TriggerClientEvent('gcPhone:acceptCall', AppelsEnCours[id].receiver_src,
                           AppelsEnCours[id], false)
        saveAppels(AppelsEnCours[id])
    end
end

function onRejectFixePhone(source, infoCall, rtcAnswer)
    local id = infoCall.id
    PhoneFixeInfo[id] = nil
    TriggerClientEvent('gcPhone:notifyFixePhoneChange', -1, PhoneFixeInfo)
    TriggerClientEvent('gcPhone:rejectCall', AppelsEnCours[id].transmitter_src)
    if AppelsEnCours[id].is_accepts == false then
        saveAppels(AppelsEnCours[id])
    end
    AppelsEnCours[id] = nil

end
