function PulseState(Ped, Message)
    local PedPlayer = GetPlayerPed(Ped)
    local HealthPlayer = GetEntityHealth(PedPlayer)
    local Pulse = 0 

    if HealthPlayer > 0 then
        Pulse = (HealthPlayer / 4 + math.random(19,28))
    else 
        Pulse = 0
    end

    if Pulse ~= nil then 
        if Pulse >= 0 then 
            if Pulse == 0 then 
                Pulse = math.random(5,15)
            end
            if Pulse < 30 then 
                exports['okokNotify']:Alert('Pouls', 'Pouls faible Total : ' .. Pulse, 8000, 'error')
            elseif Pulse > 30 and Pulse < 60 then 
                exports['okokNotify']:Alert('Pouls', 'Pouls moyen Total : ' .. Pulse, 8000, 'warning')
            elseif Pulse > 60 and Pulse < 80 then 
                exports['okokNotify']:Alert('Pouls', 'Pouls normal Total : ' .. Pulse, 8000, 'success')
            elseif Pulse > 80 then 
                exports['okokNotify']:Alert('Pouls', 'Pouls élevé Total : ' .. Pulse, 8000, 'error')
            end
        end
    end
    if Message ~= nil then
        Wait(1500)
        exports['okokNotify']:Alert('Etat Visuel', Message, 8000, 'warning')
    else
        exports['okokNotify']:Alert('Etat Visuel', 'Aucun Signe visuel de blessures', 8000, 'warning')
    end
end


function WeaponHashEqualCauseOfDeath(hashWeapon)
    local result = nil
    for k,v in pairs(Config.WeaponList) do 
        if hashWeapon == v then 
            result = k
            break
        end
    end

    if result ~= nil then 
        if string.find(result, "balle9mm") then 
            return "9MM"
        elseif string.find(result, "balle50acp") then
            return "50ACP"
        elseif string.find(result, "balle44") then
            return "44MM"
        elseif string.find(result, "balle45acp") then
            return "45ACP"
        elseif string.find(result, "balle556") then
            return "5.56MM"
        elseif string.find(result, "balle12G") then
            return "12G"
        elseif string.find(result, "balleplomb") then
            return "Plomb"
        elseif string.find(result, "griffe") then
            return "Griffes et Bleu - Armes Blanches"
        elseif string.find(result, "coupure") then
            return "Coupure - Armes Blanches"
        elseif string.find(result, "bleu") then
            return "Gros Ematome et Bleu - Armes Blanches"
        elseif string.find(result, "brulure") then
            return "Brulure"
        elseif string.find(result, "balle762") then
            return "7.62MM"
        elseif string.find(result, "balle762NATO") then
            return "7.62MM NATO"
        elseif string.find(result, "poing") then 
            return "Mains nues"
        else 
            return "Inconnu"
        end
    else 
        return "Inconnu"
    end
    
end

function RevivePlayer(closestPlayer)
    local closestPlayerPed = GetPlayerPed(closestPlayer)
    if closestPlayer ~= nil and closestPlayer > 0 and IsPedDeadOrDying(closestPlayerPed, true) then
        local playerPed = PlayerPedId()
        local lib, anim = 'mini@cpr@char_a@cpr_str', 'cpr_pumpchest'
        
        exports["okokNotify"]:Alert('Réanimation', 'Réanimation en cours ...', 8000, 'ems')
        for i=1, 15 do
            Citizen.Wait(900)

            ESX.Streaming.RequestAnimDict(lib, function()
                TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0.0, false, false, false)
            end)
        end

        -- On enlève les trace de sangs / blessures visuelles
        ClearPedBloodDamage(closestPlayerPed)
        ResetPedVisibleDamage(closestPlayerPed)

        for i = 0, 5 do
            ClearPedDamageDecalByZone(closestPlayerPed, i, "ALL")
            Wait(1)
        end

        
        -- On le Réanime
        TriggerServerEvent('cink:reviveems', GetPlayerServerId(closestPlayer))
    else
        exports["okokNotify"]:Alert('Réanimation', 'Vous ne pouvez réanimer quelqu\'un qui n\'est pas inconscient !', 8000, 'ems')
    end
end

function Respawn()

    SetDisplay(false, false)
	SetEntityCoordsNoOffset(PlayerPedId(), GlobalState.RespawnCoords.x, GlobalState.RespawnCoords.y, GlobalState.RespawnCoords.z, false, false, false, true)
    NetworkResurrectLocalPlayer(GlobalState.RespawnCoords.x, GlobalState.RespawnCoords.y, GlobalState.RespawnCoords.z, GlobalState.RespawnHeading, true, false)
	SetPlayerInvincible(PlayerPedId(), false)
    TriggerEvent('playerSpawned', GlobalState.RespawnCoords.x, GlobalState.RespawnCoords.y, GlobalState.RespawnCoords.z)
	ClearPedBloodDamage(PlayerPedId())
    IsDead = false
    IsBleeding = false
end

function RespawnPed(ped, coords, heading)
    TriggerServerEvent('cink:setDeathStatus', false)
    SetDisplay(false, false)
	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
	SetPlayerInvincible(ped, false)
    TriggerEvent('playerSpawned', coords.x, coords.y, coords.z)
	ClearPedBloodDamage(ped)
    IsDead = false
    IsBleeding = false
end

function ResetSonnette()
    FirstName = nil 
    LastName = nil
    Subject = nil
    Desc = nil
    Tel = nil
    CanSend = false
end

function InputGestionComptePatron()
    local input = lib.inputDialog('Gestion Compte', {'Montant'})

    if not input then return end

    local quantity = tonumber(input[1])
    if quantity ~= nil and quantity > 0 then 
        return quantity
    else
        exports['okokNotify']:Alert('Gestion Compte', 'Montant Invalide', 5000, 'error')
    end

end

function ClosePlayerForGestionEmployees()
    local PlayerCoords = GetEntityCoords(PlayerPedId())
    local ClosePlayer = lib.getClosestPlayer(PlayerCoords, 5, false)
    return ClosePlayer
end

function loadAnimDict(dict)
    RequestAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do        
        Citizen.Wait(1)
    end
end

function text(text)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(0.5, 0.5)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextOutline()
	SetTextJustification(0)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(0.5, 0.9, 0.5, 0.5, 0.4, 255, 255, 255, 255)
end



