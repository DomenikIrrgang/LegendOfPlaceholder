extends Unit

var castbar
var CastBar = load("res://Enemy/Castbar.tscn")

@onready
var interaction_area: Area2D = $Interactable

@onready
var quest_indicator: Sprite2D = $QuestIndicator

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
	if model_instance.collision != null:
		model_instance.collision.reparent(self)
	if model_instance.interaction != null:
		model_instance.interaction.reparent(interaction_area)
	model = model_instance.model
	model_animation = model_instance.model_animation
	model_animation.play(model_instance.get_idle_down_animation())
	quest_indicator.position.y = -model.get_rect().size.y - 6
	quest_indicator.update()
	
func init_cast_bar() -> void:
	castbar = CastBar.instantiate()
	add_child(castbar)
	castbar.global_position.y -= model.get_rect().size.y * model.scale.y - (3 * model.scale.y) + 9.5
	castbar.initialize(self)
