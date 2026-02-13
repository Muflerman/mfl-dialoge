fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'MFL Scripts'
description 'Modern NPC Dialogue System'
version '1.0.0'

client_scripts {
    'client/*.lua'
}

ui_page 'web/index.html'

files {
    'web/index.html',
    'web/style.css',
    'web/script.js'
}

shared_scripts {
    '@ox_lib/init.lua',
    'config/*.lua'
}
