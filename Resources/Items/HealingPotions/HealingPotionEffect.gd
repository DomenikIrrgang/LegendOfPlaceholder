class_name HealingPotionEffect
extends UseEffect

@export
var value: int

func use(source: Unit) -> bool:
	source.increase_resource_value(ResourceType.Enum.HEALTH, value)
	return true
