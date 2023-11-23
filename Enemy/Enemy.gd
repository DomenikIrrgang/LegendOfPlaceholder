class_name Enemy
extends Unit

# UI
@onready
var health_bar: UnitHpBar 
var UnitHpBar = load("res://ui/unit/UnitHpBar.tscn")

@onready
var castbar
var CastBar = load("res://Enemy/Castbar.tscn")

@onready
var phase_state_machine: StateMachine = $PhaseState

@onready
var hit_box: HitBox2D = $HitBox2D


var Drop = preload("res://Unit/Drops/Drop.tscn")

func _ready() -> void:
	super()
	health_bar = UnitHpBar.instantiate()
	add_child(health_bar)
	health_bar.global_position.y -= model.get_rect().size.y * model.scale.y - (3 * model.scale.y)
	health_bar.initialize(self)
	castbar = CastBar.instantiate()
	add_child(castbar)
	castbar.global_position.y -= model.get_rect().size.y * model.scale.y - (3 * model.scale.y) + 9.5
	castbar.initialize(self)
	movement_strategy = FollowMovementStrategy.new(self, Globals.get_player())
	died.connect(on_died)
	
func on_died(_enemy: Unit) -> void:
	died.disconnect(on_died)
	Globals.get_player().gain_experience(unit_data.experience)
	var loot_table = unit_data.loot_table
	var i = 0
	for loot_drop in loot_table:
		var drop_chance = loot_drop.chance
		var roll = Globals.random_value(0.0, 1.0)
		if drop_chance >= roll:
			var drop = Drop.instantiate()
			var amount = int(round(loot_drop.minimum_amount + (loot_drop.maximum_amount - loot_drop.minimum_amount) * Globals.random_value(0.0, 1.0)))
			Globals.get_world().add_child(drop)
			drop.set_item(
				loot_drop.item, 
				amount
			)
			drop.global_position = global_position - Vector2(10.0, 10.0) + Vector2(10.0 , 10 * i) * Vector2(Globals.random_value(0.3, 1.0), 1)
			i += 1
	queue_free()
	
func pause() -> void:
	hit_box.get_node("CollisionShape2D").disabled = true
	phase_state_machine.enabled = false
	movement_strategy.enabled = false
	casting_enabled = false
	
func freeze() -> void:
	model_animation.pause()
	pause()
	
func start() -> void:
	hit_box.get_node("CollisionShape2D").disabled = false
	phase_state_machine.enabled = true
	movement_strategy.enabled = true
	casting_enabled = true
	
func unfreeze() -> void:
	model_animation.play()
	start()
