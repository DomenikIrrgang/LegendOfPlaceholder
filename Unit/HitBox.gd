class_name HitBox2D
extends Area2D
	
func _ready() -> void:
	area_entered.connect(on_hit)
	
func on_hit(_hurt_box: HurtBox2D) -> void:
	pass
