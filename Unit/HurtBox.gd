class_name HurtBox2D
extends Area2D

func _init() -> void:
	collision_layer = 0
	collision_mask = 2
	
func _ready() -> void:
	connect("area_entered", _on_area_entered)
	
func _on_area_entered(hitbox: HitBox2D) -> void:
	if hitbox == null:
		return
	var test = hitbox.global_position.direction_to(global_position)
	print("Hitbox ", hitbox.global_position)
	print("Hurtbox ", global_position)
	owner.velocity = test.normalized() * 20
