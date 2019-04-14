extends MarginContainer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	$HBoxContainer/VBoxContainer/MenuButton/StartButton.grab_focus()
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_StartButton_pressed():
	Global.character_controller_2 = Character.ControllerType.AI	
	get_tree().change_scene("res://Battle.tscn")
	pass # replace with function body


func _on_PracticeButton_pressed():
	Global.character_controller_2 = Character.ControllerType.DEFAULT
	get_tree().change_scene("res://Battle.tscn")
	pass # Replace with function body.

func _on_OptionButton_pressed():
	pass # replace with function body


func _on_EndButton_pressed():
	get_tree().quit()
	pass # replace with function body

