fx_version 'cerulean'
game 'gta5'
author 'atiysu'
lua54 'yes'

shared_script 'config/config.lua'
client_script 'client/client.lua'
server_scripts {'server/server.lua', 'config/discord.lua'}

ui_page 'ui/index.html'

files {
    'ui/*.*',
    'ui/**/*.*',
}

escrow_ignore {
    'client/client.lua',
    'server/server.lua',
    'config/config.lua',
    'config/discord.lua'
}
dependency '/assetpacks'