extends "res://states/State.gd"

var timer : float = 3

func enter(character):
	.enter(character)
	
	character.hurt_box.monitorable = false
	timer = 3

func update(character,delta):
	timer -= delta
	if timer <= 0:
		character.change_state("Recover")
	pass

func input(character,event):	
	# Recover
	if not character.anim_player.is_playing():
		character.change_state("Recover")
	pass
