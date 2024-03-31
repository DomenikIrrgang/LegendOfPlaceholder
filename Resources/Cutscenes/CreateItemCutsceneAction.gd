class_name CreateItemCutsceneAction
extends CutsceneAction

@export
var item: Item

@export
var amount: int = 1

func start() -> void:
	Globals.get_inventory().add_item(item, amount)
	cutscene_action_finished.emit(self)
