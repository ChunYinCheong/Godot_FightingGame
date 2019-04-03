extends Node

#export (NodePath) var character
var character : Character

func contoller_ready():
	#print("Controller _ready")
	character = get_parent()
	pass
	
func is_action_pressed(action):
	return false
	