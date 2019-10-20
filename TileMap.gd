extends TileMap

var tile_size = get_cell_size()
var half_tile_size = tile_size/2

var grid_size = Vector2(20, 20) 
var grid = []

enum ENTITY_TYPES {MINOTAUR, WALL, LOOT, HERO}

onready var Wall = preload("res://Wall.tscn")
onready var Hero = preload("res://Hero.tscn")

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	for i in range(grid_size.x):
		grid.append([])
		for j in range(grid_size.y):
			grid[i].append(null)
	
	var side_walls_positions = []
	for j in range(grid_size.x):
		side_walls_positions.append(Vector2(j, 0))
		side_walls_positions.append(Vector2(j, grid_size.y - 1))
		
	for j in range(grid_size.y):
		side_walls_positions.append(Vector2(0, j))
		side_walls_positions.append(Vector2(grid_size.x - 1, j))
	
	for pos in side_walls_positions:
		var new_wall = Wall.instance()
		new_wall.position = map_to_world(pos) + half_tile_size
		grid[pos.x][pos.y] = WALL
		add_child(new_wall)
		
	var hero = Hero.instance()
	add_child(hero)
	place(get_node("Minotaur"), Vector2(3, 3))
	place(hero, Vector2(12, 12))
	# Called every time the node is added to the scene.
	# Initialization here
	

func is_cell_vacant(pos, direction):
	var grid_pos = world_to_map(pos) + direction
	if grid_pos.x < grid_size.x and grid_pos.x >= 0:
		if grid_pos.y < grid_size.y and grid_pos.y >= 0:
			if grid[grid_pos.x][grid_pos.y] == null:
				return true
			else:
				return false
	return false
	
func update_child_pos(child_node):
	var grid_pos = world_to_map(child_node.position)
	grid[grid_pos.x][grid_pos.y] = null
	var new_grid_pos = grid_pos + child_node.target_direction
	grid[new_grid_pos.x][new_grid_pos.y] = child_node.type
	
	return map_to_world(new_grid_pos)

func place(child_node, position):
	if grid[position.x][position.y] == null:
		grid[position.x][position.y] = child_node.type
		child_node.position = map_to_world(position) + half_tile_size
	
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
