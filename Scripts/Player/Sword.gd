extends Area2D

@export var damage_sword: float = 10
@export var character: Character
@export var facing_shape: FacingCollitionShape

func _ready():
	monitoring = false
	character.connect("facing_direction_changed", _on_player_facing_direction_change)

func _on_body_entered(body:Node2D):
	print("##################")
	print("body: ", body)
	print("body.name: ", body.name)
	print("body.get_children(): ", body.get_children())
	print("##################")
	#print("get_parent(): ", get_parent().crouch_raycast1.is_colliding()) -> acceso al raycast para above_head
	for child in body.get_children():
		if child is Damageable:
			# Get direction from sword
			var direction_to_damageable = (body.global_position - get_parent().global_position)
			var direction_sign = sign(direction_to_damageable.x)

			if(direction_sign > 0):
				child.hit(damage_sword, Vector2.RIGHT)
			elif(direction_sign < 0):
				child.hit(damage_sword, Vector2.LEFT)
			else:
				child.hit(damage_sword, Vector2.ZERO)
			
			print("damage_sword: ", damage_sword)

func _on_player_facing_direction_change(facing_right: bool):
	if (facing_right):
		facing_shape.position = facing_shape.facing_right_position
	else:
		facing_shape.position = facing_shape.facing_left_position
