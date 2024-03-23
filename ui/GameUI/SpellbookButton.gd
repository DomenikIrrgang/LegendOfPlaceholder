extends TextureRect

func _ready():
	EventBus.on_event.connect(on_event)
	
func on_event(event: String, _data: Dictionary) -> void:
	if event == SpellbookWindow.Events.Opened:
		texture = load("res://assets/ui/bottom_hud/spellbook_open.png")
	if event == SpellbookWindow.Events.Closed:
		texture = load("res://assets/ui/bottom_hud/spellbook_closed.png")
