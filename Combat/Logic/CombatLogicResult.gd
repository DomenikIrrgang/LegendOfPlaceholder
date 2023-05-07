class_name CombatLogicResult
extends Node

var ability: Ability
var hit_type: HitType.Enum
var resource_type: ResourceType.Enum
var resource_cost: int = 0
var ability_value: int = 0
var value: int = 0
var source: Unit
var target: Unit
var original_target: Unit
var resist_amount: int = 0
