extends CenterContainer

var interactable: Interactable

@onready
var label: Label = $Text

func _ready():
	Globals.get_player().interaction.interactable_in_range_changed.connect(interactable_in_range_changed)

func interactable_in_range_changed(_interactable: Interactable) -> void:
	if _interactable != null:
		interactable = _interactable
		visible = true
		global_position = get_interactable_position()
		label.text = interactable.owner.get_alias()
	else:
		interactable = null
		visible = false
		
func get_interactable_position() -> Vector2:
	var offset = (interactable.owner.model.get_rect().size.y * 0.8) * interactable.owner.get_global_transform_with_canvas().get_scale().y
	return interactable.owner.model.get_global_transform_with_canvas().origin - Vector2(0, offset) - Vector2(size.x / 2, size.y / 2 - 10)
	
func _process(delta) -> void:
	if interactable != null:
		global_position = get_interactable_position()
