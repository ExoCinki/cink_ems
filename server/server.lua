ESX = exports['es_extended']:getSharedObject()


TriggerEvent('esx_society:registerSociety', 'ambulance', 'EMS', 'society_ambulance', 'society_ambulance', 'society_ambulance', {type = 'public'})

local BlipsList = {}
local count = 1

function SendToDiscordWithSpecialURL(name,message,color,url)
    local DiscordWebHook = url
	local embeds = {
		{
			["title"]=message,
			["type"]="rich",
			["color"] =color,
			["footer"]=  {
			["text"]= "",
			},
		}
	}
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

ESX.RegisterUsableItem('wheelchairitem', function(playerId)

    local xPlayer = ESX.GetPlayerFromId(playerId)
	local count = exports.ox_inventory:Search(xPlayer.source, 'count', 'wheelchairitem')

	if count ~= nil and count > 0 then

		exports.ox_inventory:RemoveItem(xPlayer.source, 'wheelchairitem', 1)

		TriggerClientEvent('cink_emsmdt:CreateWheelChair', playerId)

	end
end)


RegisterServerEvent('cink:healems')
AddEventHandler('cink:healems', function(target, type)
	local xPlayer = ESX.GetPlayerFromId(source)

	-- if xPlayer.job.name == Config.JobName then
		TriggerClientEvent('cink:healemsjob', target, type)
		
		if type == 'small' then 
			local count = exports.ox_inventory:Search(source, 'count', 'bandageems')
			if count > 0 then 
				exports.ox_inventory:RemoveItem(source, 'bandageems', 1)
			else 
				TriggerClientEvent('okokNotify:Alert', source, 'EMS', 'Vous n\'avez pas assez Bandages Médicale', 5000, 'error')
			end
		elseif type == 'big' then
			local count = exports.ox_inventory:Search(source, 'count', 'bandageems')
			if count > 0 then 
				exports.ox_inventory:RemoveItem(source, 'medkit', 1)
			else 
				TriggerClientEvent('okokNotify:Alert', source, 'EMS', 'Vous n\'avez pas assez Kit Médicale', 5000, 'error')
			end
		end
	-- else
	-- 	print(('cink:healems: %s attempted to heal!'):format(xPlayer.identifier))
	-- end
end)

RegisterServerEvent('cink:SendDistressEms')
AddEventHandler('cink:SendDistressEms', function()

	local Player = source 
	local Ped = GetPlayerPed(Player)
	local PlayerCoords = GetEntityCoords(Ped)

	TriggerClientEvent('cink:SendDistressEms', source, PlayerCoords)

end)

RegisterNetEvent('cink:reviveems')
AddEventHandler('cink:reviveems', function(playerId)
	playerId = tonumber(playerId)
	if source == '' and GetInvokingResource() == 'monitor' then -- txAdmin support
        local xTarget = ESX.GetPlayerFromId(playerId)
        if xTarget then
            xTarget.triggerEvent('cink:reviveems')
        else
            print('ce joueur n\'est plus en ligne')
        end
	else
		local xPlayer = source and ESX.GetPlayerFromId(source)

		-- if xPlayer and xPlayer.job.name == Config.JobName then
			local xTarget = ESX.GetPlayerFromId(playerId)
			local count = exports.ox_inventory:Search(xPlayer.source, 'count', 'reakit')
			if count > 0 then 
				if xTarget then
							local playerMoney  = Config.ReviveRewardPlayer
							local societyMoney = Config.ReviveRewardSociety

							TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ambulance', function(account)
								if account then

									
									if societyMoney > 0 then
										TriggerClientEvent('okokNotify:Alert', xPlayer.source, 'EMS', 'Vous avez reçu <b style="color:#00FF00;">' .. societyMoney .. ' $</b> pour la réanimation', 5000, 'success')
										account.addMoney(societyMoney)
									end
									if playerMoney > 0 then
										TriggerClientEvent('okokNotify:Alert', xPlayer.source, 'EMS', 'Vous avez reçu <b style="color:#00FF00;">' .. playerMoney .. ' $</b> pour la réanimation <b>(Compte en banque)</b>', 5000, 'success')
										xPlayer.addAccountMoney('bank', playerMoney)
									end
									
									
								else
									if playerMoney > 0 then
										TriggerClientEvent('okokNotify:Alert', xPlayer.source, 'EMS', 'Vous avez reçu <b style="color:#00FF00;">' .. playerMoney .. ' $</b> pour la réanimation <b>(Compte en banque)</b>', 5000, 'success')
									end
								end
							end)
							
							exports.ox_inventory:RemoveItem(xPlayer.source, 'reakit', 1)

							xTarget.triggerEvent('cink:reviveems')
				else
					TriggerClientEvent('okokNotify:Alert', xPlayer.source, 'EMS', 'Le Joueur n\'est plus en ville !', 5000, 'error')
				end
			else 
				TriggerClientEvent('okokNotify:Alert', xPlayer.source, 'EMS', 'Vous n\'avez pas de kit de réanimation !', 5000, 'error')
			end
		-- end
	end
