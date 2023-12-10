class_name VoidZone
extends HitBox2D

@export
var zone_active: bool = true

@export
var status_effect: StatusEffect

@export
var remove_status_effect_on_leave: bool = true

var targets: Array[HurtBox2D] = []

signal on_void_zone_enter(hurt_box: HurtBox2D)
signal on_void_zone_left(hurt_box: HurtBox2D)

func _ready() -> void:
	super()
	set_active(zone_active)
	
func set_active(active: bool) -> void:
	zone_active = active
	monitorable = active
	monitoring = active
	if active:
		for child in get_children():
			if child is Sprite2D and child.material:
				child.material.set_shader_parameter("brightness", 0.5)
	else:
		for child in get_children():
			if child is Sprite2D and child.material:
				child.material.set_shader_parameter("brightness", 1.0)
	
func on_hit(hurt_box: HurtBox2D) -> void:
	if zone_active:
		targets.append(hurt_box)
		on_void_zone_enter.emit(hurt_box)
		if hurt_box.owner != unit:
			hurt_box.owner.apply_status_effect(status_effect, unit)
	
func on_hit_box_left(hurt_box: HurtBox2D) -> void:
	if zone_active:
		targets.erase(hurt_box)
		on_void_zone_left.emit(hurt_box)
		if remove_status_effect_on_leave:
			hurt_box.owner.remove_status_effect(status_effect, unit)
