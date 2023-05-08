class_name MegaSlime
extends Enemy

var resource_link: ResourceLink

func _ready() -> void:
	super()
	resources[ResourceType.Enum.MANA] = Mana.new(stat_calculator)
	resource_link = ResourceLink.new(ResourceType.Enum.HEALTH, [self])
	#combat_logic.add_calculate_logic_layer(ImmuneLayer.new())
	pause()
