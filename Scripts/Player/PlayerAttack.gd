extends Node2D
class_name PlayerAttack


var player: Character
var tick: float = 0

func setup(body):
	player = body

func update(delta):
	tick = delta
	input_attack()

func input_attack():
	pass