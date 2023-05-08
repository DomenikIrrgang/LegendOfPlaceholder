class_name EnemyHitBox
extends HitBox2D

var timer: Timer
var hurt_box: HurtBox2D

func on_hit_box_left(_hurt_box: HurtBox2D) -> void:
	timer.stop()
	timer.queue_free()
	
func on_hit(_hurt_box: HurtBox2D) -> void:
	timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(on_timer)
	hurt_box = _hurt_box
	timer.start(1.0)
	
func on_timer() -> void:
	hurt_box.on_hurt(self)
	print("timer stopped")
