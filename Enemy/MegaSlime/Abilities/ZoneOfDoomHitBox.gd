extends HitBox2D

var timer: Timer
var target: HurtBox2D

func _ready() -> void:
	super()
	timer = Timer.new()
	timer.one_shot = false
	timer.timeout.connect(on_timer)
	add_child(timer)

func on_hit(hurt_box: HurtBox2D) -> void:
	target = hurt_box
	timer.start(1.0)
	hurt_box.owner.stats.increase_stat(Stat.Enum.MOVEMENT_SPEED, -12.0)
	
func on_hit_box_left(hurt_box: HurtBox2D) -> void:
	timer.stop()
	hurt_box.owner.stats.increase_stat(Stat.Enum.MOVEMENT_SPEED, 12.0)	
	
func on_timer() -> void:
	target.got_hurt.emit(unit, ability)
