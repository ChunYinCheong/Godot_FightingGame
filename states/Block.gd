extends "res://states/State.gd"

var _character
onready var timer = $Timer


func enter(character):	
	.enter(character)	
	_character = character
	var dict = character.transit_data
	character.knockback(dict.block_knockback)
	timer.wait_time = 0.2
	timer.start()

func exit(character):
	.exit(character)
	if not timer.is_stopped():
		timer.stop()
	
func on_hit(character, dict):
	var input = character.controller
	var x = -input.get_action_strength("move_left") + input.get_action_strength("move_right")
	if (character.facing > 0 and x < 0) or (character.facing < 0 and x > 0):
		character.change_state("Block", dict)
		return
	.on_hit(character, dict)
	pass
	

func _on_Timer_timeout():
	_character.change_state("Idle")
	pass # Replace with function body.
