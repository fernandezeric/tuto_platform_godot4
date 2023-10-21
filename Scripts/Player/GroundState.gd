extends State

class_name GroundState

@export var JUMP_VELOCITY: float = -400.0
@export var air_state: State
@export var jump_animation: String = "jump"

func state_input(event: InputEvent):
  if(event.is_action_pressed("jump")):
    jump()

func jump():
  character.velocity.y = JUMP_VELOCITY
  next_state = air_state
  playback.travel(jump_animation)