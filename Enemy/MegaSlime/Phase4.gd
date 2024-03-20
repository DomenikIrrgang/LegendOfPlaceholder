extends EnemyPhaseState

var SummonSlime = preload("res://Enemy/MegaSlime/Abilities/SummonSlime.tscn").instantiate()
var SummonHealSlime = preload("res://Enemy/MegaSlime/Abilities/SummonHealSlime.tscn").instantiate()
var Zone = preload("res://Enemy/MegaSlime/Abilities/ZoneOfDoom.tscn").instantiate()

func enter(_data := {}) -> void:
	super(_data)
	owner.get_node("State/Moving").movement_strategy = FollowMovementStrategy.new(owner, Globals.get_player())
	owner.get_node("State/Idle").movement_strategy = FollowMovementStrategy.new(owner, Globals.get_player())
	add_timed_ability(SummonSlime, Globals.get_player(), 10.0, 17.0, 20.0)
	add_timed_ability(SummonHealSlime, Globals.get_player(), 22.0, 28.0, 20.0)
	add_timed_ability(Zone, Globals.get_player(), 8.0, 12.0, 20.0)
	get_enemy().died.connect(on_megaslime_died)
	CutsceneManager.start_cutscene(load("res://Resources/Cutscenes/MegaSlimePhase4.tres"))
	
func update(delta: float) -> void:
	super(delta)
	for node in Globals.get_world().get_children():
		if node is Slime and not node.died.is_connected(on_slime_died):
			node.died.connect(on_slime_died)

func on_slime_died(slime: Unit) -> void:
	Zone.use(get_enemy(), slime)
	
func on_megaslime_died(_mega_slime: Unit) -> void:
	CutsceneManager.start_cutscene(load("res://Resources/Cutscenes/MegaSlimeDefeated.tres"))	
	for node in Globals.get_loaded_scene_node().get_children():
		if node is Slime or node is HealSlime or node is ZoneOfDoomVoid:
			node.queue_free()
	
