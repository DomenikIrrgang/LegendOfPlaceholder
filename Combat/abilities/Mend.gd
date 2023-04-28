extends Ability

func use(source: Unit) -> void:
	super(source)
	CombatLogic.cast_ability(self, source, source)
