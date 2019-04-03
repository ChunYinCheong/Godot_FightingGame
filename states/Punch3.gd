extends "res://states/Attack.gd"

func _ready():
	knockback = Vector2(200,0)
	
	pass

func input(character , event):

	if event.is_action_pressed("kick"):
		character.change_state("Kick")
		return
		
	if event.is_action_pressed("special_punch"):
		character.change_state("SpecialPunch")
		return
			
	if event.is_action_pressed("special_kick"):
		character.change_state("SpecialKick")
		return
	
	if character.is_on_floor() and event.is_action_pressed("jump"):
		character.velocity.y = -character.jump_force
		character.change_state("Jump")
		return
	
	
	
	
	