extends State

#@export var attack_animation_names: Array[String] = ["attack_1", "attack_2"] # if(attack_animation_names.find(anim_name) != -1)
@export var attack_1_anim_name: String = "attack_1"
@export var attack_2_anim_name: String = "attack_2"

@export var ground_animation_name: String = "move"

@export var ground_state: State

@onready var timer: Timer = $Timer

func state_input(event: InputEvent):
  if(event.is_action_pressed("attack")):
    timer.start()

func _on_animation_tree_animation_finished(anim_name:StringName):
  if(attack_1_anim_name == anim_name):
    if(timer.is_stopped()):
      next_state = ground_state
      playback.travel(ground_animation_name)
    else:
      playback.travel(attack_2_anim_name)
  
  if(attack_2_anim_name == anim_name):
    next_state = ground_state
    playback.travel(ground_animation_name)
    