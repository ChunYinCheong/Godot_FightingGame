extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var character_instance_1 : Character
var character_instance_2 : Character


# Called when the node enters the scene tree for the first time.
func _ready():
	character_instance_1 = load(Global.character1).instance()
	character_instance_1.controller_type = Global.character_controller_1
	character_instance_1.set_name("character1")
	character_instance_1.global_position = $World/Position2D.global_position
	
	character_instance_2 = load(Global.character2).instance()
	character_instance_2.controller_type = Global.character_controller_2
	character_instance_2.set_name("character2")
	character_instance_2.global_position = $World/Position2D2.global_position
	
	character_instance_1.opponent = character_instance_2
	character_instance_2.opponent = character_instance_1
	$World.add_child(character_instance_1)
	$World.add_child(character_instance_2)
	character_instance_1.face(1)
	character_instance_2.face(-1)
	
	character_instance_1.controller.enabled = false
	character_instance_2.controller.enabled = false
	
	character_instance_1.connect("dies",self,"_on_Character_dies")
	character_instance_2.connect("dies",self,"_on_Character_dies")
	#Engine.time_scale = 0.5
	pass # Replace with function body.

func _on_Character_dies():
	character_instance_1.controller.enabled = false
	character_instance_2.controller.enabled = false
	get_tree().paused = true
	$AnimationPlayer.play("ko")
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$MarginContainer/HBoxContainer/HBoxContainer/TextureProgress.value = character_instance_1.health
	$MarginContainer/HBoxContainer/HBoxContainer2/TextureProgress2.value = character_instance_2.health
	pass

func _input(event):
	if event.is_action("slow") and event.is_pressed():
		Engine.time_scale = max(0, Engine.time_scale - 0.1)
	if event.is_action("fast") and event.is_pressed():
		Engine.time_scale = Engine.time_scale + 0.1
	if event.is_action_pressed("stop"):
		Engine.time_scale = 0
	if event.is_action_pressed("reset"):
		Engine.time_scale = 1


			

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "ko":
		get_tree().paused = false
		$AnimationPlayer.play("wait")
	if anim_name == "start":
		character_instance_1.controller.enabled = true
		character_instance_2.controller.enabled = true		
		pass
	if anim_name == "wait":
		get_tree().change_scene("res://menus/MainMenu.tscn")
	pass # Replace with function body.
