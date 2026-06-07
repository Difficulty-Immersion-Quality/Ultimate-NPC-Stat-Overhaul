function Goon_DebugForceReapply()
    Logger:BasicDebug("== Manual Debug Force Reapply ==")

    if not LevelBoostTables then
        Logger:BasicError("[ERROR] LevelBoostTables is nil!")
        return
    end

    for _, entity in ipairs(Ext.Entity.GetAllEntitiesWithComponent("ServerCharacter")) do
        local charID = entity.Uuid and entity.Uuid.EntityUuid or entity
        if type(charID) == "string" then
            local name = Osi.GetDisplayName(charID) or "Unknown"
            local level = Osi.GetLevel(charID) or 0

            Logger:BasicInfo("[CHARACTER] %s (%s) | Level: %s", name, charID, level)

            for classPassive, classFunction in pairs(LevelBoostTables) do
                if HasPassive(charID, classPassive) then
                    Logger:BasicInfo("  [CLASS DETECTED] %s", classPassive)

                    -- Force wipe and reapply
                    Mods[ModTable].PersistentVars[charID] = {}

                    Logger:BasicDebug("  [ROULETTE] Running class function...")
                    classFunction(charID)

                    Logger:BasicDebug("  [LEVEL BOOSTS] Reapplying boosts...")
                    ApplyLevelBasedBoosts(charID)

                    Logger:BasicDebug("  [PASSIVES] Reapplying persistent passives...")
                    ApplyPersistantVars(charID)

                    Logger:BasicInfo("  [COMPLETE] All reapplication done for %s", name)
                    break -- Stop checking further class passives
                end
            end
        end
    end

    -- Print the entire PersistentVars table for debug
    Logger:BasicDebug("[DEBUG] Full PersistentVars Table:", Ext.Json.Stringify(Mods[ModTable].PersistentVars))

    Logger:BasicDebug("== Manual Debug Force Reapply Complete ==")
end

Ext.RegisterConsoleCommand("Goon_DebugForceReapply", function()
    Goon_DebugForceReapply()
end)
