extends "res://states/State.gd"

var timer : float = 0

func enter(character):
	.enter(character)
	
	var dict = character.transit_data	
	timer = dict.hit_stun
	

func update(character,delta):
	timer -= delta
	
	# Stun
	if timer > 0:
		return
		
	if character.is_on_floor():
		character.change_state("Knockdown")
	pass
	
	
func input(character,event):	
	# Stun
	if timer > 0:
		return
		
	# Recover
	if character.is_on_floor():
		character.change_state("Recover")
	else:
		character.change_state("AirRecover")
	pass


func on_hit(character, dict):
	dict.hit_stun =  max(timer, dict.hit_stun)
	.on_hit(character, dict)
