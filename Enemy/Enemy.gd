class_name Enemy
extends Unit

# UI
@onready
var health_bar: UnitHpBar = $UnitHpBar

@onready
var phase_state_machine: StateMachine = $PhaseState

@onready
var hit_box: HitBox2D = $HitBox2D

@onready
var castbar = $Castbar

var Drop = preload("res://Unit/Drops/Drop.tscn")

func _ready() -> void:
	super()
	health_bar.initialize(self)
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
		print("chance ", drop_chance, " roll ", roll)
		if drop_chance >= roll:
			var drop = Drop.instantiate()
			var amount = int(round(loot_drop.minimum_amount + (loot_drop.maximum_amount - loot_drop.minimum_amount) * Globals.random_value(0.0, 1.0)))
			print("amount", amount)
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
