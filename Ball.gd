extends CharacterBody2D

var win_size : Vector2
const START_SPEED : int = 200
const ACCEL : int = 50
var speed : int
var dir : Vector2
const MAX_Y_VECTOR : float = 0.75 # Max vertical bounce effect on paddle

func _ready():
	win_size = get_viewport_rect().size
	
func new_ball():
	# Randomize start position and direction
	position.x = win_size.x / 2
	position.y = randi_range(200, win_size.y - 200)  # 200 px from top and bottom range
	speed = START_SPEED
	dir = random_direction()
	
func random_direction(): 
	var new_dir := Vector2()
	new_dir.x = [1, -1].pick_random()
	new_dir.y = randf_range(-1, 1)
	return new_dir.normalized()

func _physics_process(delta):
	var collision = move_and_collide(dir * speed * delta)		
	var collider
	if collision:
		collider = collision.get_collider()
		if collider == $"../Player" or collider == $"../CPU":
			# Ball hits a paddle (Player or CPU), part of paddle alters the bounce direction
			speed += ACCEL
			# dir = dir.bounce(collision.get_normal())
			dir = new_direction(collider)
		else:
			# Ball hits a wall
			dir = dir.bounce(collision.get_normal())
	
func new_direction(collider):
	var ball_y = position.y
	var pad_y = collider.position.y
	var dist = ball_y - pad_y
	var new_dir := Vector2()
	
	#flip the x coordonate (bounce ball horizontally)
	if dir.x > 0:
		new_dir.x = -1
	else:
		new_dir.x = 1
 	# Ratio wher the ball ht the paddle, further from center is greater		
	new_dir.y = (dist / (collider.p_height / 2))  * MAX_Y_VECTOR
	return new_dir.normalized()
	
	
		
		
		
		
		
		
	
	
	
	
