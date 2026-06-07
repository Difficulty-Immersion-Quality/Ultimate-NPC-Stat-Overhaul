-- Initialize ModTable and Mods
ModTable = "Ultimate_NPC_Stat_Overhaul" -- Declare ModTable globally
Mods = Mods or {} -- Ensure the global Mods table exists
Mods[ModTable] = Mods[ModTable] or {} -- Initialize the ModTable
Mods[ModTable].PersistentVars = Mods[ModTable].PersistentVars or {} -- Initialize PersistentVars

-- Initialize global feats list
Mods[ModTable].PersistentVars.selectedFeats = Mods[ModTable].PersistentVars.selectedFeats or {}

-- Debug print to confirm Mods[ModTable] initialization
Logger:BasicDebug("[DEBUG] Mods[ModTable] initialized: %s", Mods[ModTable])
Logger:BasicDebug("[DEBUG] PersistentVars initialized: %s", Mods[ModTable].PersistentVars)

-- Utility: Ensures category and key structure exists for a character
local function EnsureVarStructure(character, category)
    if not character or not category then
        Logger:BasicError("[ERROR] EnsureVarStructure called with invalid arguments. Character: %s Category: %s", character, category)
        return {}
    end
    Mods[ModTable].PersistentVars[character] = Mods[ModTable].PersistentVars[character] or {}
    Mods[ModTable].PersistentVars[character][category] = Mods[ModTable].PersistentVars[character][category] or {}
    Logger:BasicDebug("[DEBUG] EnsureVarStructure: Initialized structure for Character: %s, Category: %s", character, category)
    return Mods[ModTable].PersistentVars[character][category]
end

-- Set a single value
function SetCharacterVar(character, category, key, value)
    if not character or not category or not key then
        Logger:BasicError("[ERROR] SetCharacterVar called with invalid arguments. Character: %s Category: %s Key: %s", character, category, key)
        return
    end

    local cat = EnsureVarStructure(character, category)
    cat[key] = value
    Logger:BasicInfo("[SetCharacterVar] %s - %s[%s] = %s", character, category, key, value)
end

-- Add to a list
function AddToCharacterList(character, category, value)
    if not character or not category or not value then
        Logger:BasicError("[ERROR] AddToCharacterList called with invalid arguments. Character: %s Category: %s Value: %s", character, category, value)
        return
    end

    local cat = EnsureVarStructure(character, category)
    table.insert(cat, value)
    Logger:BasicInfo("[AddToCharacterList] %s - Added %s to %s", character, value, category)
end

-- Apply all stored values
function ApplyPersistentVars(character)
    if not character then
        Logger:BasicError("[ERROR] ApplyPersistentVars called with invalid character: %s", character)
        return
    end

    local vars = Mods[ModTable].PersistentVars[character]
    if not vars then
        Logger:BasicInfo("[ApplyPersistentVars] No vars found for character: %s", character)
        return
    end

    Logger:BasicDebug("[DEBUG] ApplyPersistentVars: Applying vars for character: %s", character)

    if vars.Skills then
        for _, skillUUID in ipairs(vars.Skills) do
            Osi.SelectSkills(character, skillUUID, 2)
            Logger:BasicInfo("[ApplyPersistentVars] Skill applied: %s", skillUUID)
        end
    end

    if vars.Spells then
        for _, spellUUID in ipairs(vars.Spells) do
            Osi.AddSpell(character, spellUUID, 1, 0)
            Logger:BasicInfo("[ApplyPersistentVars] Spell applied: %s", spellUUID)
        end
    end

    if vars.AbilityBonus then
        Osi.SelectAbilityBonus(character, vars.AbilityBonus, "AbilityBonus", 2, 1)
        Logger:BasicInfo("[ApplyPersistentVars] Ability Bonus applied: %s", vars.AbilityBonus)
    end

    if vars.SubclassPassive then
        Osi.AddPassive(character, vars.SubclassPassive)
        Logger:BasicInfo("[ApplyPersistentVars] Subclass Passive applied: %s", vars.SubclassPassive)
    end

    if vars.Feats then
        for _, feat in ipairs(vars.Feats) do
            Osi.AddPassive(character, feat)
            Logger:BasicInfo("[ApplyPersistentVars] Feat applied: %s", feat)
        end
    end
end

-- Console helper for debugging a character's vars
function DumpCharacterVars(character)
    if not character then
        Logger:BasicError("[ERROR] DumpCharacterVars called with invalid character: %s", character)
        return
    end

    local vars = Mods[ModTable].PersistentVars[character]
    if not vars then
        Logger:BasicInfo("[DumpCharacterVars] No vars found for character: %s", character)
        return
    end

    Logger:BasicDebug("=== DumpCharacterVars for %s ===", character)
    for category, data in pairs(vars) do
        Logger:BasicDebug("Category: %s", category)
        if type(data) == "table" then
            for k, v in pairs(data) do
                Logger:BasicDebug("   %s = %s", k, v)
            end
        else
            Logger:BasicDebug("   Value: %s", data)
        end
    end
    Logger:BasicDebug("======================================")
end

-- === Global Feat Tracking === --

-- Add a feat to selectedFeats
function AddSelectedFeat(feat)
    if not feat then
        Logger:BasicError("[ERROR] AddSelectedFeat called with invalid feat: %s", feat)
        return
    end

    Mods[ModTable].PersistentVars.selectedFeats[feat] = true
    Logger:BasicInfo("[AddSelectedFeat] Feat added: %s", feat)
end

-- Check if a feat is already selected
function IsFeatSelected(feat)
    if not feat then
        Logger:BasicError("[ERROR] IsFeatSelected called with invalid feat: %s", feat)
        return false
    end

    return Mods[ModTable].PersistentVars.selectedFeats[feat] or false
end

-- Clear all selected feats
function ClearSelectedFeats()
    Mods[ModTable].PersistentVars.selectedFeats = {}
    Logger:BasicInfo("[ClearSelectedFeats] All selected feats cleared.")
end
