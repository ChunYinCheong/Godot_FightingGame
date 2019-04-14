extends "res://states/Recover.gd"

func animation_finished(character,anim_name):
	character.change_state("Active_Jump")
	pass
