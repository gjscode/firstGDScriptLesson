extends "res://src/Actors/Actor.gd"

#called on every node in the game, from top to bottom in the scene tree, from the bottom to the top in a node
func _ready() -> void:
	#deactivates the enemy at the start of the game
	#will activate when the enemy is in the view because of VisibilityEnabler2D on the enemy node
	set_physics_process(false)
	#since this is a "mario" type game that will progress to the right, we will set the enemy to move left at the start
	_velocity.x = -speed.x

func _on_StompDetector_body_entered(body: Node) -> void:
	#this compare the position of the StompDetector with the position of the Player that will enter the area
	if body.global_position.y > get_node("StompDetector").global_position.y:
		#return to void, it returns nothing but it will stop the function here
		return
	#this makes it so that the CollisionShape2D of the Enemy is disabled once you jump on it
	get_node("CollisionShape2D").disabled = true
	#this will essentially delete the enemy
	queue_free()


func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	#is_on_wall, is_on_floor only update after the node has moved
	if is_on_wall():
		#this will flip the _velocity.x movement once it touches a "wall"
		_velocity.x *= -1.0
	#having "_velocity =" at the start will reset _velocity to zero when they collide with something
	#in this case, we do not want that for the enemy and so we only have it reset y
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y


