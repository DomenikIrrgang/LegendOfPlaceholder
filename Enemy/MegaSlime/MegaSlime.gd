class_name MegaSlime
extends Enemy

var resource_link: ResourceLink

func _ready() -> void:
	super()
	resources[ResourceType.Enum.MANA] = Mana.new(self)
	resource_link = ResourceLink.new(ResourceType.Enum.HEALTH, [self])
	print("megaslime ready")

func _init():
	print("mega sliem created")