end)

RegisterNetEvent('cink:setDeathStatus')
AddEventHandler('cink:setDeathStatus', function(isDead)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer ~= nil then
		if type(isDead) == 'boolean' then
			MySQL.Sync.execute('UPDATE users SET is_dead = @isDead WHERE identifier = @identifier', {
				['@identifier'] = xPlayer.identifier,
				['@isDead'] = isDead
			})
		end
	end
end)

ESX.RegisterServerCallback('cink:getDeathStatus', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer ~= nil then
		MySQL.Async.fetchScalar('SELECT is_dead FROM users WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier
		}, function(isDead)
					
			if isDead then
				print(('[cink:EMS] [^2INFO^7] "%s" A essayer de se connecter en status Dead : true'):format(xPlayer.identifier))
			end

			cb(isDead)
		end)
	else 
		cb(false)
	end
end)

lib.addCommand('group.admin', {'revive'}, function(source, args)
    if args.target ~= nil and args.target > 0 and GetPlayerName(args.target) ~= nil then
		local TargetPlayer = ESX.GetPlayerFromId(args.target)

		TriggerClientEvent('cink:reviveems', args.target)
		TriggerClientEvent('okokNotify:Alert', source, 'Unité X', 'Vous avez réanimé  '.. TargetPlayer.getName(), 5000, 'success')
	else 
		TriggerClientEvent('cink:reviveems', source)
		TriggerClientEvent('okokNotify:Alert', source, 'Unité X', 'Vous avez était Réanimer !', 5000, 'success')
    end
end, {'target:number'})

RegisterNetEvent("cink:sendDemande")
AddEventHandler("cink:sendDemande", function(lastname, firstname,phone, subject, desc)

	if desc == nil or lastname == nil or firstname == nil or phone == nil or subject == nil then 
		TriggerClientEvent('okokNotify:Alert', source, 'Sonnette EMS', 'Merci de remplir tous les champs', 5000, 'error')	
	else 

		TriggerClientEvent('cink:envoidemanderendezvous', source)
		
		SendToDiscordWithSpecialURL("Central EMS","Demande émise par: __"..lastname.." "..firstname.. "__ \n\nTél: **__"..phone.."__**\n\nSujet: **__"..subject.."__**\n\nDemande: "..desc, 2061822, Config.SonnetteWebHook)
	end
	
end)

