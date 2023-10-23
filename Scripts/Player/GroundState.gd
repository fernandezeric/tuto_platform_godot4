extends State

class_name GroundState

#@onready var cshape = $CollisionShape2D
#@onready var crouch_raycast1 = $CrouchRaycast_1
#@onready var crouch_raycast2 = $CrouchRaycast_2

@export var JUMP_VELOCITY: float = -400.0

@export var air_state: State
@export var attack_state: State

@export var jump_animation: String = "jump"
@export var crouch_animation: String = "crouch"
@export var attack_animation: String = "attack_1"

func state_input(event: InputEvent):
  if(event.is_action_pressed("jump")):
    jump()
  if(event.is_action_pressed("crouch")):
    playback.travel(crouch_animation)
  elif(event.is_action_released("crouch")):
    playback.travel("move")
  if(event.is_action_pressed("attack")):
    attack()

func jump():
  character.velocity.y = JUMP_VELOCITY
  next_state = air_state
  playback.travel(jump_animation)

func attack():
  next_state = attack_state
  playback.travel(attack_animation)