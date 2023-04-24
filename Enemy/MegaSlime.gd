class_name MegaSlime
extends Enemy

func _ready() -> void:
	super()
	alias = "Megaslime"
	health_bar.initialize(self)

func check_dead(value, secondvalue) -> void:
	pass
