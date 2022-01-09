extends "res://src/Actors/Actor.gd"

#called on every node in the game, from top to bottom in the scene tree, from the bottom to the top in a node
func _ready() -> void:
	#since this is a "mario" type game that will progress to the right, we will set the enemy to move left at the start
	_velocity.x = -speed.x

func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	#is_on_wall, is_on_floor only update after the node has moved
	if is_on_wall():
		#this will flip the _velocity.x movement once it touches a "wall"
		_velocity.x *= -1.0
	#having "_velocity =" at the start will reset _velocity to zero when they collide with something
	#in this case, we do not want that for the enemy and so we only have it reset y
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
