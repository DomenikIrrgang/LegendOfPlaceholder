var name: String
var level: int
var id: int

var base_stats
var total_stats
var stat_calculator

var health
var primary_resource
var states: Array

func _init(new_name, new_level):
	name = new_name
	level = new_level
	base_stats = BaseStats.new(level)
	total_stats = StatSet.new().add_stat_set(base_stats)
	stat_calculator = StatCalculator.new(total_stats)
	health = Health.new(stat_calculator)
	primary_resource = Mana.new(stat_calculator)
	id = get_instance_id()
	
func reduce_resource(resource_type: String, amount: int):
	if (resource_type != ResourceType.HEALTH):
		if (primary_resource.type == resource_type):
			primary_resource.decrease_value(amount)
	else:
		if (primary_resource.type == resource_type):
			amount += primary_resource.decrease_value(amount)
		health.decrease_value(amount)
		
func has_resouce_amount(resource_type: String, amount: int):
	if (resource_type != ResourceType.HEALTH):
		if (primary_resource.type == resource_type):
			return primary_resource.get_value() >= amount
	else:
		if (primary_resource.type != ResourceType.HEALTH):
			return health.get_value() >= amount
		return primary_resource.get_value() + health.get_value() >= amount

func clone():
	var new_unit = ResourceLoader.load("res://src/combat/Unit.gd").new(name, level)
	new_unit.health = health.clone()
	new_unit.primary_resource = primary_resource.clone()
	new_unit.stat_calculator = stat_calculator
	new_unit.total_stats = total_stats
	new_unit.id = id
	return new_unit

func reset():
	health.reset()
	primary_resource.reset()
