extends Control

@onready
var animation: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation.animation_finished.connect(on_hide_finished)

func show_black_bars() -> void:
	animation.play("Show")
	visible = true
	
func hide_black_bars() -> void:
	animation.play("Hide")
	
func on_hide_finished(animation_name: String) -> void:
	if animation_name == "Hide":
		visible = false
