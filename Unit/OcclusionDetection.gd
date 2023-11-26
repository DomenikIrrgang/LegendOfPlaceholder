extends Area2D

@export
var models: Array[Sprite2D]

var tween: Tween

func _ready() -> void:
	area_entered.connect(on_area_entered)
	area_exited.connect(on_area_exited)
	tween = create_tween()
	
func on_area_entered(area) -> void:
	if area.owner is Player:
		tween.kill()
		tween = create_tween()
		for sprite in models:
			tween.tween_praoperty(sprite, "modulate", Color(
				sprite.modulate.r,
				sprite.modulate.g,
				sprite.modulate.b,
				0.5), 0.5)
	
func on_area_exited(area) -> void:
	if area.owner is Player:
		tween.kill()
		tween = create_tween()
		for sprite in models:
			tween.tween_property(sprite, "modulate", Color(
				sprite.modulate.r,
				sprite.modulate.g,
				sprite.modulate.b,
				1.0), 0.5)
