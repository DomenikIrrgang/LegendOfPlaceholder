class_name ResourceBar
extends TextureProgressBar

var animation_speed: float = 0.1

var resource: UnitResource

var text: String = ""

var tween: Tween

func _ready() -> void:
	Globals.get_player().unit_resource_added.connect(on_resource_changed)
	Globals.get_player().unit_resource_removed.connect(on_resource_changed)
	on_resource_changed(ResourceType.Enum.FREE)
		
func on_resource_changed(_resource: ResourceType.Enum) -> void:
	var resource_type = Globals.get_player().get_secondary_resource_type()
	if resource_type != ResourceType.Enum.FREE:
		if resource != null:
			resource.resource_value_changed.disconnect(resource_value_changed)
			resource.resource_maximum_value_changed.disconnect(resource_max_value_changed)
		resource = Globals.get_player().get_resource(resource_type)
		resource.resource_value_changed.connect(resource_value_changed)
		resource.resource_maximum_value_changed.connect(resource_max_value_changed)
		max_value = resource.get_maximum_value()
		value = resource.get_value()
		text = str(value) + "/" + str(max_value)
		tween = create_tween()
		texture_progress = get_texture_for_resource_type(resource_type)
		visible = true
	else:
		visible = false
		
		
func get_texture_for_resource_type(resource_type: ResourceType.Enum):
	match(resource_type):
		ResourceType.Enum.MANA:
			return load("res://assets/ui/bottom_hud/mana_progress_texture.png")
		ResourceType.Enum.RAGE:
			return load("res://assets/ui/bottom_hud/rage_progress_texture.png")
		ResourceType.Enum.ENERGY:
			return load("res://assets/ui/bottom_hud/energy_progress_texture.png")

func resource_value_changed(resource: UnitResource, _new_value: int, _change: int, _original_change: int) -> void:
	tween.kill()
	tween = create_tween()
	tween.tween_property(self, 'value', resource.get_value(), animation_speed)
	tween.play()
	text = str(resource.get_value(),) + "/" + str(max_value)	
	
func resource_max_value_changed(resource: UnitResource, _new_maximum_value: int) -> void:
	max_value = resource.get_maximum_value()
	text = str(value) + "/" + str(max_value)
