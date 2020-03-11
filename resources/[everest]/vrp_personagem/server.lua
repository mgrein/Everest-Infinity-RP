local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local Tools = module("vrp", "lib/Tools")

vRPclient = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")


func = {}
Tunnel.bindInterface("vrp_personagem", func)

funcCliente = Tunnel.getInterface("vrp_personagem")