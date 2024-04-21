fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'Makeyeff'
description 'qb-core hunting'
version '1.0.1'

shared_scripts {
    '@qb-core/shared/locale.lua',
    'locales/en.lua', -- Change to the language you want to use
    'config.lua'
}

client_script 'client/main.lua'
server_script 'server/main.lua'
