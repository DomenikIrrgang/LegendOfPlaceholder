class_name HurtBox2D
extends Area2D

func _ready() -> void:
	connect("area_entered", _on_area_entered)
	
func _on_area_entered(hitbox: HitBox2D) -> void:
	if hitbox == null:
		return
