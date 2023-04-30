class_name ForceNova
extends Ability

@onready
var hitbox: HitBox2D = $HitBox

var timer: Timer
var source: Unit

var force_field = ForceNova

func _ready() -> void:
	hitbox.unit = source
	hitbox.ability = self
	timer = Timer.new()
	timer.one_shot = true
	timer.timeout.connect(on_field_over)
	add_child(timer)
	timer.start(0.5)

func use(_source: Unit, _target: Unit) -> void:
	super(_source, _target)
	source = _source
	force_field = load("res://Combat/abilities/ForceNova.tscn").instantiate()
	force_field.source = source
	source.add_child(force_field)

func execute(_source: Unit, target: Unit) -> void:
	target.apply_pushback(
		target.global_position - _source.global_position,
		0.5,
		0.2
	)

func on_field_over() -> void:
	timer.stop()
	remove_child(timer)
	source.remove_child(self)
