class_name MegaSlime
extends Enemy

var resource_link: ResourceLink

func _ready() -> void:
	super()
	resource_link = ResourceLink.new(ResourceType.Enum.HEALTH, [self])

func _process(delta: float) -> void:
	super(delta)
	
