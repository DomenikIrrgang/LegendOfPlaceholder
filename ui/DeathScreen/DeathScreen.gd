extends Control


func _ready():
	visible = false
	Globals.get_player().died.connect(on_player_died)
	SaveFileManager.game_state_loaded.connect(on_game_state_loaded)
	
func on_player_died(player: Unit) -> void:
	visible = true

func on_game_state_loaded(_game_state: Dictionary) -> void:
	visible = false
