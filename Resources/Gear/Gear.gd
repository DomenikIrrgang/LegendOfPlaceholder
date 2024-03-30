class_name Gear
extends Item

enum Slot {
	HEAD,
	NECK,
	SHOULDERS,
	CLOAK,
	CHEST,
	BRACERS,
	GLOVES,
	BELT,
	LEGS,
	BOOTS,
	RING,
	WEAPON,
	RESOURCE_CRYSTAL,
	MASTERY_CRYSTAL
}

@export
var slot: Slot

@export
var gear_effects: Array[GearEffect] = []

@export
var gear_set: GearSet
