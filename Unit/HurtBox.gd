class_name HurtBox2D
extends Area2D

signal got_hurt(source: Unit, ability: Ability)

var hurts = []
var hurt_threshold: float = 0.4

func _ready() -> void:
	connect("area_entered", on_area_entered)
	
func _process(delta: float) -> void:
	var expired_hurts = []
	for hurt in hurts:
		hurt.time_passed += delta
		if hurt.time_passed >= hurt_threshold:
			expired_hurts.append(hurt)
	for hurt in expired_hurts:
		hurts.erase(hurt)
	
func on_area_entered(hit_box) -> void:
	if hit_box is HitBox2D:
		on_hurt(hit_box)
		
func on_hurt(hit_box: HitBox2D) -> void:
	if not got_hurt_recently(hit_box.unit, hit_box.ability):
		hurts.append({
			"time_passed": 0.0,
			"source": hit_box.unit,
			"ability": hit_box.ability,
		})
		got_hurt.emit(hit_box.unit, hit_box.ability)
	
func got_hurt_recently(source: Unit, ability: Ability) -> bool:
	for hurt in hurts:
		if hurt.source == source and hurt.ability == ability and hurt.time_passed < hurt_threshold:
			return true
	return false
