class_name MegaSlime
extends Enemy

func _ready() -> void:
	super()
	alias = "Megaslime"
	mass = 500.0
	health_bar.initialize(self)
