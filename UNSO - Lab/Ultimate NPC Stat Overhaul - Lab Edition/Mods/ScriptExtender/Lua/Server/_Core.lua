Ext.Osiris.RegisterListener("LevelGameplayStarted", 2, "after", function(level, _)
    local assigned = Ext.Vars.GetModVariables(ModuleUUID).AssignedSubclasses or {}
    Ext.Vars.GetModVariables(ModuleUUID).AssignedSubclasses = assigned

    for _, entity in ipairs(Ext.Entity.GetAllEntitiesWithComponent("ServerCharacter")) do
        local charID = entity.Uuid and entity.Uuid.EntityUuid or entity

        for className, data in pairs(ClassData) do
            local hasMainClassPassive = data.MainClassPassive and Osi.HasPassive(charID, data.MainClassPassive) == 1

            assigned[charID] = assigned[charID] or {}
            local stored = assigned[charID][className]
            local charName = "Unknown"
            local entityObj = Ext.Entity.Get(charID)

            if entityObj and entityObj.DisplayName and entityObj.DisplayName.NameKey and entityObj.DisplayName.NameKey.Handle then
                charName = Ext.Loca.GetTranslatedString(entityObj.DisplayName.NameKey.Handle.Handle) or "Unknown"
        else
            charName = Osi.GetDisplayName(charID) or "Unknown"
        end

            if hasMainClassPassive then
                local hasSubclassPassives
                for _, subclassName in ipairs(data.SubclassPassives) do
                    if Osi.HasPassive(charID, subclassName) == 1 then
                        hasSubclassPassives = subclassName
                        break
                    end
                end

                if stored and hasSubclassPassives and stored ~= hasSubclassPassives then
                    assigned[charID][className] = hasSubclassPassives
                    Logger:BasicDebug(
                        "Subclass mismatch found for %s (%s) [%s]. Updating stored subclass: %s", charName, charID, className, subclassName)

                elseif not stored and hasSubclassPassives then
                    assigned[charID][className] = hasSubclassPassives
                    Logger:BasicDebug("Found existing subclass for %s (%s) [%s]. Storing: %s", charName, charID, className, subclassName)

                elseif stored and not hasSubclassPassives then
                    Logger:BasicDebug("Stored subclass exists for %s (%s) [%s] but passive not present.", charName, charID, className, subclassName)

                elseif not stored and not hasSubclassPassives then
                    Logger:BasicDebug("No subclass found or stored for %s (%s). No action taken.", charName, charID, className, subclassName)
                end

            else
                if stored then
                    assigned[charID][className] = nil
                    Logger:BasicDebug("Main passive missing for %s (%s) [%s]. Cleared stored subclass.", charName, charID, className, subclassName)
                end
            end
        end
        end
    end
end)
