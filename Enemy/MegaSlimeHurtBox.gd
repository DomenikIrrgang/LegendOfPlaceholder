class_name MegaSlimeHurtBox
extends HurtBox2D

var SlimeScene = preload("res://Enemy/Enemy.tscn")

func _ready() -> void:
	connect("area_entered", on_area_entered)
	
func on_area_entered(hit_box) -> void:
	if hit_box is HitBox2D:
		on_hurt(hit_box)
		
func on_hurt(_hit_box: HitBox2D) -> void:
	var slime = SlimeScene.instantiate()
	get_node("../../").add_child(slime)
	slime.global_position = global_position + Vector2(20, 20)