RegisterServerEvent('cink:GestionCompteEms')
AddEventHandler('cink:GestionCompteEms', function(typeEvent, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	if typeEvent == "depot" then 
		local cashPlayer = exports.ox_inventory:Search(xPlayer.source, 'count', 'money')
		if cashPlayer >= amount then 
			exports.ox_inventory:RemoveItem(xPlayer.source, 'money', amount)
			TriggerEvent('esx_addonaccount:getSharedAccount', "society_ambulance", function(account)
				account.addMoney(amount)
			end)
			TriggerClientEvent('okokNotify:Alert', xPlayer.source, 'CusTomoe', 'Vous avez déposer <b style="color:#00FF00;">' .. amount .. ' $</b> sur votre compte entreprise', 5000, 'success')
		else 
            TriggerClientEvent('okokNotify:Alert', xPlayer.source, 'CusTomoe', 'Vous n\'avez pas assez d\'argent sur vous !', 5000, 'error')
        end
	end

    if typeEvent == "retrait" then 
        local societyAccountSog = nil
			TriggerEvent('esx_addonaccount:getSharedAccount', "society_ambulance", function(account)
				societyAccountSog = account
			end)

		if societyAccountSog.money >= amount then 
            societyAccountSog.removeMoney(amount)
            exports.ox_inventory:AddItem(xPlayer.source, 'money', amount)
            TriggerClientEvent('okokNotify:Alert', xPlayer.source, 'CusTomoe', 'Vous avez retirer <b style="color:red;">' .. amount .. ' $</b> sur votre compte entreprise', 5000, 'success')
        else 
            TriggerClientEvent('okokNotify:Alert', xPlayer.source, 'CusTomoe', 'Votre compte entreprise n\'a pas assez !', 5000, 'error')
        end
	end


end)

RegisterServerEvent('cink:GestionEmployerPatronEms')
AddEventHandler('cink:GestionEmployerPatronEms', function(typeEvent, target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)

    if typeEvent == "recruter" then 
        if xPlayer.job.grade_name == "boss" then
			if xTarget ~= nil then	
				xTarget.setJob(xPlayer.job.name, 0)
				TriggerClientEvent('okokNotify:Alert', xPlayer.source, 'EMS', 'Vous avez recruter <b style="color:#00FF00;">' .. xTarget.name, 5000, 'success')
				TriggerClientEvent('okokNotify:Alert', xTarget.source, 'EMS', 'Vous avez été recruter par <b style="color:#00FF00;">' .. xPlayer.name, 5000, 'success')
			else
				TriggerClientEvent('okokNotify:Alert', xPlayer.source, 'EMS', 'Le Joueur est trop loin !', 5000, 'error')
			end
		end
    end
    if typeEvent == "promouvoir" then 
        if xPlayer.job.grade_name == "boss" then
			if xTarget ~= nil then
				if xTarget.job.grade < 5 then 
					xTarget.setJob(xPlayer.job.name, xTarget.job.grade + 1)
					TriggerClientEvent('okokNotify:Alert', xPlayer.source, 'EMS', 'Vous avez promu <b style="color:#00FF00;">' .. xTarget.name, 5000, 'success')
					TriggerClientEvent('okokNotify:Alert', xTarget.source, 'EMS', 'Vous avez été promu par <b style="color:#00FF00;">' .. xPlayer.name, 5000, 'success')
				else 
					TriggerClientEvent('okokNotify:Alert', xPlayer.source, 'EMS', 'Vous ne pouvez pas promouvoir plus !', 5000, 'error')
				end
			else
				TriggerClientEvent('okokNotify:Alert', xPlayer.source, 'EMS', 'Le Joueur est trop loin !', 5000, 'error')
			end
        end
    end
    if typeEvent == "virer" then 
        if xPlayer.job.grade_name == "boss" then
			if xTarget ~= nil then
				xTarget.setJob("unemployed", 0)
				TriggerClientEvent('okokNotify:Alert', xPlayer.source, 'EMS', 'Vous avez virer <b style="color:red;">' .. xTarget.name, 5000, 'success')
				TriggerClientEvent('okokNotify:Alert', xTarget.source, 'EMS', 'Vous avez été virer par <b style="color:red;">' .. xPlayer.name, 5000, 'success')
			else
				TriggerClientEvent('okokNotify:Alert', xPlayer.source, 'EMS', 'Le Joueur est trop loin !', 5000, 'error')
			end
		end
    end
end)


ESX.RegisterServerCallback('cink_ems:getPhoneNumberBySource', function(source,cb)
	if source ~= nil then 
		local number = exports["lb-phone"]:GetEquippedPhoneNumber(source)
		if number ~= nil then 
			cb(number)
		else 
			cb(false)
		end
	end
end)

RegisterNetEvent('cink_ems:GivingWheelChair')
AddEventHandler('cink_ems:GivingWheelChair', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	exports.ox_inventory:AddItem(xPlayer.source, 'wheelchairitem', 1)
end)


RegisterNetEvent('cink_ems:DemandeAccueil')
AddEventHandler('cink_ems:DemandeAccueil', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()

	for i=1, #xPlayers, 1 do
		local xTarget = ESX.GetPlayerFromId(xPlayers[i])
		if xTarget.job.name == "ambulance" then
			exports["lb-phone"]:SendNotification(xTarget.source, {
                title = "Centrale EMS", -- the title of the notification
                content = xPlayer.getName() .." sonne a l'accueil !", -- the description of the notification
                icon = "https://i.imgur.com/hsEDihp.png", -- the icon of the notification (optional)
            })
		end
	end
end)


RegisterNetEvent('cink_ems:DemandeDeRendezVous')
AddEventHandler('cink_ems:DemandeDeRendezVous', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()

	for i=1, #xPlayers, 1 do
		local xTarget = ESX.GetPlayerFromId(xPlayers[i])
		if xTarget.job.name == "ambulance" then
			exports["lb-phone"]:SendNotification(xPlayer.source, {
                title = "Centrale EMS", -- the title of the notification
                content = xPlayer.getName() .." a fait une demande de rendez vous !", -- the description of the notification
                icon = "https://i.imgur.com/hsEDihp.png", -- the icon of the notification (optional)
            })
		end
	end
end)