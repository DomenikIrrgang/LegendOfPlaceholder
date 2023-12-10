extends EnemyPhaseState

var PoisonBolt = load("res://Enemy/Visjala/Abilities/PoisonBolt.tscn")
var PoisonBoltNova = load("res://Enemy/Visjala/Abilities/PoisonBoltNova.tscn")

var left_egg: Enemy
var right_egg: Enemy

var left_egg_effect: StatusEffect
var right_egg_effect: StatusEffect

var left_egg_ability: Ability
var right_egg_ability: Ability

var left_egg_position: Vector2 = Vector2(-129, -176)
var right_egg_position: Vector2 = Vector2(113, -176)

var egg_enemy: PackedScene = load("res://Enemy/Egg/Egg.tscn")
var small_snake_enemy: PackedScene = load("res://Enemy/SmallSnake/SmallSnake.tscn")

var data

func enter(_data := {}) -> void:
	super(_data)
	data = _data
	add_timed_ability(PoisonBolt.instantiate(), Globals.get_player(), 5, 5, 0.1)
	add_timed_ability(PoisonBoltNova.instantiate(), Globals.get_player(), 5, 5, 0.1)
	left_egg_effect = data.ability_unlocks[0].effect
	right_egg_effect = data.ability_unlocks[1].effect
	left_egg_ability = data.ability_unlocks[0].ability.instantiate()
	right_egg_ability = data.ability_unlocks[1].ability.instantiate()
	left_egg = spawn_enemy(
		egg_enemy.instantiate(),
		left_egg_position
	)
	left_egg.health_bar.name_label.text = data.ability_unlocks[0].name
	right_egg = spawn_enemy(
		egg_enemy.instantiate(),
		right_egg_position
	)
	right_egg.health_bar.name_label.text = data.ability_unlocks[1].name
	left_egg.died.connect(on_egg_died.bind(0))
	right_egg.died.connect(on_egg_died.bind(1))
	
func exit() -> void:
	super()

func on_egg_died(egg: Enemy, index: int) -> void:
	if egg == left_egg:
		right_egg.queue_free()
		get_enemy().apply_status_effect(left_egg_effect, get_enemy())
		spawn_small_snake(right_egg_position, right_egg_ability)
	else:
		left_egg.queue_free()
		get_enemy().apply_status_effect(right_egg_effect, get_enemy())
		spawn_small_snake(left_egg_position, left_egg_ability)
	data.ability_unlocks.remove_at(index)
	state_machine.transition_to("Phase1")
	
func spawn_small_snake(position: Vector2, ability: Ability) -> void:
	var small_snake = spawn_enemy(
		small_snake_enemy.instantiate(),
		position
	)
	small_snake.add_ability(
		ability,
		Globals.get_player(),
		10,
		10
	)
