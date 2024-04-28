extends PanelContainer

@export
var game_state_index: int = 0

@onready
var title: Label = $MarginContainer/VBoxContainer/Title

@onready
var input: LineEdit = $MarginContainer/LineEdit

func _ready():
	gui_input.connect(on_gui_input)
	if SaveFileManager.is_new_game_state(game_state_index):
		input.visible = true
		input.text_submitted.connect(func(_text: String): load_game_state())
	else:
		input.visible = false
		title.text = SaveFileManager.get_game_state(game_state_index).name
		
func load_game_state() -> void:
	SaveFileManager.loaded_game_state_index = game_state_index
	if SaveFileManager.is_new_game_state(game_state_index):
		SaveFileManager.set_game_state_name(game_state_index, input.text)
		SaveFileManager.save_to_save_file()
	get_tree().change_scene_to_file("res://Zones/BaseScene.tscn")
	
func on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and (input.text != "" or input.visible == false) and event.button_index == MOUSE_BUTTON_MASK_LEFT and event.is_pressed():
		load_game_state()
	
