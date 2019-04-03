extends "res://controllers/Controller.gd"

var action_map = {}
var enemy_ref

var aggressive = 100


func contoller_ready():
	.contoller_ready()
	#print("Plater Contolller ready")
	set_process(true)
	enemy_ref = weakref(get_node("/root/Node2D/Red"))
	pass

func _process(delta):
	aggressive = character.health
	var enemy : Character = enemy_ref.get_ref()
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
			return
			if randi() % 2 > 0:
				send_input("punch",true)
			else:
				send_input("kick",true)
			pass
		pass
	
	pass

func send_input(action,pressed):
	action_map[action] = pressed
	var ev = InputEventAction.new()
	ev.action = action
	ev.pressed = pressed	
	character.input(ev)

func is_action_pressed(action):
	if action_map.has(action):
		return action_map[action]
	return false