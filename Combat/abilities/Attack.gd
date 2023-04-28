extends Ability

func use(source: Unit):
	super(source)
	source.attack()
	
func can_use(source: Unit) -> bool:
	return super(source) and source.movement_state.can_transition_to_state("Attack")
	
