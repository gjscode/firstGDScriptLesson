#must share same type as node, or one of its child nodes
#Player node is type KinematicBody2D
extends KinematicBody2D
#registers the script to be used
class_name Actor

#export keyword makes this value configurable in the inspector on the right
export var gravity: = 3000.0

#Vector2() reprents 2d space (x, y)
var velocity: = Vector2.ZERO

#physics_process is a function which godot will call every frame of your game (30-60fps)
#used for things that require physics (collisions, movement etc)
func _physics_process(delta: float) -> void:
	#adds gravity value to velocity's y axis
	#delta is a value that represents the time since the last frame (makes code "frame rate independent")
	#this means regardless of frame rate, the node will move the "distance" it is suppose to (whether smoothly or not)
	velocity.y += gravity * delta
	#this will move the player based on the inputed value (which we created above)
	#has delta value built in so no need to * velocity by delta
	move_and_slide(velocity)
