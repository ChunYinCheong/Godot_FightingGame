extends "res://controllers/Controller.gd"

func _ready():
	set_process_unhandled_input(false)
	pass

func set_enabled(new_value):
	.set_enabled(new_value)
	set_process_unhandled_input(new_value)
	pass

func _unhandled_input(event : InputEvent ):
	if character:
		character.input(event)	
	pass

func get_action_strength(action:String):
	if enabled:
		return Input.get_action_strength(action)
	return 0

func is_action_pressed(action:String):
	if enabled:
		return Input.is_action_pressed(action)
	return false
	