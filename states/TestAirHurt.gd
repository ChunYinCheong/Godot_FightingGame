extends "res://states/TestHurt.gd"

func enter(character):	
	.enter(character)	
	
	var dict = character.transit_data
#	hit_count = dict.get("hit_count	", 0)
#	timer.wait_time = dict.hit_stun
#	timer.start()
#	on_hit(character, dict)
	pass	
	

func update(character,delta):
	if character.is_on_floor():
		#Knockdown
		character.change_state("Knockdown")
		pass
	pass

func exit(character):
	.exit(character)
	if not timer.is_stopped():
		timer.stop()

func input(character, event):
	if timer.is_stopped():
		# Air recover
		pass
	pass
