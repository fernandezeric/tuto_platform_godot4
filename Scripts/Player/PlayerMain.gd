extends CharacterBody2D

class_name Character

@export var SPEED: float = 200.0

# @onready var ap: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var sprite: Sprite2D = $Sprite2D

@onready var cshape = $CollisionShape2D
@onready var crouch_raycast1 = $CrouchRaycast_1
@onready var crouch_raycast2 = $CrouchRaycast_2

@onready var player_movement: PlayerMovement = $Movement
@onready var player_attack: PlayerAttack = $Attack
@onready var state_machine: CharacterStateMachine = $CharacterStateMachine

# crouch
var bool_axis_x: bool = false
var is_crouching: bool = false
var stuck_under_object: bool = false

# stamina
var stamina: int = 100
var max_stamina: int = 100
var jump_stamina: int = 50

# axis
var direction_move: Vector2 = Vector2.ZERO

# collition shape
var standing_cshape = preload("res://Assets/Resources/collisionShape/player_standing.tres")
var crouching_cshape = preload("res://Assets/Resources/collisionShape/player_crouch.tres")

# correction px flip h
var flip_h_px: int = 5

# wall
var in_wall: bool = false

func _ready():
	animation_tree.active = true
	player_movement.setup(self)

# For see variables
func _process(delta):
	# print("is_on_wall_only()", is_on_wall_only())
	# print("is_on_wall", is_on_wall())
	pass

func _physics_process(delta: float) -> void:
	direction_move = Input.get_vector("left_move", "right_move", "up_move", "down_move")
	# print(direction_move)
	face_direction(direction_move.x)
	player_movement.update(delta)
	update_crouching()
	#update_stamina()
	# calculan cosas
	move_and_slide()
	# el frame como tal
	update_animation_parameters(direction_move)
func update_stamina():
	if stamina < max_stamina:
		stamina += 1

func face_direction(axis_x):
	if axis_x != 0:
		bool_axis_x = (axis_x == -1)
		sprite.flip_h = bool_axis_x
		sprite.position.x = axis_x * flip_h_px if bool_axis_x else axis_x

func above_head_is_empty() -> bool:
	var result = !crouch_raycast1.is_colliding() && !crouch_raycast2.is_colliding()
	return result

func update_animation_parameters(direction):
	animation_tree.set("parameters/Move/blend_position", direction.x)
	pass
#	if Input.is_action_just_pressed("attack"):
#		ap.play("attack")
#	elif is_on_floor():
#		if horizontal_direction == 0:
#			if is_crouching:
#					ap.play("crouch")
#			else:
#				ap.play("idle")
#		else:
#			if is_crouching:
#				ap.play("crouch_walk")
#			else:
#				ap.play("run")
#	elif is_on_wall_only() && !is_crouching:
#		ap.play("wall_hang")
#	else:
#		if velocity.y < 0:
#			ap.play("jump")
#		elif velocity.y > 0:
#			ap.play("fall")

func update_crouching():
	if Input.is_action_just_pressed("crouch") and not is_on_wall_only() and is_on_floor():
		crouch()
	elif Input.is_action_just_released("crouch"):
		if above_head_is_empty():
			stand()
		else:
			if stuck_under_object != true:
				stuck_under_object = true

	if stuck_under_object && above_head_is_empty():
		stand()
		stuck_under_object = false

func crouch():
	if is_crouching:
		return
	is_crouching = true
	cshape.shape = crouching_cshape
	cshape.position.y = -12

func stand():
	if is_crouching == false:
		return
	is_crouching = false
	cshape.shape = standing_cshape
	cshape.position.y = -19
