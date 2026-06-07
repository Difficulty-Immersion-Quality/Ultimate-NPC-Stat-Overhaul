-- Gentle little reset of _Prep passives IN vars - call as !UNSO_ResetSubclasses
Ext.RegisterConsoleCommand("UNSO_ResetSubclasses", function(cmd, ...)
    local vars = Ext.Vars.GetModVariables(ModuleUUID)
    local assigned = vars.LabSubclasses or {}

    for charID, classTable in pairs(assigned) do
        for class, passive in pairs(classTable) do
            if Osi.HasPassive(charID, passive) == 1 then
                Osi.RemovePassive(charID, passive)
                Logger:BasicDebug("Removed stored subclass passive from (%s) [%s]: %s", charID, class, passive)
            end
        end
    end

    vars.LabSubclasses = {}

    Logger:BasicDebug("Stored subclasses reset, awaiting Absolute's Laboratory mutation to repopulate.")
end)

-- Hard bigger reset of _Prep passives regardless of vars - call as !UNSO_HardResetSubclasses
Ext.RegisterConsoleCommand("UNSO_HardResetSubclasses", function(cmd, ...)

    Logger:BasicDebug("HARD RESET: Removing ALL _Prep subclass passives")

    for _, entity in ipairs(Ext.Entity.GetAllEntitiesWithComponent("ServerCharacter")) do
        local charID = entity.Uuid and entity.Uuid.EntityUuid or entity

        for class, data in pairs(ClassData) do
            for _, subclass in ipairs(data.SubclassPassives) do
                local prepPassive = subclass .. "_Prep"

                if Osi.HasPassive(charID, prepPassive) == 1 then
                    Osi.RemovePassive(charID, prepPassive)
                    Logger:BasicDebug("Removed subclass passive: %s from %s", prepPassive, charID)
                end
            end
        end
    end

    local vars = Ext.Vars.GetModVariables(ModuleUUID)
    vars.LabSubclasses = {}

    Logger:BasicDebug("All subclasses reset, awaiting Absolute's Laboratory mutation to repopulate.")
end)