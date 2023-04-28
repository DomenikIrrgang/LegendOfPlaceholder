class_name HitBox2D
extends Area2D

@export
var unit: Unit

@export
var ability_scene: PackedScene

var ability: Ability
	
func _ready() -> void:
	area_entered.connect(on_area_entered)
	area_exited.connect(on_area_left)
	if ability_scene:
		ability = ability_scene.instantiate()
	
func on_area_left(hurt_box) -> void:
	if hurt_box is HurtBox2D:
		on_hit_box_left(hurt_box)
	
func on_area_entered(hurt_box) -> void:
	if hurt_box is HurtBox2D:
		on_hit(hurt_box)
		
func on_hit_box_left(_hurt_box: HurtBox2D) -> void:
	pass
	
func on_hit(_hurt_box: HurtBox2D) -> void:
	pass
