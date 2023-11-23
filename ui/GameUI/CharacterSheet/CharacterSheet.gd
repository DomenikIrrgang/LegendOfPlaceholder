extends PanelContainer

@onready
var title: Label = $MarginContainer/VBoxContainer/TitleBar/MarginContainer/CenterContainer/Title

@onready
var stats_container: Container = $MarginContainer/VBoxContainer/Content/VBoxContainer/HBoxContainer/ScrollContainer/Stats

@onready
var character_description: Label = $MarginContainer/VBoxContainer/Content/VBoxContainer/CenterContainer/CharacterDescription

var stat_labels = {}

func _ready():
	#Globals.get_player().stat_changed.connect(on_stat_changed)
	Globals.get_player().level_changed.connect(on_level_changed)
	title.text = Globals.get_player().get_alias()
	update_character_description()
	#update_all_stats()
	
func toggle() -> void:
	if visible:
		close()
	else:
		open()
		
func open() -> void:
	visible = true
	
func close() -> void:
	visible = false
		
func update_character_description() -> void:
	var player = Globals.get_player()
	character_description.text =  "Level " + str(player.get_level())

func update_all_stats() -> void:
	var player = Globals.get_player()
	for i in Stat.Enum.values():
		var label: Label
		if stat_labels.has(i):
			label = stat_labels[i]
		else:
			label = Label.new()
			stats_container.add_child(label)
			stat_labels[i] = label
		label.text = Stat.Enum.keys()[i] + " " + str(player.stats.get_stat(i))
		
func get_label_for_stat(stat: Stat.Enum) -> Label:
	if stat_labels.has(stat):
		return  stat_labels[stat]
	else:
		var label = Label.new()
		stats_container.add_child(label)
		stat_labels[stat] = label
		return label
		
func update_stat(stat: Stat.Enum) -> void:
	var player = Globals.get_player()
	var label: Label = get_label_for_stat(stat)
	label.text = Stat.Enum.keys()[stat] + " " + str(player.stats.get_stat(stat))

func on_level_changed(_level: int) -> void:
	update_character_description()
	
func on_stat_changed(stat: Stat.Enum, new_value: int) -> void:
	update_stat(stat)
