
local function ContextMenuOpen()
    local menu = DermaMenu()
    local armorMenu = menu:AddOption("меню брони", function()
        RunConsoleCommand("jmod_ez_inv")
    end)
    local visorMenu = menu:AddOption("поднять или опустить визор", function()
        RunConsoleCommand("jmod_ez_toggleeyes")
    end)
    menu:Open()
end
hook.Add("OnContextMenuOpen", "CustomContextMenu", ContextMenuOpen)
