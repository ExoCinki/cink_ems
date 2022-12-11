fx_version 'cerulean'

lua54        'yes'
game         'gta5'

description 'EMS By Cink'

version '1.0.0'

shared_scripts {
  '@ox_lib/init.lua',
  '@es_extended/imports.lua',
}

client_scripts {
  'config.lua',
  'client/function.lua',
  'client/client.lua',
  'client/ascenseur.lua',
  'client/sonnette.lua',
  'client/actionpatron.lua',
  'client/psy.lua',
  'client/menu.lua'
}

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'config.lua',
  'server/server.lua'
}

ui_page "web/index.html"

files {
  'web/index.html',
  'web/script.js',
  'web/style.css',
  'web/img/*.png',
}