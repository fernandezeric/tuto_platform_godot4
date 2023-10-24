extends State

class_name AirState

@export var AIR_JUMP_VELOCITY: float = -200.0
@export var fall_state: State
@export var ground_state: State
@export var fall_animation_name: String = "fall"
@export var air_animation_name: String = "jump"
@export var ground_animation_name: String = "move"

var has_double_jump: bool = false

func state_process(delta):
  if(character.is_on_floor()):
    next_state = ground_state

func state_input(event: InputEvent):
  if (event.is_action_pressed("jump") and has_double_jump != true):
    double_jump()

func on_exit():
  if(next_state == ground_state):
    playback.travel(ground_animation_name)
    has_double_jump = false


func double_jump():
  character.velocity.y = AIR_JUMP_VELOCITY
  playback.travel(air_animation_name)
  has_double_jump = true

func _on_animation_tree_animation_finished(anim_name:StringName):
  if(anim_name == air_animation_name):
    next_state = fall_state
    playback.travel(fall_animation_name)