extends TextureRect

@export
var action_name: String

func _input(event) -> void:
	if (event.is_action_released(action_name)):
		scale -= Vector2(0.3, 0.3)
		position += size * 0.15
	if (event.is_action_pressed(action_name)):
		scale += Vector2(0.3, 0.3)	
		position -= size * 0.15

func _ready():
	Input.joy_connection_changed.connect(joy_connection_changed)
	set_button_texture(InputControlls.get_button_texture(action_name))
	
func joy_connection_changed(_device_id: int, _connected: bool):
	set_button_texture(InputControlls.get_button_texture(action_name))

func set_button_texture(texture_path: String) -> void:
	self.texture = load(texture_path)
