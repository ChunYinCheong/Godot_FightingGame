extends "res://controllers/Controller.gd"

var action_map = {}

var aggressive = 100

func _ready():
	set_process(false)
	pass
	
func set_enabled(new_value):
	.set_enabled(new_value)
	set_process(new_value)
	pass

func _process(delta):
	aggressive = character.health
	var enemy : Character = character.opponent
	if enemy:
		var direction = enemy.global_position - character.global_position
		var distance = enemy.global_position.distance_to(character.global_position)
		#print(distance)
		if direction.x > 0:
			send_input("move_left",false)
			send_input("move_right",true)
		else:
			send_input("move_right",false)
			send_input("move_left",true)
			
		#print("distance:",distance)
		if distance < 100:
			send_input("punch",true)
		pass
	
	pass

func send_input(action,pressed):
	# print("send_input: ", action, " ", pressed)
	action_map[action] = pressed
	var ev = InputEventAction.new()
	ev.action = action
	ev.pressed = pressed	
	character.input(ev)


func get_action_strength(action):
	if enabled:
		if action_map.has(action):
			if action_map[action]:
				return 1
			else:
				return 0
	return 0

func is_action_pressed(action):
	if enabled:
		if action_map.has(action):
			return action_map[action]
	return false