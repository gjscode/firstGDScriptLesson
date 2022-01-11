extends Actor

export var stomp_impulse: = 1000.0

#when a player jumps on the enemy their velocity will change
#stomp_impulse will determine how high they "bump" into the air after stomping on enemies
func _on_EnemyDetector_area_entered(area: Area2D) -> void:
	_velocity = calculate_stomp_velocity(_velocity, stomp_impulse)

#will run the parent's (Actor) physics process first and then this one
#physics_process is a function which godot will call every frame of your game (30-60fps)
#used for things that require physics (collisions, movement etc)
func _physics_process(delta: float) -> void:
	#placing var before "scopes" the variable
	#will check to see if the input for jump has been interrupted, and if they are jumping
	#must be added to calculate_move_velocity()
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var direction: = get_direction()
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	#this will move the player based on the inputed value (which we created in the Actor script)
	#has delta value built in so no need to * _velocity by delta
	#having (_velocity =) at the start will reset _velocity to zero when they collide with something
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)

func get_direction() -> Vector2:
	return Vector2(
		#Input queries for inputs on every frame of the game
		#move_right is what we created in the input map
		#move_right is 1, and move_left is -1
		#both are on the x axis as Vector2 takes both x and y
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		#this makes it so when the jump input is received, the player goes up (up on y is negative, down is positive)
		#is_on_floor() prevents the player from jumping infinitely, they can only "jump" if they are on the floor 
		#otherwise, the player will always be moving down unless it collides with something
		-1.0 if Input.get_action_strength("jump") and is_on_floor() else 1.0
	)

func calculate_move_velocity(
		#_velocity is called linear_velocity in the documentation so we use that
		#we are passing each parameter so they can be used within the "scope" of this function
		#otherwise it would have to be initialized above any function to be "globally" accessible, but that is messy
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:
	#new_velocity will start from linear_velocity, it will take the initial _velocity
	#it will make some calculations with the other parameters (direction and speed) and return a new value
	#this new value can then be assigned or stored or processed however we want
	var new_velocity: = linear_velocity
	new_velocity.x = speed.x * direction.x
	#adds gravity value to new_velocity's y axis
	#delta is a value that represents the time since the last frame (makes code "frame rate independent")
	#this means regardless of frame rate, the node will move the "distance" it is suppose to (whether smoothly or not)
	#but because delta is not within the scope of this func (we can add it), we can use get_physics_process_delta_time()
	#get_physics_process_delta_time() returns the delta value we have above in _physics_process
	new_velocity.y += gravity * get_physics_process_delta_time()
	#from above, when "jump" is pressed, direction.y becomes -1.0
	#when that happens, this will override the characters _velocity.y
	#the player's y speed will be applied to _velocity
	if direction.y == -1.0:
		new_velocity.y = speed.y * direction.y
	#will make it so if you stop pressing jump, the jump will end
	if is_jump_interrupted:
		new_velocity.y = 0.0
	return new_velocity

func calculate_stomp_velocity(linear_velocity: Vector2, impulse: float) -> Vector2:
	#sets "out" to be equal to linear_velocity
	var out: = linear_velocity
	#replaces the y component of our linear_velocity to negative impulse
	out.y = -impulse
	return out
