class_name HealSlime
extends Enemy

var heal_target: Unit
var mend: Mend

var mend_cooldown: float = 8
var last_mend_time: float = Time.get_unix_time_from_system()

func _ready() -> void:
	super()
	movement_strategy = EscapeMovementStrategy.new(self, Globals.get_player())
	mend = load("res://Combat/abilities/Mend.tscn").instantiate()
	mend.cooldown = mend_cooldown
	resources.append(Mana.new(stat_calculator))
	
func set_heal_target(unit: Unit):
	heal_target = unit

func _process(delta: float) -> void:
	super(delta)
	if Time.get_unix_time_from_system() - last_mend_time > mend_cooldown:
		CombatLogic.cast_ability(mend, self, heal_target)
		last_mend_time = Time.get_unix_time_from_system()
