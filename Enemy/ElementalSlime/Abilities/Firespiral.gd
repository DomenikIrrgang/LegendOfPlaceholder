class_name FireSpiral
extends Ability

var FireballProjectile = preload("res://Combat/abilities/FireballAnimation.tscn")
var Fireball = preload("res://Combat/abilities/Fireball.tscn")

var timer: Timer

var fireballs_fired: int = 0
var fireballs_max: int = 40

var source: Unit
var target: Unit

func use(_source: Unit, _target: Unit) -> void:
	source = _source
	target = _target
	fireballs_fired = 0
	timer = Timer.new()
	source.add_child(timer)
	timer.wait_time = 0.2
	timer.connect("timeout", _on_timer_timeout)
	timer.start()

func _on_timer_timeout():
	var fireball_projectile_instance = FireballProjectile.instantiate()
	var fireball = Fireball.instantiate()
	Globals.get_world().add_child(fireball_projectile_instance)
	fireball_projectile_instance.init_projectile(source, fireball, (target.get_center() - source.get_center()).normalized(), 100.0)
	fireball_projectile_instance.global_position = source.get_center()
	fireballs_fired += 1
	if fireballs_fired >= fireballs_max:
		timer.stop()
