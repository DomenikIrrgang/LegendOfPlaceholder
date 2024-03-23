extends EnemyPhaseState

var SummonHealSlime = preload("res://Enemy/MegaSlime/Abilities/SummonHealSlime.tscn").instantiate()
var Zone = preload("res://Enemy/MegaSlime/Abilities/ZoneOfDoom.tscn").instantiate()
var Immune = load("res://Resources/StatusEffects/TestEffect.tres")

var slimes_killed: int = 0
var slimes_to_kill = 4

func enter(_data := {}) -> void:
	super(_data)
	get_enemy().movement_strategy = UnitMovementStrategy.new(get_enemy())
	add_timed_ability(SummonHealSlime, Globals.get_player(), 11.0, 13.0, 20.0)
	add_timed_ability(Zone, Globals.get_player(), 2.5, 3.5, 20.0)
	Globals.get_player().teleport(Vector2(-525.5334, -75.98621))
	CutsceneManager.start_cutscene(load("res://Resources/Cutscenes/MegaSlimePhase2.tres"))
	get_enemy().apply_status_effect(Immune, get_enemy())
	
func update(_delta: float) -> void:
	super(_delta)
	for node in Globals.get_enemies():
		if node is HealSlime and not node.died.is_connected(on_heal_slime_died):
			node.died.connect(on_heal_slime_died)
			
func on_heal_slime_died(_heal_slime: Unit) -> void:
	slimes_killed += 1
	if slimes_to_kill == slimes_killed:
		state_machine.transition_to("Phase3")
	
func exit() -> void:
	super()
	get_enemy().remove_status_effect(Immune, get_enemy())
	for node in Globals.get_enemies():
		if node is HealSlime:
			node.queue_free()
			get_enemy().resource_link.remove_unit(node)
