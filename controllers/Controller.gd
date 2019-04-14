extends Node

var character
var enabled : bool = false setget set_enabled

func _ready():
	character = get_parent().get_parent()
	pass
	
func set_enabled(new_value):
	enabled = new_value
	pass
	
func get_action_strength(action:String):
	return 0
	
func is_action_pressed(action):
	return false
	