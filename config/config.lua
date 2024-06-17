Config = {
    Framework = "qb", -- esx / qb

    CustomActionMain = function() -- Event of the big button
        print("Custom action main")
    end,

    CustomActionSecondary = function() -- Event of the small at the bottom left button
        print("Custom action secondary")
    end,
}