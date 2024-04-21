local Translations = {
    text = {
        ["Butchering"] = "Butchering",
        ["AddedParts"] = "Added parts",
        ["NotEnoughSpace"] = "Not enough space",
        ["Canceled"] = "Отменено",
        ["ButcherAnimal"] = "Butcher the animal",
        ["ThisAnimalCannotBeButchered"] = "This animal cannot be butchered"
    }
}
Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
