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
		character.change_state("Walk")
		return
			
	pass
	
func input(character,event):
	.input(character,event)
	
	if event.is_action("move_right") or event.is_action("move_left"):
		var move_dir = 0
		if character.controller.is_action_pressed("move_right"):
			move_dir += 1
		if character.controller.is_action_pressed("move_left"):
			move_dir -= 1
		if move_dir != 0:
			character.face(move_dir)
			character.change_state("Walk")
			return
	

	
	
	
	
	