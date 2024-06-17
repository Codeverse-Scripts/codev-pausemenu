Framework = Config.Framework == "qb" and exports["qb-core"]:GetCoreObject() or exports['es_extended']:getSharedObject()
local open = false

function triggerServerCallback(...)
	if Config.Framework == "qb" then
		Framework.Functions.TriggerCallback(...)
	else
		Framework.TriggerServerCallback(...)
	end
end

CreateThread(function()
    while true do 
        if open then
            SetPauseMenuActive(false)
        end

        Wait(1)
    end
end)

RegisterNuiCallback('action', function(action)
	if action == 'settings' then
		ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_LANDING_MENU'), 0, -1)
	elseif action == 'map' then
		ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_MP_PAUSE'), 0, -1)
    elseif action == 'exit' then
        TriggerServerEvent("codev-pausemenu:exit")
    elseif action == 'custom-1' then
        Config.CustomActionMain()
    elseif action == 'custom-2' then
        Config.CustomActionSecondary()
	end

    SendNUIMessage({
        action = 'close'
    })

	SetNuiFocus(false, false)
	open = false
end)

RegisterNetEvent("codev-pausemenu:openMenu", function()
    if GetCurrentFrontendMenuVersion() == -1 and not IsNuiFocused() then
        open = true
        OpenPauseMenu()
    end
end)

RegisterNetEvent("codev-pausemenu:closeMenu", function()
    if open then
        open = false
        SetNuiFocus(false, false)
        SendNUIMessage({
            action = 'close'
        })
    end
end)

function OpenPauseMenu()
    SetPauseMenuActive(false)

    if not IsNuiFocused() then
        triggerServerCallback('codev-pausemenu:getPlayerData', function(data)
            local PlayerData = {}
            local job = "LOADING"
            local grade = "LOADING"
            local fullName = "LOADING"
            local fullJob = "LOADING"

            if Config.Framework == "esx" then
                PlayerData = Framework.GetPlayerData()
                job = PlayerData.job.label
                grade = PlayerData.job.grade_label
                fullName = PlayerData.firstName .. " " .. PlayerData.lastName
                fullJob = PlayerData.job.label .. " - " .. PlayerData.job.grade_label
            else
                PlayerData = Framework.Functions.GetPlayerData()
                job = PlayerData.job.label
                grade = PlayerData.job.grade.name
                fullName = PlayerData.charinfo.firstname .. " " .. PlayerData.charinfo.lastname
                fullJob = PlayerData.job.label .. " - " .. PlayerData.job.grade.name
            end

            SendNUIMessage({
                action = 'open',
                job = fullJob,
                name = fullName,
                bank = data.bank,
                cash = data.cash,
                avatar = data.avatar,
            })

            SetNuiFocus(true, true)
        end)
    end
end

RegisterCommand('openpausemenu', function()
    if GetCurrentFrontendMenuVersion() == -1 and not IsNuiFocused() then
        open = true
        OpenPauseMenu()
    end
end)

RegisterKeyMapping('openpausemenu', 'Open Pause Menu', 'keyboard', 'ESCAPE')
RegisterKeyMapping('openpausemenu', 'Open Pause Menu Secondary', 'keyboard', 'P')