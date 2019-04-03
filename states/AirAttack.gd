extends "res://states/Attack.gd"

func update(character: Character,delta):   
	if character.is_on_floor():		
		character.change_state("Idle")
	pass