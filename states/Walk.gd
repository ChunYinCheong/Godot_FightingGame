extends "res://states/State.gd"

func update(character,delta):
	if not character.is_on_floor():
		character.change_state("Active_Jump")
		return
		
	var input = character.controller
	var x = -input.get_action_strength("move_left") + input.get_action_strength("move_right")
	if (character.facing > 0 and x > 0) or (character.facing < 0 and x < 0):
		character.velocity.x = x * character.forward_move_speed
	elif (character.facing > 0 and x < 0) or (character.facing < 0 and x > 0):
		character.velocity.x = x * character.backward_move_speed
		
	if x == 0:
		character.change_state("Idle")
		return
		
	character.face_opponent()		
	pass
	
func exit(character):
	.exit(character)
	character.velocity.x = 0
	pass


func on_hit(character, dict):
	var input = character.controller
	var x = -input.get_action_strength("move_left") + input.get_action_strength("move_right")
	if (character.facing > 0 and x < 0) or (character.facing < 0 and x > 0):
		character.change_state("Block", dict)
		return
	.on_hit(character, dict)
	pass
	