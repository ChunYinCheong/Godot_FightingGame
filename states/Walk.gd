extends "res://states/State.gd"

func update(character,delta):
	var move_dir = 0
	if character.controller.is_action_pressed("move_right"):
		move_dir += 1
	if character.controller.is_action_pressed("move_left"):
		move_dir -= 1
	character.velocity.x = move_dir * character.move_speed

	if not character.is_on_floor():
		character.change_state("Jump")
		return
		
	if move_dir != 0:
		character.face(move_dir)
	else:
		character.change_state("Idle")
		
	pass
	
func exit(character,dict=null):
	character.velocity.x = 0
	pass

	