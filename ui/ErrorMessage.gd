class_name ErrorMessage
extends Label

@onready
var animation: AnimationPlayer = $Animation

func _ready() -> void:
	animation.animation_finished.connect(on_animation_finished)

func show_message(message: String) -> void:
	text = message
	animation.play("fade")
	
func reset() -> void:
	animation.stop()
	animation.play("fade")
	
func on_animation_finished(_animation_name: String) -> void:
	queue_free()
