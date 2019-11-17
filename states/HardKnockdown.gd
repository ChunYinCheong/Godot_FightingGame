extends "res://states/State.gd"

var timer : float = 3

func enter(character):
	.enter(character)
	character.hurt_box.monitorable = false
	timer = 3
	pass
	
func update(character: Character,delta):   
	if character.is_on_floor():
		timer -= delta
		if timer <= 0:
			character.change_state("Knockdown")
	pass
