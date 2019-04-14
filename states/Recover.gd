extends "res://states/State.gd"


func enter(character):
	.enter(character)
	#character.hurt_box.monitorable = false


func exit(character):
	.exit(character)
	character.hurt_box.monitorable = true

func animation_finished(character,anim_name):
	character.change_state("Idle")
	pass
