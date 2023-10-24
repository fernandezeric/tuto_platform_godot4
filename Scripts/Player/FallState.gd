extends State

class_name FallState

@export var fall_animation_name: String = "fall"
@export var ground_animation_name: String = "move"
@export var ground_state: State

func state_process(delta):
  if(character.is_on_floor()):
    next_state = ground_state
    playback.travel(ground_animation_name)

func on_exit():
  playback.next()
