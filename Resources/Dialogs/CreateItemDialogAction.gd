class_name CreateItemDialogAction
extends DialogAction

@export
var item: Item

@export
var amount: int = 1

func start() -> void:
	Globals.get_inventory().add_item(Globals.new_item_instance(item), amount)
	dialog_action_finished.emit(self)
