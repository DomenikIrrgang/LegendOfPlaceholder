class_name MegaSlime
extends Enemy

var last_slime_spawn_time: float

func _ready() -> void:
	super()
	movement_strategy = UnitMovementStrategy.new(self)
	died.connect(on_mega_slime_died)

func _process(delta: float) -> void:
	super(delta)
	if Time.get_unix_time_from_system() - last_slime_spawn_time > 8:
		spawn_slime()
	if get_resource(ResourceType.Enum.HEALTH).get_percentage() < 0.3 and not movement_strategy is FollowMovementStrategy:
		movement_strategy = FollowMovementStrategy.new(self, get_node("../Player"))
	
func spawn_slime() -> void:
	last_slime_spawn_time = Time.get_unix_time_from_system()
	var slime = preload("res://Enemy/Slime.tscn").instantiate()
	get_parent().add_child(slime)
	slime.global_position = global_position + Vector2(randi_range(-20, 20), randi_range(-20, 20))
	
func on_mega_slime_died() -> void:
	for i in 20:
		spawn_slime()
	
