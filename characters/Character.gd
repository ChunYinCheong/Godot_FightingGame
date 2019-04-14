extends KinematicBody2D

class_name Character

signal dies

onready var anim_player : AnimationPlayer = $AnimationPlayer
onready var sprite = $Sprite
onready var hit_box : Area2D = $HitBox
onready var hurt_box : Area2D= $HurtBox

onready var controller = $Controller
enum ControllerType {DEFAULT, PLAYER, AI, OTHER}
enum ControllerEnum {DEFAULT, PLAYER, AI, OTHER}
var controller_type = ControllerType.DEFAULT

export (NodePath) var init_state
var state
var state_map : Dictionary = {}
var state_data : Dictionary = {}
var transit_data : Dictionary = {}

var move_speed : float = 300 #500
var forward_move_speed : float = 300
var backward_move_speed : float = 200
var jump_force : float = 1000
var gravity : float = 2000

var facing_right : bool = true
var facing : int = 1

var velocity : Vector2 = Vector2()
var floor_normal : Vector2 = Vector2(0, -1)
var x_velocity : Vector2 = Vector2()
var y_velocity : Vector2 = Vector2()
var _is_on_floor : bool = false
var _is_on_wall : bool = false

var knockbackVelocity : Vector2 = Vector2()
var knockbackDeceleration : float = 3.0
var knockbackCutoff : float = 4.0
var knockback_source = null

var health : float = 1000

var opponent : Character

func _init():
	#print("Init Character")
	pass

func _ready():
	self.change_controller()
	
	for node in $StateMachine.get_children():
		state_map[node.name] = node
	state = get_node(init_state)
	state.enter(self)
	
func change_controller():
	var dc = $Controller/DefaultController
	var pc = $Controller/PlayerController
	var ac = $Controller/AiController
	if controller_type == ControllerType.DEFAULT:
		self.controller = dc
		dc.enabled = true
		ac.enabled = false
		pc.enabled = false
	elif controller_type == ControllerType.AI:
		self.controller = ac
		dc.enabled = false
		ac.enabled = true
		pc.enabled = false
	elif controller_type == ControllerType.PLAYER:
		self.controller = pc
		dc.enabled = false
		ac.enabled = false
		pc.enabled = true
	else:
		pass	
	
func input(event : InputEvent ):
	state.input(self,event)
	pass
	
func _process(delta):
	$Debug/Label2.text = str(health)
	pass

func _physics_process(delta):
	if(knockbackVelocity.length() > 0):
		# Use lerp to decelerate knockback velocity
		var lerpWeight = knockbackDeceleration*delta
		knockbackVelocity.x = lerp(knockbackVelocity.x, 0.0, lerpWeight)
		knockbackVelocity.y = lerp(knockbackVelocity.y, 0.0, lerpWeight)
		if(knockbackVelocity.length() < knockbackCutoff):
			knockbackVelocity = Vector2()
			knockback_source = null
		
	
	x_velocity.x = velocity.x + knockbackVelocity.x
	var x_collision = move_and_collide(x_velocity * delta)
	if x_collision:
		#if x_collision.collider is preload("res://characters/Character.gd"):
		#if x_collision.collider is get_script():
		if x_collision.collider.has_method("on_push"):
			x_collision.collider.move_and_collide(x_collision.remainder)
			pass
		else:
			# collide with wall
			if knockback_source:
				knockback_source.move_and_collide(Vector2(-x_collision.remainder.x, 0))
			pass			
		pass
	else:
		_is_on_wall = false
		pass
	
	y_velocity.y = velocity.y + knockbackVelocity.y
	var y_collision = move_and_collide(y_velocity * delta)
	if y_collision:
		if y_collision.collider.has_method("on_push"):
			var old_pos = self.position
			var opponent = y_collision.collider
			var y_remainder = y_collision.remainder
			var distance = abs(self.position.x - opponent.position.x)
			var self_x = $CollisionShape2D.shape.extents.x
			var opps_x = opponent.get_node("CollisionShape2D").shape.extents.x
			var push_x = self_x + opps_x - distance
			var margin = 1#3
			var x = ceil( (push_x + margin)  / 2)
#			print(push_x," / ",x," // ",y_collision.remainder)
			if self.position.x + x_velocity.x > y_collision.collider.position.x:
				x = -x
			else:
				x = x
			var self_collision = move_and_collide(Vector2(-x,0))
			if self_collision:
				opponent.move_and_collide(Vector2(-self_collision.remainder.x,0))
			var opp_collision = opponent.move_and_collide(Vector2(x,0))
			if opp_collision:
				move_and_collide(Vector2(-opp_collision.remainder.x,0))
