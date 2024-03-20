extends TextureRect

func _ready():
	EventBus.on_event.connect(on_event)
	
func on_event(event: String, data: Dictionary) -> void:
	if event == InventoryWindow.Events.Opened:
		texture = load("res://assets/ui/bottom_hud/open_bag.png")
	if event == InventoryWindow.Events.Closed:
		texture = load("res://assets/ui/bottom_hud/closed_bag.png")
