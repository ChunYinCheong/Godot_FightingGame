extends "res://states/State.gd"

var _character
onready var timer = $Timer

func enter(character):	
	.enter(character)	
	
	_character = character
	var dict = character.transit_data	
	timer.wait_time = dict.hit_stun
	timer.start()	
	pass	
	

func update(character,delta):
	if not character.is_on_floor():
		
		var dict = {"hit_stun": timer.time_left, "on_hit": false}
		
		character.change_state("AirHurt")
		pass
	pass

func exit(character):
	.exit(character)
	if not timer.is_stopped():
		timer.stop()
	
func on_hit(character, dict):
	dict.hit_stun =  max(timer.time_left,dict.hit_stun)
#	.on_hit(character, dict)
#	character.play_anim("Hurt")
#	if timer.time_left < dict.hit_stun:
#		timer.stop()
#		timer.wait_time = dict.hit_stun
#		timer.start()
#
#	character.take_damage(dict.hit_by,dict.damage)
#	character.knockback(dict.knockback,dict.hit_by)
#	hit_count = hit_count + 1
#	character.get_node("Debug/Label").text = "%s Hit!" % hit_count
#
#	pass


func _on_Timer_timeout():
	_character.change_state("Idle")
	pass # replace with function body
