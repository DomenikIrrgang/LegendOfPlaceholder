class_name ResourcePotionEffect
extends UseEffect

@export
var resource_type: ResourceType.Enum

@export
var value: int

func on_use(source: Unit) -> bool:
	source.increase_resource_value(resource_type, value)
	return true
