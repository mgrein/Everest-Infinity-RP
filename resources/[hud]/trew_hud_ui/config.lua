local Config = {}

Config.Locale = 'en'

Config.serverLogo = 'img/logo.png'

Config.font = {
    name = 'Montserrat',
    url = 'https://fonts.googleapis.com/css?family=Montserrat:300,400,700,900&display=swap'
}

Config.date = {format = 'simpleWithHours', AmPm = false}

Config.voice = {

    levels = {default = 5.0, shout = 12.0, whisper = 1.0, current = 0},

    keys = {distance = 'HOME'}
}

Config.vehicle = {
    speedUnit = 'MP/H',
    -- speedUnit = 'KM/H',
    maxSpeed = 170,

    keys = {
        seatbelt = 'G',
        cruiser = 'F5',
        signalLeft = '-',
        signalRight = '+',
        signalBoth = '/'
    }
}
Config.ui = {
    showServerLogo = true,

    showJob = false,

    showWalletMoney = false,
    showBankMoney = false,
    showBlackMoney = false,

    showDate = true,
    showLocation = true,
    showVoice = true,

    showHealth = true,
    showArmor = true,
    showStamina = true,
    showHunger = true,
    showThirst = true,

    showMinimap = false,

    showWeapons = true

}

Config.vRP = {items = {blackMoney = 'dinheirosujo'}}

return Config
