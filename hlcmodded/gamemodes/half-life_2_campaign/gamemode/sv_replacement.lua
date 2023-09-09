
local weapon_replacements = {
    ["weapon_pistol"] = "wep_mann_hmcd_glock",
    ["weapon_smg1"] = "wep_daun_hmcd_mp5",
	["weapon_shotgun"] = "wep_jack_gmod_shotgun",
	["weapon_357"] = "wep_mann_hmcd_sw500",
	["weapon_crossbow"] = "wep_jack_hmcd_rifle",	
    ["weapon_frag"] = "wep_nab_hmcd_m67",
	["weapon_ar2"] = "wep_jack_hmcd_assaultrifle",
	["weapon_rpg"] = "wep_mann_hmcd_rpg",
}


local function replacePlayerWeapons(ply)
    local weapons = ply:GetWeapons()
    for _, weapon in pairs(weapons) do
        local class = weapon:GetClass()
        if weapon_replacements[class] then
            ply:StripWeapon(class)
            ply:Give(weapon_replacements[class])
        end
    end
end

hook.Add("PlayerSpawn", "ReplaceWeapons", function(ply)
    timer.Simple(0, function() replacePlayerWeapons(ply) end)
end)


hook.Add("PlayerCanPickupWeapon", "ReplaceWeapons", function(ply, weapon)
    local class = weapon:GetClass()
    if weapon_replacements[class] then
        timer.Simple(0, function()
            ply:StripWeapon(class)
            ply:Give(weapon_replacements[class])
        end)
    end
end)
