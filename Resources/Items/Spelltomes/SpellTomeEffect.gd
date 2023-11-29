class_name SpelltomeEffect
extends UseEffect

@export
var ability: PackedScene

func on_use(_source: Unit) -> bool:
	return Spellbook.learn_ability(ability.instantiate())
