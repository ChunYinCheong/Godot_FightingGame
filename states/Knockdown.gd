extends "res://states/State.gd"

var _character
onready var timer : Timer = $Timer

func enter(character):
	.enter(character)
	
	_character = character
	character.hurt_box.monitorable = false
	timer.wait_time = 2
	timer.start()	

func exit(character):
	.exit(character)
	if not timer.is_stopped():
		timer.stop()

func input(character,event):	
	# Recover
	if not character.anim_player.is_playing():
		character.change_state("Recover")
	pass

func _on_Timer_timeout():
	_character.change_state("Recover")
	pass # Replace with function body.
