class_name Enemy
extends Unit

# UI
@onready
var health_bar: UnitHpBar = $UnitHpBar

@onready
var phase_state_machine: StateMachine = $PhaseState

@onready
var hit_box: HitBox2D = $HitBox2D

func _ready() -> void:
	super()
	health_bar.initialize(self)
	movement_strategy = FollowMovementStrategy.new(self, Globals.get_player())
	died.connect(on_died)
	
func on_died(_enemy: Unit) -> void:
	Globals.get_player().gain_experience(unit_data.experience)
	queue_free()
	
func freeze() -> void:
	model_animation.pause()
	hit_box.get_node("CollisionShape").disabled = true
	phase_state_machine.enabled = false
	movement_strategy.enabled = false
	casting_enabled = false
	
func unfreeze() -> void:
	model_animation.play()
	hit_box.get_node("CollisionShape").disabled = false
	phase_state_machine.enabled = true
	movement_strategy.enabled = true
	casting_enabled = true
