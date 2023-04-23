class_name HitBox2D
extends Area2D
	
func _ready() -> void:
	connect("area_entered", on_hit)
	connect("area_entered", debug_print)
	
func on_hit(_hurt_box: HurtBox2D) -> void:
	pass
	
func debug_print(_hurt_box: HurtBox2D) -> void:
	print("hit something")
