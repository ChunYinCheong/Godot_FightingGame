extends "res://states/State.gd"

var _character
onready var timer = $Timer
var hit_count = 0
var knockdown = false

func enter(character):	
	.enter(character)	
	
	knockdown = false
	hit_count = 0
	_character = character
	var dict = character.state_data.get('hurt_data')
	on_hit(character, dict.area_shape, dict.hit_by, dict.damage, dict.hit_stun, dict.knockback, dict.knockback_source, dict.knockdown)
	#character.take_damage(dict.hit_by,dict.damage)
	#character.knockback(dict.knockback)	
	#timer.wait_time = dict.hit_stun
	#timer.start()	
	pass	
	

func update(character,delta):
	if self.knockdown and character.is_on_floor():
		#Knockdown
		character.change_state("Knockdown")
		pass
	pass
	
func on_hit(character, area_shape, hit_by, damage, hit_stun, knockback, knockback_source, knockdown):
	self.knockdown = self.knockdown or knockdown
	if self.knockdown:
		character.play_anim("Knockdown")
	else:
		character.play_anim("Hurt")
	character.take_damage(hit_by,damage)
	character.knockback(knockback,hit_by)
	hit_count = hit_count + 1
	character.get_node("Debug/Label").text = "%s Hit!" % hit_count
	
	if timer.time_left < hit_stun:
		timer.stop()
		timer.wait_time = hit_stun
		timer.start()
	pass


func _on_Timer_timeout():
	if not self.knockdown:
		_character.change_state("Idle")
	pass # replace with function body
