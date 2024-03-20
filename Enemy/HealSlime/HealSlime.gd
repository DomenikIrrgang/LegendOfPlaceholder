class_name HealSlime
extends Enemy

var heal_target: Unit

func _ready() -> void:
	super()
	resources[ResourceType.Enum.MANA] = Mana.new(self)
	
func set_heal_target(unit: Unit):
	heal_target = unit
