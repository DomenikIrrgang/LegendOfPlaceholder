class_name PlayerState
extends State

var player: Player

func _ready() -> void:
	await owner.ready
	player = self.get_parent().get_parent() as Player
	assert(player != null)
