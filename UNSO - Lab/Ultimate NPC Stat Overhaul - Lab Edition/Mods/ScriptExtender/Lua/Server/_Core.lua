Ext.Osiris.RegisterListener("LevelGameplayStarted", 2, "after", function(level, _)
    local assigned = Ext.Vars.GetModVariables(ModuleUUID).AssignedSubclasses or {}
    Ext.Vars.GetModVariables(ModuleUUID).AssignedSubclasses = assigned

    for _, entity in ipairs(Ext.Entity.GetAllEntitiesWithComponent("ServerCharacter")) do
        local charID = entity.Uuid and entity.Uuid.EntityUuid or entity
        if charID then
            for class, data in pairs(ClassData) do
                if data.MainPassive and Osi.HasPassive(charID, data.MainPassive) == 1 then
                    local charLevel = Osi.GetLevel(charID)
                    local unlockLevel = data.SubclassUnlockLevel or 3

                    if charLevel >= unlockLevel then
                        local stored = assigned[charID]

                        local charName = "Unknown"
                        local entityObj = Ext.Entity.Get(charID)
                        if entityObj and entityObj.DisplayName and entityObj.DisplayName.NameKey and entityObj.DisplayName.NameKey.Handle then
                            charName = Ext.Loca.GetTranslatedString(entityObj.DisplayName.NameKey.Handle.Handle) or "Unknown"
                        else
                            charName = Osi.GetDisplayName(charID) or "Unknown"
                        end

                        local found
                        for _, subclass in ipairs(data.SubclassTable) do
                            if Osi.HasPassive(charID, subclass) == 1 then
                                found = subclass
                                break
                            end
                        end

                        if stored and found and stored ~= found then
                            assigned[charID] = found
                            Logger:BasicDebug("Subclass mismatch detected for %s (%s). Updating stored subclass: %s", charName, charID, found)

                        elseif stored and not found then
                            Osi.AddPassive(charID, stored)
                            Logger:BasicDebug("Stored subclasss not found for %s (%s). Applying: %s", charName, charID, stored)

                        elseif not stored and found then
                            assigned[charID] = found
                            Logger:BasicDebug("Found existing subclass on %s (%s). Storing: %s", charName, charID, found)

                        elseif not stored and not found then
                            local roll = math.random(1, #data.SubclassTable)
                            local selected = data.SubclassTable[roll]
                            assigned[charID] = selected
                            Osi.AddPassive(charID, selected)
                            Logger:BasicDebug("Rolled random subclass for %s (%s). Storing: %s", charName, charID, selected)
                        end
                    end
                end
            end
        end
    end
end)
