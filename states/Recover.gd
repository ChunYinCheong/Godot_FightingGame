extends "res://states/State.gd"

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
	

func animation_finished(character,anim_name):
	character.change_state("Idle")
	pass
