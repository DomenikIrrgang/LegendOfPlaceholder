class_name Slime
extends Enemy

var timer: Timer

func _ready() -> void:
	super()
	timer = Timer.new()
	timer.one_shot = false
	timer.timeout.connect(on_timer)
	add_child(timer)
	timer.start(1.0)
	
func on_timer() -> void:
	stats.increase_stat(Stat.Enum.MOVEMENT_SPEED, 1.0)
