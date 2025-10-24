-- LeaveEngineRunning
-- FXManifest for networked engine and lights, localisation, and optimisations

fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'FAXES & Contributors'
description 'Leave Engine Running - now networked with lights and localisation support'
version '2.0.0'

-- Client scripts
client_scripts {
    'config.lua',
    'locales/*.lua',
    'client.lua'
}

-- Server scripts
server_scripts {
    'server.lua'
}

-- This resource uses exported locales and optional localisation files
-- No UI page is required for this resource
