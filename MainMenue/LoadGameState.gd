extends PanelContainer

@export
var game_state_index: int = 0

@onready
var title: Label = $HBoxContainer/Header/VBoxContainer/Title

@onready
var input: LineEdit = $HBoxContainer/Header/LineEdit

@onready
var save_file_details = $HBoxContainer/SaveFileDetails

@onready
var level: Label = $HBoxContainer/SaveFileDetails/VBoxContainer/Level

var clicked: bool = false

func _ready():
	gui_input.connect(on_gui_input)
	focus_entered.connect(func(): 
		if not SaveFileManager.is_new_game_state(game_state_index):
			save_file_details.visible = true
		clicked = false
	)
	focus_exited.connect(func(): save_file_details.visible = false)
	if SaveFileManager.is_new_game_state(game_state_index):
		input.visible = true
		input.text_submitted.connect(func(_text: String): load_game_state())
		level.text = "Level: 1"
	else:
		input.visible = false
		title.text = SaveFileManager.get_game_state(game_state_index).name
		level.text = "Level: " + str(get_level_for_experience(SaveFileManager.get_game_state(game_state_index).data.player.experience))
		
func load_game_state() -> void:
	if SaveFileManager.is_new_game_state(game_state_index) and input.text != "":
		var regex = RegEx.new()
		regex.compile("^[A-Za-zÄÖÜäöüß]+$")
		if regex.search(input.text):
			SaveFileManager.loaded_game_state_index = game_state_index
			SaveFileManager.set_game_state_name(game_state_index, input.text)
			SaveFileManager.save_to_save_file()
			get_tree().change_scene_to_file("res://Zones/BaseScene.tscn")
	elif not SaveFileManager.is_new_game_state(game_state_index):
		SaveFileManager.loaded_game_state_index = game_state_index
		get_tree().change_scene_to_file("res://Zones/BaseScene.tscn")
		
func on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and (input.text != "" or input.visible == false) and event.button_index == MOUSE_BUTTON_MASK_LEFT and event.is_pressed():
		if clicked:
			load_game_state()
		else:
			clicked = true
	if event.is_action("ui_accept"):
		load_game_state()
		
func get_level_for_experience(experience: int) -> int:
	var level = 1
	var experience_needed_for_level_up = level * level * 100
	while experience >= experience_needed_for_level_up:
		experience -= experience_needed_for_level_up
		level += 1
		var previous_level_xp_needed = ((level - 1) * (level - 1) * 100)
		var current_level_xp_needed = (level * level * 100)
		experience_needed_for_level_up = current_level_xp_needed - previous_level_xp_needed
	return level
	
