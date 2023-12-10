extends EnemyPhaseState

var ImmuneEffect = load("res://Resources/StatusEffects/TestEffect.tres")

var PoisonBolt = load("res://Enemy/Visjala/Abilities/PoisonBolt.tscn")
var PoisonBoltNova = load("res://Enemy/Visjala/Abilities/PoisonBoltNova.tscn")

var ConfusionPoison = load("res://Enemy/Visjala/Abilities/ConfusionPoison.tscn")
var ConfusionPoisonStatusEffect = load("res://Enemy/Visjala/StatusEffects/LearnedConfusionPoison.tres")

var PoisonCloud = load("res://Enemy/Visjala/Abilities/PoisonCloud.tscn")
var PoisonCloudStatusEffect = load("res://Enemy/Visjala/StatusEffects/LearnedPoisonCloud.tres")

var LayEgg = load("res://Enemy/Visjala/Abilities/LayEgg.tscn")
var LayEggEffect = load("res://Enemy/Visjala/StatusEffects/LearnedLayEgg.tres")
var HatchEggs = load("res://Enemy/Visjala/Abilities/HatchEggs.tscn")

var HoningSpit = load("res://Enemy/Visjala/Abilities/HoingSpit.tscn")
var HoningSpitEffect = load("res://Enemy/Visjala/StatusEffects/LearnedHoningSpit.tres")

var hatching_phase_1_entered: bool = false
var hatching_phase_2_entered: bool = false
var hatching_phase_3_entered: bool = false

var ability_unlocks = [
	{
		effect = ConfusionPoisonStatusEffect,
		ability = ConfusionPoison,
		name = "Confusing Egg",
	},
	{
		effect = PoisonCloudStatusEffect,
		ability = PoisonCloud,
		name = "Cloudy Egg",
	},
	{
		effect = LayEggEffect,
		ability = LayEgg,
		name = "Hatching Egg",
	},
	{
		effect = HoningSpitEffect,
		ability = HoningSpit,
		name = "Honing Egg",
	},
]

func enter(_data := {}) -> void:
	super(_data)
	add_timed_ability(PoisonBolt.instantiate(), Globals.get_player(), 5, 5, 0.1)
	add_timed_ability(PoisonBoltNova.instantiate(), Globals.get_player(), 5, 5, 0.1)
	if get_enemy().has_status_effect(ConfusionPoisonStatusEffect):
		add_timed_ability(ConfusionPoison.instantiate(), Globals.get_player(), 20, 20, 0.1)
	if get_enemy().has_status_effect(PoisonCloudStatusEffect):
		add_timed_ability(PoisonCloud.instantiate(), Globals.get_player(), 20, 20, 0.1)
	if get_enemy().has_status_effect(LayEggEffect):
		add_timed_ability(LayEgg.instantiate(), Globals.get_player(), 15, 15, 0.1)
		add_timed_ability(HatchEggs.instantiate(), Globals.get_player(), 30, 30, 0.1)
	if get_enemy().has_status_effect(HoningSpitEffect):
		add_timed_ability(HoningSpit.instantiate(), Globals.get_player(), 15, 15, 0.1)
	get_enemy().movement_strategy = UnitMovementStrategy.new(get_enemy())
	get_enemy().get_resource(ResourceType.Enum.HEALTH).resource_value_changed.connect(boss_health_changed)
	get_enemy().remove_status_effect(ImmuneEffect, get_enemy())
	get_enemy().died.connect(on_died)
	
func on_died(source: Unit) -> void:
	for node in Globals.get_loaded_scene_node().get_children():
		if node is Egg or node is SmallSnake or node is PoisonCloudZone:
			node.queue_free()
	
func exit() -> void:
	super()
	get_enemy().apply_status_effect(ImmuneEffect, get_enemy())

func boss_health_changed(resource: UnitResource, _new_value: int, _change: int, _original_change: int) -> void:
	if resource.get_percentage() <= 0.75 and !hatching_phase_1_entered:
		hatching_phase_1_entered = true
		state_machine.transition_to("HatchingPhase1", {
			ability_unlocks = ability_unlocks
		})
	if resource.get_percentage() <= 0.50 and !hatching_phase_2_entered:
		hatching_phase_2_entered = true
		state_machine.transition_to("HatchingPhase1", {
			ability_unlocks = ability_unlocks
		})
	if resource.get_percentage() <= 0.25 and !hatching_phase_3_entered:
		hatching_phase_3_entered = true
		state_machine.transition_to("HatchingPhase1", {
			ability_unlocks = ability_unlocks
		})
		

