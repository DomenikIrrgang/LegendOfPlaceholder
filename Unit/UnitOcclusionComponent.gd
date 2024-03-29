class_name UnitOcclusionComponent
extends Area2D

func _ready() -> void:
	area_entered.connect(on_area_entered)
	area_exited.connect(on_area_exited)
	
func on_area_entered(area) -> void:
	if area.owner is Player:
		var tween: Tween = create_tween()
		tween.tween_property(owner, "modulate", Color(
			owner.modulate.r,
			owner.modulate.g,
			owner.modulate.b,
			0.5), 0.5)
	
func on_area_exited(area) -> void:
	if area.owner is Player:
		var tween: Tween = create_tween()
		tween.tween_property(owner, "modulate", Color(
			owner.modulate.r,
			owner.modulate.g,
			owner.modulate.b,
			1.0), 0.5)
