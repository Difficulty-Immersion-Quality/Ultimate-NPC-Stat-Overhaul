-- Map all subclass tables to their respective classes
Mods[ModTable].SubclassTables = {
    Barbarian = BarbarianSubclassTable,
    Bard = BardSubclassTable,
    Cleric = ClericSubclassTable,
    Druid = DruidSubclassTable,
    Fighter = FighterSubclassTable,
    Monk = MonkSubclassTable,
    Paladin = PaladinSubclassTable,
    Ranger = RangerSubclassTable,
    Rogue = RogueSubclassTable,
    Sorcerer = SorcererSubclassTable,
    Warlock = WarlockSubclassTable,
    Wizard = WizardSubclassTable
}

Mods[ModTable].BarbarianSubclassTable = {
    "CX_Barbarian_Berserker_Boost",
    "CX_Barbarian_WildMagic_Boost",
    "CX_Barbarian_Wildheart_Boost"
}

Mods[ModTable].BardSubclassTable = {
    "CX_Bard_Lore_Boost",
    "CX_Bard_Swords_Boost",
    "CX_Bard_Valor_Boost"
}

Mods[ModTable].ClericSubclassTable = {
    "CX_Cleric_Life_Boost",
    "CX_Cleric_Light_Boost",
    "CX_Cleric_Knowledge_Boost",
    "CX_Cleric_Nature_Boost",
    "CX_Cleric_War_Boost",
    "CX_Cleric_Trickery_Boost",
    "CX_Cleric_Tempest_Boost"
}

Mods[ModTable].DruidSubclassTable = {
    "CX_Druid_Land_Boost",
    "CX_Druid_Moon_Boost",
    "CX_Druid_Spores_Boost"
}

Mods[ModTable].FighterSubclassTable = {
    "CX_Fighter_BattleMaster_Boost",
    "CX_Fighter_EldritchKnight_Boost",
    "CX_Fighter_Champion_Boost"
}

Mods[ModTable].MonkSubclassTable = {
    "CX_Monk_FourElements_Boost",
    "CX_Monk_OpenHand_Boost",
    "CX_Monk_Shadow_Boost"

}

Mods[ModTable].PaladinSubclassTable = {
    "CX_Paladin_Ancients_Boost",
    "CX_Paladin_Devotion_Boost",
    "CX_Paladin_Vengeance_Boost",
    "CX_Paladin_Oathbreaker_Boost"
}

Mods[ModTable].RangerSubclassTable = {
    "CX_Ranger_Hunter_Boost",
    "CX_Ranger_GloomStalker_Boost",
    "CX_Ranger_BeastMaster_Boost"
}

Mods[ModTable].RogueSubclassTable = {
    "CX_Rogue_ArcaneTrickster_Boost",
    "CX_Rogue_Assassin_Boost",
    "CX_Rogue_Thief_Boost"
}

Mods[ModTable].SorcererSubclassTable = {
}

Mods[ModTable].WarlockSubclassTable = {
    "CX_Warlock_Archfey_Boost",
    "CX_Warlock_Fiend_Boost",
    "CX_Warlock_GreatOldOne_Boost"
}

Mods[ModTable].WizardSubclassTable = {
    "CX_Wizard_Abjuration_Boost",
    "CX_Wizard_Conjuration_Boost",
    "CX_Wizard_Divination_Boost",
    "CX_Wizard_Enchantment_Boost",
    "CX_Wizard_Evocation_Boost",
    "CX_Wizard_Illusion_Boost",
    "CX_Wizard_Necromancy_Boost",
    "CX_Wizard_Transmutation_Boost"
}

-- Debug print to verify initialization
print("[DEBUG] SubclassTables initialized:", Mods[ModTable].SubclassTables)
