extends "res://states/State.gd"

var _character
onready var timer : Timer = $Timer

func enter(character):	
	.enter(character)	
	
	_character = character
	var dict = character.transit_data	
	timer.wait_time = dict.hit_stun
	timer.start()	
	pass

func update(character,delta):
	if not character.is_on_floor():		
		var dict = {"hit_stun": timer.time_left}		
		character.change_state("AirHurt", dict)
		pass
	pass

func exit(character):
	.exit(character)
	if not timer.is_stopped():
		timer.stop()

func input(character, event):
	# Block input
	pass

func on_hit(character, dict):
	dict.hit_stun =  max(timer.time_left,dict.hit_stun)
	.on_hit(character, dict)

func _on_Timer_timeout():
	_character.change_state("Idle")
	pass # replace with function body
