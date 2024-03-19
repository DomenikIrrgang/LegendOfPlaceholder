class_name InputState
extends Node

var movement_direction: Vector2 = Vector2(0, 0)

var action_map = {
	"Attack": false,
	"Dash": false,
	"Ability_One": false,
	"Ability_Two": false,
	"Ability_Three": false,
	"Ability_Four": false,
	"ui_accept": false,
	"Toggle_Inventory": false,
	"Toggle_CharacterSheet": false,
	"Toggle_Questlog": false,
	"Use_Consumeable": false,
	"Toggle_Spellbook": false,
	"Interact": false,
	"up": false,
	"down": false,
	"left": false,
	"right": false,
}
