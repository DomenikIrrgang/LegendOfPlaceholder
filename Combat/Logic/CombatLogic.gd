class_name CombatLogic
extends Node

var use_logic_layers: Array[LogicLayer] = [
	StartCastLayer.new(),	
	CastingLayer.new(),
	CooldownLayer.new(),
	ResourceCostLayer.new(),
	ResourceCheckLayer.new(),
	FailureLayer.new(),
]

var calculate_logic_layers: Array[LogicLayer] = [
	HitLayer.new(),
	CriticialHitLayer.new(),
	DodgeLayer.new(),
	ParryLayer.new(),
	AbilityAmountLayer.new(),
	CriticalEffectLayer.new(),
	ResistLayer.new(),
]

var calculator: CombatCalculator = CombatCalculator.new()

signal ability_result(result: CombatLogicResult)

func use_ability(source: Unit, target: Unit, ability: Ability) -> CombatLogicResult:
	var combat_logic_result = calculate_layers(use_logic_layers, source, target, ability)
	if combat_logic_result.type == ResultType.Enum.SUCCESS:
		apply_combat_logic_result_use(combat_logic_result)
		combat_logic_result.ability.use(source, target)
		if combat_logic_result.ability.ability_type == Ability.Type.TARGETED:
			combat_logic_result = cast_ability(source, target, ability)
	return combat_logic_result
	
func cast_ability(source: Unit, target: Unit, ability: Ability) -> CombatLogicResult:
	var combat_logic_result = calculate_layers(calculate_logic_layers, source, target, ability)
	apply_combat_logic_result_hit(combat_logic_result)
	if combat_logic_result.type == ResultType.Enum.SUCCESS:
		ability_result.emit(combat_logic_result)
	return combat_logic_result
	
func apply_combat_logic_result_hit(combat_logic_result: CombatLogicResult) -> void:
	if (combat_logic_result.type == ResultType.Enum.SUCCESS and 
		(combat_logic_result.hit_type == HitType.Enum.LANDED or 
		combat_logic_result.hit_type == HitType.Enum.CRITICAL)):
		combat_logic_result.target.increase_resource_value(
			ResourceType.Enum.HEALTH,
			-combat_logic_result.value
		)
		combat_logic_result.ability.execute(
			combat_logic_result.source,
			combat_logic_result.target
		)
	
func apply_combat_logic_result_use(combat_logic_result: CombatLogicResult) -> void:
	if combat_logic_result.type == ResultType.Enum.SUCCESS:
		combat_logic_result.source.increase_resource_value(
			combat_logic_result.resource_type,
			-combat_logic_result.resource_cost
		)

func calculate_layers(logic_layers: Array[LogicLayer], source: Unit, target: Unit, ability: Ability) -> CombatLogicResult:
	var combat_logic_result = CombatLogicResult.new()
	combat_logic_result.source = source
	combat_logic_result.target = target
	combat_logic_result.ability = ability
	for layer in logic_layers:
		combat_logic_result = layer.on_ability_cast(calculator, combat_logic_result)
	return combat_logic_result
	
func get_cast_time(source: Unit, ability: Ability) -> float:
	return calculator.get_cast_time(ability, source)

func add_calculate_logic_layer(layer: LogicLayer) -> void:
	calculate_logic_layers.append(layer)
