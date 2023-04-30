class_name HealSlime
extends Enemy

var heal_target: Unit

func _ready() -> void:
	super()
	movement_strategy = EscapeMovementStrategy.new(self, Globals.get_player())
	resources.append(Mana.new(stat_calculator))
	
func set_heal_target(unit: Unit):
	heal_target = unit
