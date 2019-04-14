extends "res://states/State.gd"

func update(character,delta):
#	var input = character.controller
#	var x = -input.get_action_strength("move_left") + input.get_action_strength("move_right")
#	print("Startup_Jump - update: ", x)
	
	pass

func animation_finished(character : Character,anim_name : String):
	var input = character.controller
	var x = -input.get_action_strength("move_left") + input.get_action_strength("move_right")
	var y = min(-input.get_action_strength("jump"), -0.5)
	var dict = {}
	dict["jump_direction"] = Vector2(x, y)	
	character.change_state('Active_Jump', dict)


func input(character,event):	
#	if event.is_action("move_left") or event.is_action("move_right"):
#		var input = character.controller
#		var x = -input.get_action_strength("move_left") + input.get_action_strength("move_right")
#		print("Startup_Jump - input: ", x)
#		#character.state_data[state_name]
#		return	
	.input(character,event)
	return
		
		
		