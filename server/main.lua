local QBCore = exports['qb-core']:GetCoreObject()

local function findAnimalProps(value)
    local huntingProps = Config.HuntingProps
    for index = 1, #huntingProps do
        local animalProps = huntingProps[index]
        local animalIds = huntingProps[index].id
        for j = 1, #animalIds do
            local hasshKey = GetHashKey(animalIds[j])
            if hasshKey == value then
                return animalProps
            end
        end
    end
    print('!!! hunting undef hash value, check and add this model!!!', value)
    return nil

end

QBCore.Functions.CreateCallback('qb-o-hinting:server:getMeet', function(source, cb, pedType, hash)
    local animal = findAnimalProps(hash)
    local sourceCustom = source

    if animal == nil then
        TriggerClientEvent('QBCore:Notify', sourceCustom, Lang:t("text.ThisAnimalCannotBeButchered"))
        return
    end

    local Player = QBCore.Functions.GetPlayer(sourceCustom)
    local meat = animal.meat
    local skin = animal.meat
    local meatCount = math.random(meat.min, meat.max)
    local skinCount = math.random(skin.min, skin.max)
    if meat.item and Player.Functions.AddItem(meat.item, meatCount) then
        if skin.item then
            if Player.Functions.AddItem(skin.item, skinCount) then
                cb(true)
            else
                cb(false)
            end
        else
            cb(true)
        end
    else
        cb(false)
    end

end)
