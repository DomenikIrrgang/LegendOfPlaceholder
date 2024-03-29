class_name EngulfingPlain
extends Ability

var EngulfingPlainStage1 = load("res://Enemy/ElementalSlime/Abilities/EngulfingPlainStage1.tscn")
var EngulfingPlainStage2 = load("res://Enemy/ElementalSlime/Abilities/EngulfingPlainStage2.tscn")
var EngulfingPlainStage3 = load("res://Enemy/ElementalSlime/Abilities/EngulfingPlainStage3.tscn")

var EngulfingPlainDebuff = load("res://Resources/StatusEffects/EngulfingPlane.tres")

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
		stage_instance.void_zone.set_active(false)
		stage_instance.void_zone.status_effect = EngulfingPlainDebuff
		stage_instance.global_position = source.global_position
		current_stages.append(stage_instance)
		
func despawn_current_stage() -> void:
	for stage in current_stages:
		stage.free()
	current_stages = []
		
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
	
func on_cast_stopped(_source: Unit, _target: Unit) -> void:
	despawn_current_stage()
	stage_timer.stop()
	active_timer.stop()
	break_timer.stop()
