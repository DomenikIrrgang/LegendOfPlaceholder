class_name ResourceBar
extends TextureProgressBar

var animation_speed: float = 0.1

var text: String = ""

var tween: Tween

func initialize(player: Player) -> void:
	var health = player.get_resource(ResourceType.Enum.MANA)
	health.resource_value_changed.connect(health_changed)
	health.resource_maximum_value_changed.connect(max_health_changed)
	max_value = health.get_maximum_value()
	value = health.get_value()
	text = str(value) + "/" + str(max_value)
	tween = create_tween()

func health_changed(resource: UnitResource, _new_value: int, _change: int, _original_change: int) -> void:
	tween.kill()
	tween = create_tween()
	tween.tween_property(self, 'value', resource.get_value(), animation_speed)
	tween.play()
	text = str(resource.get_value(),) + "/" + str(max_value)	
	
func max_health_changed(resource: UnitResource, _new_maximum_value: int) -> void:
	max_value = resource.get_maximum_value()
	text = str(value) + "/" + str(max_value)
