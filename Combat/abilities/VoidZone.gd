class_name VoidZone
extends HitBox2D

@export
var tick_time: float

@export
var hurt_on_tick: bool = true

@export
var zone_active: bool = true

var timer: Timer
var targets: Array[HurtBox2D] = []

signal on_void_zone_enter(hurt_box: HurtBox2D)
signal on_void_zone_left(hurt_box: HurtBox2D)
signal on_void_zone_tick(hurt_boxes: Array[HurtBox2D])

func _ready() -> void:
	super()
	timer = Timer.new()
	timer.one_shot = false
	timer.timeout.connect(on_timer)
	add_child(timer)
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
		if (timer.is_stopped() == true and targets.size() > 0):
			timer.start(tick_time)
		on_void_zone_enter.emit(hurt_box)
	
	
func on_hit_box_left(hurt_box: HurtBox2D) -> void:
	if zone_active:
		targets.erase(hurt_box)
		if (timer.is_stopped() == false and targets.size() == 0):
			timer.stop()
		on_void_zone_left.emit(hurt_box)
	
func on_timer() -> void:
	if zone_active:
		for target in targets:
			target.on_hurt(self)
		on_void_zone_tick.emit(targets)
