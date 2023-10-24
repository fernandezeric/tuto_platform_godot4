extends Area2D

@export var damage_sword: float = 10

func _ready():
	monitoring = false

func _on_body_entered(body:Node2D):
	print("##################")
	print("body: ", body)
	print("body.name: ", body.name)
	print("body.get_children(): ", body.get_children())
	print("##################")
	#print("get_parent(): ", get_parent().crouch_raycast1.is_colliding()) -> acceso al raycast para above_head
	for child in body.get_children():
		if child is Damageable:
			child.hit(damage_sword)
			print("damage_sword: ", damage_sword)
