extends Sprite2D

@onready
var animation: AnimationPlayer = $QuestIndicatorAnimation

var availalbe_quest_texture: Texture2D = load("res://assets/ui/quest/accept_quest.png")
var potential_quest_texture: Texture2D = load("res://assets/ui/quest/potential_quest.png")
var potential_turnin_quest_texture: Texture2D = load("res://assets/ui/quest/potential_turn_in.png")
var turnin_quest_texture: Texture2D = load("res://assets/ui/quest/complete_quest.png")

func _ready() -> void:
	animation.play("Bounce")
	Globals.get_player().level_changed.connect(func(_level: int): update())
	SaveFileManager.save_file_loaded.connect(func(_save_file: Dictionary): update())
	QuestManager.quest_accepted.connect(func(_quest: Quest): update())
	QuestManager.quest_completed.connect(func(_quest: Quest): update())
	QuestManager.quest_abandoned.connect(func(_quest: Quest): update())
	QuestManager.objective_progress_changed.connect(func(_quest: Quest, _objective: QuestObjective): update())

func update() -> void:
	visible = true
	if can_turn_in_quest():
		texture = turnin_quest_texture
	elif can_potentially_turn_in_quest():
		texture = potential_turnin_quest_texture
	elif quest_available():
		texture = availalbe_quest_texture
	elif quest_potentially_available():
		texture = potential_quest_texture
	else:
		visible = false

func quest_available() -> bool:
	var interactions = owner.unit_data.interactions.filter(func(interaction: Interaction):
		if interaction is StartQuestInteraction:
			return true
		return false
	)
	for interaction in interactions:
		if QuestManager.can_accept_quest(interaction.quest):
			return true
	return false
	
func quest_potentially_available() -> bool:
	var interactions = owner.unit_data.interactions.filter(func(interaction: Interaction):
		if interaction is StartQuestInteraction and not QuestManager.has_completed_quest(interaction.quest):
			return true
		return false
	)
	return interactions.size() > 0
	
func can_potentially_turn_in_quest() -> bool:
	var interactions = owner.unit_data.interactions.filter(func(interaction: Interaction):
		if interaction is CompleteQuestInteraction:
			return true
		return false
	)
	for interaction in interactions:
		if QuestManager.is_on_quest(interaction.quest):
			return true
	return false
	
func can_turn_in_quest() -> bool:
	var interactions = owner.unit_data.interactions.filter(func(interaction: Interaction):
		if (interaction is CompleteQuestInteraction and
		QuestManager.is_on_quest(interaction.quest) and
		QuestManager.quest_objectives_completed(interaction.quest)):
			return true
		return false
	)
	return interactions.size() > 0
