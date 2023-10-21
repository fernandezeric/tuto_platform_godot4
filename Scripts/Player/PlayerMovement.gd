extends Node2D
class_name PlayerMovement

@export var GRAVITY: float = 980.0
@export var ACCELERATION: int = 12000
@export var FRICTION: int = 12000
@export var AIR_ACCELERATION: int = ACCELERATION >> 1
@export var AIR_FRICTION: int = FRICTION >> 1
@export var JUMP_VELOCITY: float = -400.0

var player: Character
var tick: float = 0
var air_jump: bool = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
# var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func setup(body):
	player = body

func update(delta):
	tick = delta
	update_gravity()
	move()
	#wall_slide()

func move():
	# if player.is_on_wall(): return

	if player.direction_move.x != 0 and player.state_machine.check_if_can_move():
		player.velocity.x = move_toward(player.direction_move.x, player.direction_move.x * player.SPEED, ACCELERATION * tick)
	elif player.direction_move.x == 0:
		player.velocity.x = move_toward(player.direction_move.x, 0.0, FRICTION * tick)

	#if Input.is_action_just_pressed("jump") and player.is_on_floor():
	#	player.velocity.y = JUMP_VELOCITY
	#	air_jump = true
	#elif Input.is_action_just_pressed("jump") and not player.is_on_floor() and air_jump:
	#	player.velocity.y = JUMP_VELOCITY * 0.5
	#	air_jump = false
	
func update_gravity():
	if not player.is_on_floor():
		player.velocity.y += GRAVITY * tick
		player.velocity.y = clampf(player.velocity.y, ACCELERATION * -1, GRAVITY)
	elif player.is_on_wall_only(): # pensar bien donde cambiar
		player.velocity.y += (GRAVITY * tick) * 0.25
		player.velocity.y = clampf(player.velocity.y, (ACCELERATION * -1) * 0.25, GRAVITY)

func wall_slide():
	if not player.is_on_wall_only(): return
	
	if if_facing_wall(): return

	if player.velocity.y >= 0:
		player.velocity.y = 0 #player.velocity.y * 0.5
	
	# print(Input.is_action_pressed("down_move"))
	if Input.is_action_pressed("down_move"):
		player.velocity.y = 10

func if_facing_wall():
	return player.get_wall_normal().x == player.velocity.x ## viendo la dirección de la pared, confirmar
