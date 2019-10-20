extends KinematicBody2D

var direction = Vector2()

const UP = Vector2(0, -1)
const DOWN = Vector2(0, 1)
const LEFT = Vector2(-1, 0)
const RIGHT = Vector2(1, 0)

const UPLEFT = Vector2(-1, -1)
const UPRIGHT = Vector2(1, -1)
const DOWNLEFT = Vector2(-1, 1)
const DOWNRIGHT = Vector2(1, 1)

var grid
var type

var is_moving = false
var target_pos = Vector2()
var target_direction = Vector2()

var speed = 0
const MAX_SPEED = 100

func _ready():
	grid = get_parent()
	type = grid.MINOTAUR
	
	set_physics_process(true)


func _physics_process(delta):
	direction = Vector2()

	if Input.is_action_pressed("move_up"):
		direction = UP
	elif Input.is_action_pressed("move_down"):
		direction = DOWN
	elif Input.is_action_pressed("move_left"):
		direction = LEFT
	elif Input.is_action_pressed("move_right"):
		direction = RIGHT
	elif Input.is_action_pressed("move_upleft"):
		direction = UPLEFT
	elif Input.is_action_pressed("move_downleft"):
		direction = DOWNLEFT
	elif Input.is_action_pressed("move_upright"):
		direction = UPRIGHT
	elif Input.is_action_pressed("move_downright"):
		direction = DOWNRIGHT
	
	if not is_moving and direction != Vector2():
		target_direction = direction
		print("target_direction:")
		print(target_direction)
		if grid.is_cell_vacant(position, target_direction):
			target_pos = grid.update_child_pos(self) + grid.half_tile_size
			print("pos:")
			print(position)
			print("target_pos:")
			print(target_pos)
			is_moving = true
		else:
			grid.collide(self, 
	elif is_moving:
		speed = MAX_SPEED
		var velocity = speed * target_direction * delta
		print("velocity:")
		print(velocity)
		var distance_to_target = Vector2(abs(target_pos.x - position.x), abs(target_pos.y - position.y))
		print(distance_to_target)
		
		if abs(velocity.x) > distance_to_target.x:
			print("velox")
			velocity.x = distance_to_target.x * target_direction.x
			is_moving = false
		if abs(velocity.y) > distance_to_target.y:
			velocity.y = distance_to_target.y * target_direction.y
			is_moving = false
		
		move_and_collide(velocity)	
	#self.position = grid.map_to_world(target_pos) + grid.half_tile_size
	#var velocity = speed * direction.normalized() * delta
	



