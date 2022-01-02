#must share same type as node, or one of its child nodes
#Player node is type KinematicBody2D
extends KinematicBody2D
#registers the script to be used
class_name Actor

#an optional func of move_and_slide (it is now called up_direction, and not floor_normal)
#tells Godot what is the floor and what is not
#allows the is_on_floor function to work
#without this, Godot does not know if the player is on the floor, and thus you cannot jump
const FLOOR_NORMAL: = Vector2.UP

#this will be used to limit the speed of the character
export var speed: = Vector2(300.0, 1000.0)

#this is an acceleration
#export keyword makes this value configurable in the inspector on the right
export var gravity: = 3000.0

#Vector2() reprents 2d space (x, y)
var velocity: = Vector2.ZERO


	#using the speed var above, this always return the minimum of the two values, capping how high velocity.y can go
	##velocity.y = min(speed.y, velocity.y)
