extends State

class_name LandingState

@export var landing_animation_name: String = "fall"#"landing"
@export var ground_state: State

func _on_animation_tree_animation_finished(anim_name:StringName):
  if(anim_name == landing_animation_name):
    next_state = ground_state
