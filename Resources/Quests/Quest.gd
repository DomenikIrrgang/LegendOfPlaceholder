class_name Quest
extends Resource

enum TurninType {
	AUTO_COMPLETE,
	UNIT
}

@export
var name: String = ""

@export_multiline
var description: String = ""

@export
var recommended_level: int = 1

@export
var turnin_type: TurninType

@export
var objectives: Array[QuestObjective] = []

@export
var rewards: Array[QuestReward] = []

@export
var requirements: Array[Condition] = []
