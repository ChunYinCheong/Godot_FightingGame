extends "res://states/State.gd"

func update(character,delta):
	var move_dir = 0
	if character.controller.is_action_pressed("move_right"):
		move_dir += 1
	if character.controller.is_action_pressed("move_left"):
		move_dir -= 1
	character.velocity.x = move_dir * character.move_speed
	
	if move_dir != 0:
		character.face(move_dir)
		pass
	
	if character.is_on_floor():
		character.change_state("Idle")
		return
	
	pass


func input(character,event):
	if event.is_action_pressed("punch"):
		character.change_state("AirPunch")
		return
			
	if event.is_action_pressed("kick"):
		character.change_state("AirKick")
		return
		
	if event.is_action_pressed("special_punch"):
		character.change_state("AirSpecialPunch")
		return
			
	if event.is_action_pressed("special_kick"):
		character.change_state("AirSpecialKick")
		return