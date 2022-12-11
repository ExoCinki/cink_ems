

AddEventHandler('cink:EmsAscenseur', function(data)
    local playerPed = cache.ped
    if data.etage == 'sous-sol' then 
        SetEntityCoords(playerPed, -664.1840, 328.0381, 78.1227, true, false, false, false)
        SetEntityHeading(playerPed, 1.7396)
    end
    if data.etage == 'rdc' then 
        SetEntityCoords(playerPed, -664.2035, 328.2820, 83.0832, true, false, false, false)
        SetEntityHeading(playerPed, 1.7396)
    end
    if data.etage == 'soinsintensifs' then 
        SetEntityCoords(playerPed, -664.1622, 328.2498, 88.0187, true, false, false, false) 
        SetEntityHeading(playerPed, 1.7396)
    end
    if data.etage == 'administration' then 
        SetEntityCoords(playerPed, -664.1171, 327.9830, 92.7449, true, false, false, false)
        SetEntityHeading(playerPed, 1.7396)
    end
    if data.etage == 'helico' then 
        SetEntityCoords(playerPed, -664.1232, 328.0567, 140.1232, true, false, false, false)
        SetEntityHeading(playerPed, 1.7396) 
    end
end)



    exports.ox_target:addBoxZone({
        coords = vector3(-664.1840, 328.0381, 78.1227),
        size = vector3(9, 1, 3),
        rotation = 174.8,
        debug = false,
        options = {
            {
                name = 'helico',
                event = 'cink:EmsAscenseur',
                icon = 'fas fa-walking',
                label = 'Toit - Hélicoptère',
                etage = 'helico',
                canInteract = function(entity, distance, coords, name)
                    if distance < 3 then
                            return true
                    end
                    return false
                end
            },
            {
                name = 'administration',
                event = 'cink:EmsAscenseur',
                icon = 'fas fa-walking',
                label = '2eme étage - Administration',
                etage = 'administration',
                canInteract = function(entity, distance, coords, name)
                    if distance < 3 then
                            return true
                    end
                    return false
                end
            },
            {
                name = 'soinsintensifs',
                event = 'cink:EmsAscenseur',
                icon = 'fas fa-walking',
                label = '1er étage - Soins Intensifs',
                etage = 'soinsintensifs',
                canInteract = function(entity, distance, coords, name)
                    if distance < 3 then
                            return true
                    end
                    return false
                end
            },
            {
                name = 'rdc',
                event = 'cink:EmsAscenseur',
                icon = 'fas fa-walking',
                label = 'Accueil - Récéption',
                etage = 'rdc',
                canInteract = function(entity, distance, coords, name)
                    if distance < 3 then
                            return true
                    end
                    return false
                end
            },
            {
                name = 'sous-sol',
                event = 'cink:EmsAscenseur',
                icon = 'fas fa-walking',
                label = 'Parking - Garage',
                etage = 'sous-sol',
                canInteract = function(entity, distance, coords, name)
                    if distance < 3 then
                            return true
                    end
                    return false
                end
            }
        }
    })

    exports.ox_target:addBoxZone({
        coords = vector3(-664.2035, 328.2820, 83.0832),
        size = vector3(9, 1, 3),
        rotation = 174.8,
        debug = false,
        options = {
            {
                name = 'helico',
                event = 'cink:EmsAscenseur',
                icon = 'fas fa-walking',
                label = 'Toit - Hélicoptère',
                etage = 'helico',
                canInteract = function(entity, distance, coords, name)
                    if distance < 3 then
                            return true
                    end
                    return false
                end
            },
            {
                name = 'administration',
                event = 'cink:EmsAscenseur',
                icon = 'fas fa-walking',
                label = '2eme étage - Administration',
                etage = 'administration',
                canInteract = function(entity, distance, coords, name)
                    if distance < 3 then
                            return true
                    end
                    return false
                end
            },
            {
                name = 'soinsintensifs',
                event = 'cink:EmsAscenseur',
                icon = 'fas fa-walking',
                label = '1er étage - Soins Intensifs',
                etage = 'soinsintensifs',
                canInteract = function(entity, distance, coords, name)
                    if distance < 3 then
                            return true
                    end
                    return false
                end
            },
            {
                name = 'rdc',
                event = 'cink:EmsAscenseur',
                icon = 'fas fa-walking',
                label = 'Accueil - Récéption',
                etage = 'rdc',
                canInteract = function(entity, distance, coords, name)
                    if distance < 3 then
                            return true
                    end
                    return false
                end
            },            
            {
                name = 'sous-sol',
                event = 'cink:EmsAscenseur',
                icon = 'fas fa-walking',
                label = 'Parking - Garage',
                etage = 'sous-sol',
                canInteract = function(entity, distance, coords, name)
                    if distance < 3 then
                            return true
                    end
                    return false
                end
            }
        }
    })
    exports.ox_target:addBoxZone({
        coords = vector3(-664.1630, 327.8672, 88.0187),
        size = vector3(10, 1, 3),
        rotation = 174.8,
        debug = false,
        options = {
            {
                name = 'helico',
                event = 'cink:EmsAscenseur',
                icon = 'fas fa-walking',
                label = 'Toit - Hélicoptère',
                etage = 'helico',
                canInteract = function(entity, distance, coords, name)
                    if distance < 3 then
                            return true
                    end
                    return false
                end
            },
            {
                name = 'administration',
                event = 'cink:EmsAscenseur',
                icon = 'fas fa-walking',
                label = '2eme étage - Administration',
                etage = 'administration',
                canInteract = function(entity, distance, coords, name)
                    if distance < 3 then
                            return true
                    end
                    return false
                end
            },
            {
                name = 'soinsintensifs',
                event = 'cink:EmsAscenseur',
                icon = 'fas fa-walking',
                label = '1er étage - Soins Intensifs',
                etage = 'soinsintensifs',
                canInteract = function(entity, distance, coords, name)
                    if distance < 3 then
                            return true
                    end
                    return false
                end
            },
            {
                name = 'rdc',
                event = 'cink:EmsAscenseur',
                icon = 'fas fa-walking',
                label = 'Accueil - Récéption',
                etage = 'rdc',
                canInteract = function(entity, distance, coords, name)
                    if distance < 3 then
                            return true
                    end
                    return false
                end
            },            
            {
                name = 'sous-sol',
                event = 'cink:EmsAscenseur',
                icon = 'fas fa-walking',
                label = 'Parking - Garage',
                etage = 'sous-sol',
                canInteract = function(entity, distance, coords, name)
                    if distance < 3 then
                            return true
                    end
                    return false
                end
            }
        }
    })

    exports.ox_target:addBoxZone({
        coords = vector3(-664.1171, 327.9830, 92.7449),
        size = vector3(9, 1, 3),
        rotation = 174.8,
        debug = false,
        options = {
            {
                name = 'helico',
                event = 'cink:EmsAscenseur',
                icon = 'fas fa-walking',
                label = 'Toit - Hélicoptère',
                etage = 'helico',
                canInteract = function(entity, distance, coords, name)
                    if distance < 3 then
                            return true
                    end
                    return false
                end
            },
            {
                name = 'administration',
                event = 'cink:EmsAscenseur',
                icon = 'fas fa-walking',
                label = '2eme étage - Administration',
                etage = 'administration',
                canInteract = function(entity, distance, coords, name)
                    if distance < 3 then
                            return true
                    end
                    return false
                end
            },
            {
                name = 'soinsintensifs',
                event = 'cink:EmsAscenseur',
                icon = 'fas fa-walking',
                label = '1er étage - Soins Intensifs',
                etage = 'soinsintensifs',
                canInteract = function(entity, distance, coords, name)
                    if distance < 3 then
                            return true
                    end
                    return false
                end
            },
            {
                name = 'rdc',
                event = 'cink:EmsAscenseur',
                icon = 'fas fa-walking',
                label = 'Accueil - Récéption',
                etage = 'rdc',
                canInteract = function(entity, distance, coords, name)
                    if distance < 3 then
                            return true
                    end
                    return false
                end
            },            
            {
                name = 'sous-sol',
                event = 'cink:EmsAscenseur',
                icon = 'fas fa-walking',
                label = 'Parking - Garage',
                etage = 'sous-sol',
                canInteract = function(entity, distance, coords, name)
                    if distance < 3 then
                            return true
                    end
                    return false
                end
            }
        }
    })

    exports.ox_target:addBoxZone({
        coords = vector3(-664.1232, 328.0567, 140.1232),
        size = vector3(10, 1, 3),
        rotation = 174.8,
        debug = false,
        options = {
            {
                name = 'helico',
                event = 'cink:EmsAscenseur',
                icon = 'fas fa-walking',
                label = 'Toit - Hélicoptère',
                etage = 'helico',
                canInteract = function(entity, distance, coords, name)
                    if distance < 3 then
                            return true
                    end
                    return false
                end
            },
            {
                name = 'administration',
                event = 'cink:EmsAscenseur',
                icon = 'fas fa-walking',
                label = '2eme étage - Administration',
                etage = 'administration',
                canInteract = function(entity, distance, coords, name)
                    if distance < 3 then
                            return true
                    end
                    return false
                end
            },
            {
                name = 'soinsintensifs',
                event = 'cink:EmsAscenseur',
                icon = 'fas fa-walking',
                label = '1er étage - Soins Intensifs',
                etage = 'soinsintensifs',
                canInteract = function(entity, distance, coords, name)
                    if distance < 3 then
                            return true
                    end
                    return false
                end
            },
            {
                name = 'rdc',
                event = 'cink:EmsAscenseur',
                icon = 'fas fa-walking',
                label = 'Accueil - Récéption',
                etage = 'rdc',
                canInteract = function(entity, distance, coords, name)
                    if distance < 3 then
                            return true
                    end
                    return false
                end
            },
            {
                name = 'sous-sol',
                event = 'cink:EmsAscenseur',
                icon = 'fas fa-walking',
                label = 'Parking - Garage',
                etage = 'sous-sol',
                canInteract = function(entity, distance, coords, name)
                    if distance < 3 then
                            return true
                    end
                    return false
                end
            }
        }
    })