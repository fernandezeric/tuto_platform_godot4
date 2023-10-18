extends Node2D

class_name CharacterStateMachine

@export var current_state = State

var states: Array[State]

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if(child is State):
			states.append(child)

			# set the state up with what they to function

		else:
			push_warning("Child " + child.name + "is not a State for CharacterStateMachine")

func check_if_can_move():
	return current_state.can_move
