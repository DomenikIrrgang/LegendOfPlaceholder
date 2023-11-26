class_name EngulfingPlain
extends Ability

var EngulfingPlainStage1 = preload("res://Enemy/ElementalSlime/Abilities/EngulfingPlainStage1.tscn")
var EngulfingPlainStage2 = preload("res://Enemy/ElementalSlime/Abilities/EngulfingPlainStage2.tscn")
var EngulfingPlainStage3 = preload("res://Enemy/ElementalSlime/Abilities/EngulfingPlainStage3.tscn")

var stages = [
	[EngulfingPlainStage1, EngulfingPlainStage3],
	[EngulfingPlainStage2, EngulfingPlainStage3],
	[EngulfingPlainStage1, EngulfingPlainStage3],
	[EngulfingPlainStage1, EngulfingPlainStage2]
]

var current_stages = []
var current_stage_count: int = 0

var stage_duration: float = 3.0
var break_between_stages: float = 1.0
var telegraph_duration: float = 1.0

var source: Unit
var target: Unit

var stage_timer: Timer
var break_timer: Timer
var active_timer: Timer

func _ready() -> void:
	stage_timer = Timer.new()
	stage_timer.one_shot = true
	stage_timer.timeout.connect(on_stage_timer)
	add_child(stage_timer)
	break_timer = Timer.new()
	break_timer.one_shot = true
	break_timer.timeout.connect(on_break_timer)
	add_child(break_timer)
	active_timer = Timer.new()
	active_timer.one_shot = true
	active_timer.timeout.connect(activate_stages)
	add_child(active_timer)

func use(_source: Unit, _target: Unit) -> void:
	source = _source
	target = _target
	current_stage_count = 0
	on_break_timer()
	activate_stages()
	
func spawn_stage(stage) -> void:
	for ability in stage:
		var stage_instance = ability.instantiate()
		source.add_child(stage_instance)
		stage_instance.void_zone.unit = source
		stage_instance.void_zone.ability = self
		stage_instance.void_zone.set_active(false)
		stage_instance.global_position = source.global_position
		stage_instance.void_zone.on_void_zone_tick.connect(on_void_zone_tick)
		current_stages.append(stage_instance)
		
func despawn_current_stage() -> void:
	for stage in current_stages:
		stage.free()
	current_stages = []
		
func on_void_zone_tick(_hurt_boxes: Array[HurtBox2D]) -> void:
	pass
	
func on_stage_timer() -> void:
	despawn_current_stage()
	on_break_timer()
	active_timer.start(telegraph_duration)
	
func on_break_timer() -> void:
	if current_stage_count < stages.size():
		spawn_stage(stages[current_stage_count])
		current_stage_count += 1
		stage_timer.start(stage_duration)

func activate_stages() -> void:
	for stage in current_stages:
		stage.void_zone.set_active(true)

func on_cast_started(_source: Unit, _target: Unit) -> void:
	source = _source
	target = _target
	spawn_stage(stages[0])
