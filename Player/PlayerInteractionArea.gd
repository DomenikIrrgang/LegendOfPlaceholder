class_name PlayerInteractionArea
extends Area2D

var interactables_in_range = []
var closest_interactable: Interactable

signal interactable_in_range_changed(interactable: Interactable)

func _ready() -> void:
	connect("area_entered", on_area_entered)
	connect("area_exited", on_area_exited)
	
func has_interactable_in_range() -> bool:
	return interactables_in_range.size() > 0
	
func on_area_entered(interactable: Interactable) -> void:
	interactables_in_range.append(interactable)
	update_closest_interactable_in_range() 

func on_area_exited(interactable: Interactable) -> void:
	interactables_in_range.erase(interactable)
	update_closest_interactable_in_range() 
		
func update_closest_interactable_in_range() -> void:
	var closest = get_closest_interactable()
	if closest != closest_interactable:
		closest_interactable = closest
		interactable_in_range_changed.emit(closest_interactable)
	
func get_closest_interactable() -> Interactable:
	var closest = null
	for interactable in interactables_in_range:
		if closest == null or owner.get_center().distance_to(interactable.owner.get_center()) < owner.get_center().distance_to(closest.owner.get_center()):
			closest = interactable
	return closest

func _process(_delta: float) -> void:
	update_closest_interactable_in_range() 
