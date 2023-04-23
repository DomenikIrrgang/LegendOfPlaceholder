class_name Stat
enum {
	# Increases attackpower, dodge, critical effect, haste.
	AGILITY,

	# Increases spellpower, mana, hit and crit by 1.
	INTELLECT,

	# Increases the resistance to all spell schools by 1 and increases health by 10.
	STAMINA,

	# Increases the total health.
	HEALTH,

	# Increases effectiveness of physical abilities.
	ATTACK_POWER,

	# Increases the effect of all non physical abilities.
	SPELL_POWER,
	FIRE_SPELL_POWER,
	FROST_SPELL_POWER,
	WIND_SPELL_POWER,
	EARTH_SPELL_POWER,
	LIGHT_SPELL_POWER,
	SHADOW_SPELL_POWER,
	NATURE_SPELL_POWER,
	WATER_SPELL_POWER,
	THUNDER_SPELL_POWER,
	GRAVITY_SPELL_POWER,

	# Reduces the effect of abilities on the unit.
	ARMOR,
	FIRE_RESISTANCE,
	FROST_RESISTANCE,
	WIND_RESISTANCE,
	EARTH_RESISTANCE,
	LIGHT_RESISTANCE,
	SHADOW_RESISTANCE,
	NATURE_RESISTANCE,
	WATER_RESISTANCE,
	THUNDER_RESISTANCE,
	GRAVITY_RESISTANCE,

	# Increases the chance to dodge an ability. Some abilities can not be dodged tho.
	DODGE,

	# Increases the chance to parry an attack (physical). If an attack has been parried, a counter attack is executed.
	PARRY,

	# Increases the chance for an ability missing on you.
	AVOIDANCE,

	# Increases the chance to not miss with abilities.
	HIT,

	# Reduces the chance that abilities are dodged or parried.
	EXPERTISE,

	# Reduces the chance for abilities to crit on you and increases your dodge and parry.
	DEFENSE,

	# Increases the chance for abilities to critically strike.
	CRIT,

	# Effects different abilities and resources. Also determines who attacks first.
	HASTE,

	# Enhances the effect of the mastery crystal.
	MASTERY,

	# Increases the effect of critical strikes.
	CRITICAL_EFFECT,

	# Increases maximum value of the proper resource.
	RAGE,
	ENERGY,
	MANA,

	# Reduces costs of abilities.
	RESOURCE_COST_MANA,
	RESOURCE_COST_HEALTH,
	RESOURCE_COST_RAGE,
	RESOURCE_COST_ENERGY,

	# Effects ability value directly.
	DAMAGE_DONE,
	DAMAGE_TAKEN,
	HEALING_DONE,
	HEALING_TAKEN,
	
	# Gives a chance to reflect spells
	SPELL_REFLECT
}
