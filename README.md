add items to [qb]\qb-core\shared\items.lua
like:
animal_meat                = { name = 'animal_meat', label = 'Meat', weight = 100, type = 'item', image = 'animal_meat.png', unique = true, useable = false, shouldClose = true, combinable = nil, description = 'Some kind of raw meat' },

add img to [qb]\qb-inventory\html\images

in the config you can edit how much meat and skins will be added
and add other animals

[1] = {
        id = {
            [1] = 'A_C_Cow' -- animal model
        },
        name = 'Cow', -- name (any, for convenience)
        meat = {
            item = 'animal_meat', -- item`s name from [qb]\qb-core\shared\items.lua
            min = 1, -- the min amount obtained from butchering an animal
            max = 5 -- the max amount obtained from butchering an animal
        },
        skin = {
            item = 'cow_pelt', -- item`s name from [qb]\qb-core\shared\items.lua
            min = 1, -- the min amount obtained from butchering an animal
            max = 5 -- the max amount obtained from butchering an animal
        }
    },

Config.WhiteListWeapon = {"WEAPON_Knife"} add weapons allowed for cutting animals

I take all the items from: 
 https://github.com/bitc0de/fivem-items-gallery
 but you can use your own pictures, the main thing is according to the Fivem rules
