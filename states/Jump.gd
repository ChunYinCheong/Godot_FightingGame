extends "res://states/State.gd"

func enter(character):	
	.enter(character)
	if character.transit_data.has("jump_direction"):
		var jd : Vector2 = character.transit_data.get("jump_direction")
		# character.velocity.y = -character.jump_force
		#var temp = jd.normalized() * character.jump_force
		character.velocity.y = jd.y * character.jump_force
		character.velocity.x = jd.x * character.move_speed
	pass
	


func update(character,delta):
	if character.is_on_floor():
		character.change_state("Idle")
		return
	pass

func animation_finished(character : Character,anim_name : String):
	# Hold the animation
	pass
