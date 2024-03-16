class_name Npc
extends Unit

@onready
var castbar
var CastBar = load("res://Enemy/Castbar.tscn")

func _ready() -> void:
	super()
	movement_strategy = UnitMovementStrategy.new(self)
	init_cast_bar()
	var model_instance = unit_data.model.instantiate()
	add_child(model_instance)
	remove_child(model)
	remove_child(model_animation)
	model_instance.model_animation.reparent(self)
	model_instance.model.reparent(self)
	model = model_instance.model
	model_animation = model_instance.model_animation
	model_animation.play("PlayerAnimations/Idle_Down")
	for node in get_children():
		print(node.name)
	
func init_cast_bar() -> void:
	castbar = CastBar.instantiate()
	add_child(castbar)
	castbar.global_position.y -= model.get_rect().size.y * model.scale.y - (3 * model.scale.y) + 9.5
	castbar.initialize(self)
