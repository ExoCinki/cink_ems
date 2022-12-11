local FirstName = nil 
local LastName = nil
local Subject = nil
local Desc = nil
local Tel = nil
local CanSend = false
local Time = 1500


CreateThread(function()

    RequestModel(Config.PedModel)
    while ( not HasModelLoaded(Config.PedModel ) ) do
        Wait(1)
    end

    local SonnettePed = CreatePed(1, Config.PedModel, Config.PedCoords.first.x, Config.PedCoords.first.y, Config.PedCoords.first.z, Config.PedCoords.first.w, false, true)
    SetEntityInvincible(SonnettePed, true)
    SetBlockingOfNonTemporaryEvents(SonnettePed, true)
    FreezeEntityPosition(SonnettePed, true)

    while (not HasAnimDictLoaded("amb@code_human_wander_clipboard@male@base")) do
        RequestAnimDict("amb@code_human_wander_clipboard@male@base")
        Citizen.Wait(0) 
    end

    TaskPlayAnim(SonnettePed,"amb@code_human_wander_clipboard@male@base","static",8.0, 8.0, -1, 49, 1, 0, 0, 0)

    local coords = GetEntityCoords(SonnettePed)
    local prop2 = CreateObject(GetHashKey("p_cs_clipboard"), coords, true, true, true)
    AttachEntityToEntity(prop2, SonnettePed, GetPedBoneIndex(SonnettePed, 18905), 0.2, 0.1, 0.05, -130.0, -45.0, 0.0, true, true, false, false, 1, true)

end)

CreateThread(function()
    
    local SonnettePed2 = CreatePed(1, Config.PedModel, Config.PedCoords.second.x, Config.PedCoords.second.y, Config.PedCoords.second.z, Config.PedCoords.second.w, false, true)
    SetEntityInvincible(SonnettePed2, true)
    SetBlockingOfNonTemporaryEvents(SonnettePed2, true)
    FreezeEntityPosition(SonnettePed2, true)

end)

lib.registerMenu({
    id = 'ems_menu_sonnette',
    title = 'Sonnette EMS',
    position = 'top-right',
    options = {
        {label = 'Demander un EMS', description = 'Prévient les EMS de votre présences'},
        {label = 'Demande de rendez vous', description = 'Vous permet de prendre rendez vous avec un EMS'},
    }
}, function(selected, scrollIndex, args)
    if selected == 1 then 
        TriggerServerEvent('cink_ems:DemandeAccueil')
    end 

    if selected == 2 then 
        InputFicheMedicale()
        ResetSonnette()
    end
end)


RegisterNetEvent('cink:envoidemanderendezvous')
AddEventHandler('cink:envoidemanderendezvous', function()
    TriggerServerEvent('cink_ems:DemandeDeRendezVous')
end)


function InputFicheMedicale()
    local input = lib.inputDialog('Fiche de Rendez-vous', {'Prénom', 'Nom', 'Sujet', 'Description', 'Téléphone'})

    if not input then 
        exports['okokNotify']:Alert('Sonnette EMS', 'Formulaires Non Valide !', 5000, 'error')
        return 
    else 
        FirstName = input[1]
        LastName = input[2]
        Subject = input[3]
        Desc = input[4]
        Tel = input[5]
        CanSend = true

        if #FirstName > 4 and #LastName > 4 and #Subject > 4 and #Desc > 4 and #Tel > 4 then 
            TriggerServerEvent("cink:sendDemande", LastName, FirstName, Tel, Subject, Desc)
            exports['okokNotify']:Alert('Sonnette EMS', 'Formulaires Valide !', 5000, 'success')
        else 
            exports['okokNotify']:Alert('Sonnette EMS', 'Formulaires Non Valide !', 5000, 'error')
        end 
        
    end
end


CreateThread(function()
    while true do 
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, Config.Sonnette.x, Config.Sonnette.y, Config.Sonnette.z, true)

        if distance <= 12.0 then 
            Time = 1
            DrawMarker(1, Config.Sonnette.x, Config.Sonnette.y, Config.Sonnette.z - 0.9, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 255, false, false, 2, false, false, false, false)
        end

        if distance < 1.0 then 
            Time = 1
            lib.showTextUI('[E] - Menu Sonnette', {
                position = "right-center",
                icon = 'hand',
                style = {
                    borderRadius = 0,
                    backgroundColor = '#48BB78',
                    color = 'white'
                }
            })
            if IsControlJustPressed(0, 38) then 
                lib.showMenu('ems_menu_sonnette')
            end
        else 
            lib.hideTextUI()
        end

        Wait(Time)
    end
end)
