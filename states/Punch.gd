extends "res://states/Attack.gd"


func input(character, event):

	if event.is_action_pressed("punch"):
		character.change_state("Startup_Punch2")
		return
		
	.input(character, event)	
