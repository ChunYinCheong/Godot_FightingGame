extends "res://controllers/Controller.gd"

func contoller_ready():
	.contoller_ready()
	#print("Plater Contolller ready")
	set_process_unhandled_input(true)
	pass

func _unhandled_input(event : InputEvent ):
	if character:
		character.input(event)	
	pass

func is_action_pressed(action):
	return Input.is_action_pressed(action)
	