extends Ability

var fireball_sound = load("res://assets/sound/effects/fireballcast.wav").duplicate()

func use(source: Unit, _target: Unit):
	super(source, _target)
	source.attack()
	SoundManager.play_sound(SoundManager.Channel.SOUND_EFFECT, fireball_sound)
	
func can_use(source: Unit) -> bool:
	return super(source) and source.state.can_transition_to_state("Attack")
