local QBCore = exports['qb-core']:GetCoreObject()

local tableDeadPed = {}

local function clearTarget(ped, target)
    StopAnimTask(ped, Config.animation.healAnimDict, 'exit', 1.0)
    DeleteEntity(target)
    exports['qb-target']:RemoveTargetEntity(target)
    tableDeadPed[target] = nil
end

local function progressBar(target, ped)
    QBCore.Functions.Progressbar('butcher', Lang:t("text.Butchering"), Config.ButcherTimer, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true
    }, {
        animDict = Config.animation.healAnimDict,
        anim = Config.animation.healAnim,
        flags = 1
    }, {}, {}, function() -- Done 
        QBCore.Functions.TriggerCallback('qb-o-hinting:server:getMeet', function(isAdd)
            if isAdd then
                QBCore.Functions.Notify(Lang:t("text.AddedParts"))
            else
                QBCore.Functions.Notify(Lang:t("text.NotEnoughSpace"))
            end
        end, GetPedType(target), GetEntityModel(target))
        clearTarget(ped, target)
    end, function() -- Cancel
        QBCore.Functions.Notify(Lang:t("text.Canceled"))
        clearTarget(ped, target)
    end)
end

local function isKnife(playerid)
    local weapon = GetSelectedPedWeapon(playerid)
    if weapon ~= nil then
        for _, v in pairs(Config.WhiteListWeapon) do
            if weapon == joaat(v) then
                return true
            end
        end
    end
    return false
end

local function getClosestPedId(coords)
    local pedPool = GetGamePool("CPed")
    local coords = coords or GetEntityCoords(PlayerPedId())
    local closestPed = -1
    local closestDist = -1
    for _, ped in pairs(pedPool) do
        if not IsPedAPlayer(ped) and IsEntityDead(ped) and GetPedType(ped) == 28 then
            local distance = #(coords - GetEntityCoords(ped))
            if closestDist == -1 or distance < closestDist then
                closestPed = ped
                closestDist = distance
            end
        end
    end
    return closestPed, closestDist
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    CreateThread(function()
        Wait(5000)
        local playerid = PlayerPedId()
        while true do
            local weapon = isKnife(playerid)
            if weapon and not IsPedInAnyVehicle(playerid) then
                local closetDeadPed, dist = getClosestPedId()
                if closetDeadPed and tableDeadPed[closetDeadPed] == nil then

                    tableDeadPed[closetDeadPed] = true

                    local opts = {
                        label = Lang:t("text.ButcherAnimal"),
                        icon = 'fa-solid fa-utensils',
                        action = function()
                            progressBar(closetDeadPed, playerid)
                        end
                    }
                    exports['qb-target']:AddTargetEntity(closetDeadPed, {
                        options = {opts},
                        distance = 2.0
                    })
                end
            end
            Wait(3000)
        end
    end)

    -- удаляет каждые 15 минут глаз для всех мертвых
    CreateThread(function()
        while true do
            for key, value in pairs(tableDeadPed) do
                exports['qb-target']:RemoveTargetEntity(key)
            end
            tableDeadPed = {}
            Wait(900000)
        end
    end)
end)
