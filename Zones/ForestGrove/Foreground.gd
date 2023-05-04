extends Node2D

var orignal_position: Vector2
var tween: Tween

func _ready() -> void:
	orignal_position = global_position
	tween = create_tween()


func _process(delta: float) -> void:
	var movement_direction = Globals.get_player().velocity.normalized()
	if (tween != null):
		tween.stop()
	tween = create_tween()
	tween.tween_property(self, "position", orignal_position + (movement_direction * -0.5), 0.2)
	tween.play()
	#position = orignal_position + movement_direction
