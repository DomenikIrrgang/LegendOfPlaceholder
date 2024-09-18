extends PanelContainer

func _ready() -> void:
	pass

func toggle() -> void:
	if visible:
		close()
	else:
		open()
		
func open() -> void:
	visible = true
	
func close() -> void:
	visible = false
