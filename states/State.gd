extends Node

onready var state_name : String = name

func _ready():
	pass
	
func enter(character: Character):	
	character.play_anim(state_name)
	pass
	
func update(character: Character,delta):   
	pass
	
func exit(character: Character):
	pass
	
func input(character : Character, event: InputEvent):
	if event.is_action_pressed("punch"):
		if state_name.ends_with('_Punch3'):
			return
		elif state_name.ends_with('_Punch2'):
			character.change_state("Startup_Punch3")
			return
		elif state_name.ends_with('_Punch'):
			character.change_state("Startup_Punch2")
			return
		else:
			character.change_state("Startup_Punch")
			return
		return
			
	if event.is_action_pressed("kick"):
		if state_name.ends_with('_Kick'):
			return
		character.change_state("Startup_Kick")
		return
		
	if event.is_action_pressed("special_punch"):
		character.change_state("Startup_SpecialPunch")
		return
			
	if event.is_action_pressed("special_kick"):
		character.change_state("Startup_SpecialKick")
		return
		
	if character.is_on_floor() and event.is_action_pressed("jump"):
		character.velocity.y = -character.jump_force
		character.change_state("Jump")
		return
	pass
	
func animation_finished(character : Character,anim_name : String):
	#print("State - animation_finished: ",anim_name)
	if state_name.begins_with('Startup_'):
		character.change_state(state_name.replace('Startup_','Active_'))
	elif state_name.begins_with('Active_'):
		character.change_state(state_name.replace('Active_','Recovery_'))
	elif state_name.begins_with('Recovery_'):
		character.change_state('Idle')
	pass
	
func hit(character: Character,area_id, area, area_shape, self_shape):
	pass
	
func on_hit(character: Character, area_shape, hit_by, damage, hit_stun, knockback, knockback_source, knockdown):
	var dict : Dictionary = {}
	dict.hit_by = hit_by
	dict.area_shape = area_shape
	dict.damage = damage
	dict.knockback = knockback
	dict.hit_stun = hit_stun
	dict.knockback_source = knockback_source
	dict.knockdown = knockdown
	character.state_data['hurt_data']=dict
	character.change_state("Hurt")
	#character.take_damage(hit_by,damage)
	#character.knockback(knockback)
	#character.velocity = knockback
	pass