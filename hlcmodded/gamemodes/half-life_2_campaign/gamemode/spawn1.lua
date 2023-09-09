local function spawnLoot(ply, ent)
    if ent:GetModel() == "models/props_junk/cardboard_box001a.mdl" or ent:GetModel() == "models/props_junk/cardboard_box002a.mdl" or ent:GetModel() == "models/props_junk/cardboard_box003a.mdl" then
        local chance = math.random(1, 100)
        local lootTable = {
           {"ent_jack_hmcd_pipebomb", 27},
            {"ent_jack_hmcd_molotov", 26},
			{"ent_jack_hmcd_suppressedrifle", 25}
        }	
        for _, loot in pairs(lootTable) do
            if chance <= loot[2] then
                local loot = ents.Create(loot[1])
                loot:SetPos(ent:GetPos())
                loot:Spawn()
                loot:SetCollisionGroup(COLLISION_GROUP_WEAPON)
                timer.Simple(5, function() loot:SetCollisionGroup(COLLISION_GROUP_NONE) end)
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
                timer.Simple(5, function() loot:SetCollisionGroup(COLLISION_GROUP_NONE) end)
            end
        end
    end
end

hook.Add("EntityTakeDamage", "SpawnLootOnBreak", function(ent, dmg)
    if (ent:GetModel() == "models/props_junk/cardboard_box001a.mdl" or ent:GetModel() == "models/props_junk/cardboard_box002a.mdl" or ent:GetModel() == "models/props_junk/cardboard_box003a.mdl") and ent:Health() - dmg:GetDamage() <= 0 then
        spawnLoot(dmg:GetAttacker(), ent)
    end
end)

