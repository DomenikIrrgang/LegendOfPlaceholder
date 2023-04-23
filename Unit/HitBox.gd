class_name HitBox2D
extends Area2D
	
func _ready() -> void:
	area_entered.connect(on_area_entered)
	
func on_area_entered(hurt_box) -> void:
	if hurt_box is HurtBox2D:
		on_hit(hurt_box)
	
func on_hit(_hurt_box: HurtBox2D) -> void:
	pass
