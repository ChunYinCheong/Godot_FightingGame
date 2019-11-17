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
#	character.transit_data.clear()
	pass
	
func input(character : Character, event: InputEvent):		
	if character.is_on_floor():
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
			if state_name.ends_with('_SpecialPunch'):
				return
			character.change_state("Startup_SpecialPunch")
			return
				
		if event.is_action_pressed("special_kick"):
			if state_name.ends_with('_SpecialKick'):
				return
			character.change_state("Startup_SpecialKick")
			return
			
		if event.is_action_pressed("jump"):
			character.change_state("Startup_Jump")
			return
		return
	else: #Not on floor
		if event.is_action_pressed("punch"):
			if state_name.ends_with('_AirPunch'):
				return
			character.change_state("Startup_AirPunch")
			return
				
		if event.is_action_pressed("kick"):
			if state_name.ends_with('_AirKick'):
				return
			character.change_state("Startup_AirKick")
			return
			
		if event.is_action_pressed("special_punch"):
			if state_name.ends_with('_AirSpecialPunch'):
				return
			character.change_state("Startup_AirSpecialPunch")
			return
				
		if event.is_action_pressed("special_kick"):
			if state_name.ends_with('_AAirSpecialKick'):
				return
			character.change_state("Startup_AirSpecialKick")
			return
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
	
func on_hit(character: Character, dict: Dictionary):
	print("on_hit: ", name)
	
	var hit_count = character.transit_data.get("hit_count", 0) + 1
	var t_dict = {"hit_count": hit_count, "hit_stun": dict.hit_stun}
		
	if dict.hard_knockdown:
		character.change_state("HardKnockdown", t_dict)
	elif dict.soft_knockdown:
		character.change_state("SoftKnockdown", t_dict)
	elif not character.is_on_floor():
		character.change_state("AirHurt", t_dict)
	else:
		character.change_state("Hurt", t_dict)
	
	
	# take_damage will change to Ko state if character dies
	character.take_damage(dict.hit_by,dict.hit_damage)
	if dict.hit_knockback.x != 0:
		if character.is_on_wall():
			if  dict.hit_knockback.x > 0 and character.is_on_right_wall():
				var ks = dict.knockback_source
				ks.knockback(dict.reknockback)
			elif dict.hit_knockback.x < 0 and character.is_on_left_wall():
				var ks = dict.knockback_source
				ks.knockback(dict.reknockback)
	character.knockback(dict.hit_knockback)
		
	
	
	character.get_node("Debug/Label6").text = "%s Hit!" % hit_count
	pass
	
	
	
	
	
	
	
	
	