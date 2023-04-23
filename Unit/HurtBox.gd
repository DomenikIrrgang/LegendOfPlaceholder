class_name HurtBox2D
extends Area2D

func _ready() -> void:
	connect("area_entered", on_area_entered)
	
func on_area_entered(hit_box) -> void:
	if hit_box is HitBox2D:
		on_hurt(hit_box)
		
func on_hurt(_hit_box: HitBox2D) -> void:
	pass
