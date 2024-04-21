local Translations = {
    text = {
        ["Butchering"] = "Разделка",
        ["AddedParts"] = "Добавлены части",
        ["NotEnoughSpace"] = "Нехватает места",
        ["Canceled"] = "Отменено",
        ["ButcherAnimal"] = "Разделать",
        ["ThisAnimalCannotBeButchered"] = "Это животное нельзя разделать"
    }
}
Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
