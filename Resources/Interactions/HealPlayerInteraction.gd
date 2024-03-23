class_name HealPlayerInteraction
extends Interaction

func start() -> void:
	Globals.get_player().get_resource(ResourceType.Enum.HEALTH).reset()

func get_icon() -> Texture:
	return load("res://assets/ui/bottom_hud/mend_icon.png")
	
func get_alias() -> String:
	return "Heal"
