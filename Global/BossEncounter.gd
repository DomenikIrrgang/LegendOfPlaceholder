extends Node

var active: bool = false
var boss: Unit


signal boss_encounter_started(unit: Unit)
signal boss_encounter_ended()

func _process(delta):
	if Globals.get_scene_tree().get_first_node_in_group("boss") != null and (not active or boss == null):
		active = true
		boss = Globals.get_scene_tree().get_first_node_in_group("boss") 
		boss_encounter_started.emit(boss)
	if Globals.get_scene_tree().get_first_node_in_group("boss") == null and active:
		active = false
		boss_encounter_ended.emit()
		boss = null
		
func get_boss() -> Unit:
	return boss
		
