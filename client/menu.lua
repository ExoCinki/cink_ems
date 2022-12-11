ESX = exports['es_extended']:getSharedObject()


CreateThread(function()

    while ESX.GetPlayerData().job == nil do
		Wait(10)
    end

    if ESX.IsPlayerLoaded() then
		ESX.PlayerData = ESX.GetPlayerData()
    end

end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)


lib.registerContext({
    id = 'menu_ems_job_f6',
    title = 'Menu EMS',
    options = {
        {
            title = 'Annonces à la ville',
            menu = 'menu_ems_job_f6_annonce',
        },
        {
            title = 'Interactions avec les patients',
            menu = 'menu_ems_job_f6_interactions',
        },
        {title = 'Radio EMS : 912 || Radio EMS & LSPD : 913'},

    },
    {
        id = 'menu_ems_job_f6_annonce',
        title = 'Menu EMS Annonces',
        menu = 'menu_ems_job_f6',
        options = {
            {
                title = 'Prise de Service',
                description = 'Annonce a la ville que vous êtes en service',
                onSelect = function()
                  print('Pressed the button!')
                end,
            },
            {
                title = 'Fin de Service',
                description = 'Annonce a la ville que vous n\'êtes plus en service',
                onSelect = function()
                  print('Pressed the button!')
                end,
            },
        }
    },
    {
        id = 'menu_ems_job_f6_interactions',
        title = 'Menu EMS Intéractions',
        menu = 'menu_ems_job_f6',
        options = {
            {
                title = 'Porter la personnes / Poser la personnes',
                description = 'Vous permet de porter ou de poser la personne',
                onSelect = function()
                  print('Pressed the button!')
                end,
            },
            {
                title = 'Mettre / Retirer du véhicule',
                description = 'Vous permet de mettre ou retirer la personnes du véhicule',
                onSelect = function()
                  print('Pressed the button!')
                end,
            },
        }
    }
})


