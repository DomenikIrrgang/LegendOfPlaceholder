extends StateTransition

var player: Player

func _ready() -> void:
	await owner.ready
	player = self.get_parent().get_parent().get_parent() as Player

func can_transition() -> bool:
	return true
