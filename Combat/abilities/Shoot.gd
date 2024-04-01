extends Ability

func use(source: Unit, _target: Unit):
	super(source, _target)
	source.attack()
	
func can_use(source: Unit) -> bool:
	return super(source) and source.state.can_transition_to_state("Attack")
