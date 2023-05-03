extends Control

@onready
var animation: AnimationPlayer = $AnimationPlayer

func show_black_bars() -> void:
	animation.play("Show")
	
func hide_black_bars() -> void:
	animation.play("Hide")
