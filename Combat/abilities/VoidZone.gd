class_name VoidZone
extends HitBox2D

@export
var tick_time: float

@export
var hurt_on_tick: bool = true

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

func on_hit(hurt_box: HurtBox2D) -> void:
	targets.append(hurt_box)
	if (timer.is_stopped() == true and targets.size() > 0):
		timer.start(tick_time)
	on_void_zone_enter.emit(hurt_box)
	
	
func on_hit_box_left(hurt_box: HurtBox2D) -> void:
	targets.erase(hurt_box)
	if (timer.is_stopped() == false and targets.size() == 0):
		timer.stop()
	on_void_zone_left.emit(hurt_box)
	
func on_timer() -> void:
	for target in targets:
		print("ticking on target", target)
		target.on_hurt(self)
	on_void_zone_tick.emit(targets)
