extends Ability

@export
var time_stop_duration: float = 6.0

var timer: Timer
var source: Unit

func use(_source: Unit) -> void:
	super(_source)
	source = _source
	timer = Timer.new()
	timer.one_shot = true
	timer.timeout.connect(time_stop_over)
	source.add_child(timer)
	timer.start(time_stop_duration)
	for enemy in Globals.get_scene_tree().get_nodes_in_group("enemy"):
		if not enemy.is_in_group("boss"):
			enemy.freeze()
			
func time_stop_over() -> void:
	source.remove_child(timer)
	for enemy in Globals.get_scene_tree().get_nodes_in_group("enemy"):
		if not enemy.is_in_group("boss"):
			enemy.unfreeze()
