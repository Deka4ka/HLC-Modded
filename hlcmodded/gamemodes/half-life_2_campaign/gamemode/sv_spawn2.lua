local function spawnLoot(ply, ent)
    if ent:GetModel() == "models/props_junk/wood_crate001a.mdl" or ent:GetModel() == "models/props_junk/wood_crate001a_damaged.mdl" or ent:GetModel() == "models/props_junk/wood_crate002a.mdl" then
        local chance = math.random(1, 100)
        local lootTable = {
           {"ent_jack_gmod_ezarmor_mhead", 35},
            {"ent_jack_gmod_ezarmor_mltorso", 30},
            {"ent_jack_gmod_ezmedkit", 8},
            {"ent_jack_gmod_ezammo", 90},
            {"ent_aboot_gmod_ezarmor_hev", 1},
			{"ent_jack_gmod_ezarmor_lhead", 16},
			{"ent_jack_gmod_ezarmor_maska", 14},
			{"ent_jack_gmod_ezarmor_thermals", 2},
			{"ent_jack_gmod_ezarmor_htorso", 20},
			{"ent_jack_gmod_ezarmor_ltorso", 40},
			{"ent_jack_gmod_ezarmor_mtorso", 25},
			{"ent_jack_gmod_ezmedsupplies", 1}
        }	
        for _, loot in pairs(lootTable) do
            if chance <= loot[2] then
                local loot = ents.Create(loot[1])
                loot:SetPos(ent:GetPos())
                loot:Spawn()
                loot:SetCollisionGroup(COLLISION_GROUP_WEAPON)
                timer.Simple(5, function() 
                    if IsValid(loot) then
                        loot:SetCollisionGroup(COLLISION_GROUP_NONE) 
                    end
                end)
                break
            else
                chance = chance - loot[2]
            end
        end
        if math.random(1, 100) <= 10 then
            for i = 1, 2 do
                local loot = ents.Create(table.Random(lootTable)[1])
                loot:SetPos(ent:GetPos())
                loot:Spawn()
                loot:SetCollisionGroup(COLLISION_GROUP_WEAPON)
                timer.Simple(5, function() 
                    if IsValid(loot) then
                        loot:SetCollisionGroup(COLLISION_GROUP_NONE) 
                    end
                end)
            end
        end
    end
end

hook.Add("EntityTakeDamage", "SpawnLootOnBreak", function(ent, dmg)
    if (ent:GetModel() == "models/props_junk/wood_crate001a.mdl" or ent:GetModel() == "models/props_junk/wood_crate001a_damaged.mdl" or ent:GetModel() == "models/props_junk/wood_crate002a.mdl") and ent:Health() - dmg:GetDamage() <= 0 then
        spawnLoot(dmg:GetAttacker(), ent)
    end
end)
