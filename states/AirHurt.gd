extends "res://states/Hurt.gd"

func enter(character):	
	.enter(character)
	
func update(character,delta):
	if character.is_on_floor():
		character.change_state("Knockdown")
		pass
	pass

func input(character, event):
	if timer.is_stopped():
		character.change_state("AirRecover")
		pass
	pass

func _on_Timer_timeout():
	pass