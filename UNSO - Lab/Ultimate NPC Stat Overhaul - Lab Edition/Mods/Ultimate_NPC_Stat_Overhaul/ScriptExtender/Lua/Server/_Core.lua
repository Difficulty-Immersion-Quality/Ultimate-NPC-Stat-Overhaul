Ext.Osiris.RegisterListener("LevelGameplayStarted", 2, "after", function(level, _)
    local assigned = Ext.Vars.GetModVariables(ModuleUUID).LabSubclasses or {}
    Ext.Vars.GetModVariables(ModuleUUID).LabSubclasses = assigned

    -- Store the vars innit
    for _, entity in ipairs(Ext.Entity.GetAllEntitiesWithComponent("ServerCharacter")) do
        local charID = entity.Uuid and entity.Uuid.EntityUuid or entity

        -- Do the dawg have class
        for class, data in pairs(ClassData) do
            local hasMainClassPassive = data.MainClassPassive and Osi.HasPassive(charID, data.MainClassPassive) == 1

            -- Is bro even real and do he have a name + storage
            assigned[charID] = assigned[charID] or {}
            local stored = assigned[charID][class]
            local charName = "Unknown"
            local entityObj = Ext.Entity.Get(charID)

            if entityObj and entityObj.DisplayName and entityObj.DisplayName.NameKey and entityObj.DisplayName.NameKey.Handle then
                charName = Ext.Loca.GetTranslatedString(entityObj.DisplayName.NameKey.Handle.Handle) or "Unknown"
        else
            charName = Osi.GetDisplayName(charID) or "Unknown"
        end

            -- Do bro with main class have a subclass? We finna find out
            if hasMainClassPassive then
                local hasSubclassPassives
                for _, subclass in ipairs(data.SubclassPassives) do
                    if Osi.HasPassive(charID, subclass) == 1 then
                        hasSubclassPassives = subclass
                        break
                    end
                end

                -- Fat logs
                if stored and hasSubclassPassives and stored ~= hasSubclassPassives then
                    assigned[charID][class] = hasSubclassPassives
                    Logger:BasicDebug("Subclass mismatch found for (%s - %s) [%s]. Overwriting stored subclass: [%s].", charName, charID, class, hasSubclassPassives)

                elseif not stored and hasSubclassPassives then
                    assigned[charID][class] = hasSubclassPassives
                    Logger:BasicDebug("Found existing subclass for (%s - %s) [%s]. Storing: [%s].", charName, charID, class, hasSubclassPassives)

                elseif stored and not hasSubclassPassives then
                    Logger:BasicDebug("Stored subclass exists for (%s - %s) [%s] but [%s] passive not present.", charName, charID, class, stored)

                elseif not stored and not hasSubclassPassives then
                    Logger:BasicDebug("No subclass found or stored for (%s - %s). No action taken.", charName, charID, class)
                end

            else
                if stored then
                    assigned[charID][class] = nil
                    Logger:BasicDebug("Main passive missing for (%s - %s) [%s]. Cleared stored subclass: [%s].", charName, charID, class, stored)
                end
            end
        end
    end
end)
