extends "res://states/State.gd"


func enter(character: Character):	
	.enter(character)
	if not character.is_on_floor():
		character.change_state("Active_Jump")
		return
	
	var input = character.controller
	var x = -input.get_action_strength("move_left") + input.get_action_strength("move_right")
	if x != 0:
		character.change_state("Walk")
		return
		
	character.velocity.x = 0
	pass
	

func update(character,delta):
	if not character.is_on_floor():
		character.change_state("Active_Jump")
		return
	character.face_opponent()
	pass
	
func input(character,event):
	.input(character,event)
	
	if event.is_action("move_right") or event.is_action("move_left"):
		var input = character.controller
		var x = -input.get_action_strength("move_left") + input.get_action_strength("move_right")
		if x != 0:
			character.change_state("Walk")
		return
