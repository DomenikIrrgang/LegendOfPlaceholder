class_name HitBox2D
extends Area2D

@export
var unit: Unit

@export
var ability_scene: PackedScene

var ability: Ability
	
func _ready() -> void:
	area_entered.connect(on_area_entered)
	ability = ability_scene.instantiate()
	
func on_area_entered(hurt_box) -> void:
	if hurt_box is HurtBox2D:
		on_hit(hurt_box)
	
func on_hit(_hurt_box: HurtBox2D) -> void:
	pass
