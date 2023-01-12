author "helmimarif"
description "Car Wash for Ayseframework"
version "1.0"

fx_version "cerulean"
game "gta5"
lua54 "yes"

shared_scripts {
    "@ox_lib/init.lua",
    "config.lua"
}
client_scripts {
    "@PolyZone/client.lua",
    "@PolyZone/BoxZone.lua",
    "@PolyZone/EntityZone.lua",
    "@PolyZone/CircleZone.lua",
    "@PolyZone/ComboZone.lua",
	"client.lua"
}
server_script "server.lua"

dependencies {
    "Ayse_Core",
    "ox_lib",
    "PolyZone"
}
