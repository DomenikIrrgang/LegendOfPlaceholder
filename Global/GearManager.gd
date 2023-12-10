extends Node

func _ready():
	Globals.get_player().died.connect(on_player_died)
	
func on_player_died(_player: Unit) -> void:
	print("player died")
