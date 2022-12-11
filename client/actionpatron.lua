local ox_target = exports.ox_target


local OptionsActionPatron = {
    coords = vec3(Config.ActionPatronEms.x, Config.ActionPatronEms.y, Config.ActionPatronEms.z),
    size = vec3(2, 2, 2),
    rotation = Config.ActionPatronEms.w,
    debug = false,
    options = {
        {
            name = 'ActionsPatronEms',
            event = 'cink:ems:openMenuPatron',
            icon = 'fa-solid fa-users-cog',
            label = 'Actions Patron',
            groups = {["ambulance"] = 5},
            canInteract = function(entity, distance, coords, name)
                if distance < 2 then
                    return true
                end
                return false
            end
        }
    }
}

ox_target:addBoxZone(OptionsActionPatron)

lib.registerContext({
    id = 'actionpatronems',
    title = 'Menu Patron',
    options = {
        {
            title = 'Gestion Comptes',
            menu = 'gestioncomptesems',
            description = 'Dépôt, Retrait',
        },
        {
            title = 'Gestion Employer',
            menu = 'gestionemployerems',
            description = 'Recruter, Promotion, Licenciement',
        },
    },
    {
        id = 'gestionemployerems',
        title = 'Gestion Employer',
        menu = 'actionpatronems',
        options = {
            {
                title = 'Recruter un employer',
                onSelect = function()
                  local Target = ClosePlayerForGestionEmployees()
                    if Target ~= nil then
                        TriggerServerEvent('cink:GestionEmployerPatronEms', 'recruter', Target)
                    else 
                        exports['okokNotify']:Alert('Gestion Employer', 'Aucun employé à proximité', 5000, 'error')
                    end
                end,
            },
            {
                title = 'Promouvoir un employer',
                onSelect = function()
                    local Target = ClosePlayerForGestionEmployees()
                    if Target ~= nil then
                        TriggerServerEvent('cink:GestionEmployerPatronEms', 'promouvoir', Target)
                    else 
                        exports['okokNotify']:Alert('Gestion Employer', 'Aucun employé à proximité', 5000, 'error')
                    end
                end,
            },
            {
                title = 'Licencier un employer',
                onSelect = function()
                    local Target = ClosePlayerForGestionEmployees()
                    if Target ~= nil then
                        TriggerServerEvent('cink:GestionEmployerPatronEms', 'virer', Target)
                    else 
                        exports['okokNotify']:Alert('Gestion Employer', 'Aucun employé à proximité', 5000, 'error')
                    end
                end,
            },

        }
    },
    {
        id = 'gestioncomptesems',
        title = 'Gestion Comptes',
        menu = 'actionpatronems',
        options = {
            {
                title = 'Dépôt d\'argent',
                onSelect = function()
                    local amount = InputGestionComptePatron()
                    if amount ~= nil  and amount > 0 then 
                    TriggerServerEvent('cink:GestionCompteEms', 'depot', amount)
                    end
                end,
            },
            {
                title = 'Retrait d\'argent',
                onSelect = function()
                    local amount = InputGestionComptePatron()
                    if amount ~= nil  and amount > 0 then 
                    TriggerServerEvent('cink:GestionCompteEms', 'retrait', amount)
                    end
                end,
            },
        }
    }
})


AddEventHandler('cink:ems:openMenuPatron', function()
    TriggerEvent('esx_society:openBossMenu', 'ambulance', function (data, menu)
        menu.close()
    end, {wash = false})
end)