#			print(distance , " / ", self_x , " / ", opps_x , " / " ,  push_x)
#			print(self.position , " / " , opponent.position, " / " , self.position.x - opponent.position.x)
#			print(y_remainder)
			var y2 = move_and_collide(y_remainder)
			if y2:
				print("Character - _physics_process - Fail: " , y2.remainder," / ",old_pos, " / ")
			_is_on_floor = false
			pass			
		else:
			y_velocity.y = y_collision.remainder.y			
			_is_on_floor = true
	elif y_velocity:
		_is_on_floor = false
	else:
		# Do Nothing Vector2(0,0)
		pass
	y_velocity.y += delta * gravity	
	velocity.y = y_velocity.y
	#var max_y_velcoity = 10000
	#if y_velocity.y > max_y_velcoity:
	#	y_velocity.y = max_y_velcoity
		
	state.update(self,delta)
	$Debug/Label3.text = "is_on_floor(): " + str(self.is_on_floor()) + " / " + str(_is_on_floor)
	$Debug/Label4.text = str(velocity.x," / "	,velocity.y)
	$Debug/Label5.text = str(get_transform())
	
	pass

func is_on_floor():
	return _is_on_floor #or .is_on_floor()
	
	
func on_push(remainder):
	move_and_collide(remainder)
	pass
	
func knockback(vel, source):
	knockbackVelocity = vel
	knockback_source = source
	# g / 60 *  (-g +- sqrt(g^2 + 4*g*7200*t)) / 2g
	# (-g +- sqrt(g^2 + 4*g*7200*t)) / 120
	var temp = sqrt(gravity*gravity-4*gravity*7200*knockbackVelocity.y)
	print(gravity*gravity-4*gravity*7200*knockbackVelocity.y," ? ",temp)
	var result1 = (-gravity + temp)/120
	var result2 = (-gravity - temp)/120
	print(result1," // ",result2)
	velocity.y = result1
	if knockbackVelocity.y < 0:
		velocity.y = -velocity.y
	print(knockbackVelocity.y," => ",velocity.y)
	#velocity.y = knockbackVelocity.y
	#velocity.y = -500
	knockbackVelocity.y = 0
	pass


func face_opponent():
	if self.opponent:
		var d = self.opponent.global_position - self.global_position
		if (d.x > 0 and self.facing < 0) or (d.x < 0 and self.facing > 0):
			self.face(d.x)
		

func face(dir):
	if facing_right and dir < 0:
		flip()
	if !facing_right and dir > 0:
		flip()
	pass

func flip():
	facing_right = !facing_right
	sprite.flip_h = !sprite.flip_h
	facing = facing * -1
	# Set to negative MAY cause problem
	# Fix it if needed
	hit_box.set_scale(Vector2(facing,1))
	hurt_box.set_scale(Vector2(facing,1))	
 
func play_anim(anim_name):
	if not anim_player.has_animation(anim_name):
		print("Animation Not Found: " , anim_name)
		if OS.is_debug_build():
			breakpoint
	anim_player.play(anim_name)

func change_state(state_name, dict : Dictionary = {}):
#	print("change_state: " , state_name)
	if not state_map.has(state_name):
		print("State Not Found: " , state_name)
		if OS.is_debug_build():
			breakpoint
		else:
			# Keep the game run
			return
		
	var next_state = state_map[state_name]
	if next_state:
		state.exit(self)
		if dict: # Not empty
			self.transit_data = dict
		else:
			self.transit_data = {}
		state = next_state
		next_state.enter(self)
		$Debug/Label.text = state_name
	
	

func _on_AnimationPlayer_animation_finished(anim_name):
	state.animation_finished(self,anim_name)
	pass # replace with function body


func _on_HitBox_area_shape_entered(area_id, area, area_shape, self_shape):
	if area != hurt_box: # Not hitting self
#		print("Character hit: %s %s %s %s %s" % [self , area_id, area , area_shape, self_shape])
		state.hit(self , area_id, area, area_shape, self_shape)
	pass # replace with function body
	
func on_hit(dict):
	state.on_hit(self, dict)
	pass
	
func take_damage(source,damage):
	print("take_damage: %s %s" % [source,damage])
	self.health -= damage
	if health <= 0:
		#killed(source)	
		change_state("Ko")
		emit_signal("dies")
		pass
	pass

func killed(source):
	#queue_free()
	pass
	
