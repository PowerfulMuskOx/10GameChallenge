extends Node2D

class_name EnemySpawner

var enemy_scene = preload("res://enemy.tscn")
const ROWS = 3
const COLUMNS = 7
const HORIZON_SPACING = 1
const VERTICAL_SPACING = 1
const INVADER_HEIGHT = 100
const START_Y_POSITION = -125
const INVADERS_POSITION_Y_INCREMENT = 2
const INVADERS_POSITION_X_INCREMENT = 2

var movement_direction = 1

func _ready():
	pass
			
func create_spawner(): 
	var enemy_1 = preload("res://resources/enemy_1.tres")
	var enemy_2 = preload("res://resources/enemy_2.tres")
	var enemy_3 = preload("res://resources/enemy_3.tres")
	
	var enemy_config
	
	for row in ROWS:
		if row == 0:
			enemy_config = enemy_3
		elif row == 1:
			enemy_config = enemy_2
		elif row == 2:
			enemy_config = enemy_1		

		var row_width = (COLUMNS * enemy_config.width * 1.7) + ((COLUMNS - 1) * HORIZON_SPACING)
		
		var start_x = (position.x - row_width) / 2
	
		for col in COLUMNS:
			var x = start_x + (col * enemy_config.width) + (col * HORIZON_SPACING)
			var y = START_Y_POSITION + (row * INVADER_HEIGHT) + (row * VERTICAL_SPACING)
			var spawn_position = Vector2(x, y)
			
			spawn_enemy(enemy_config, spawn_position)	
	
func spawn_enemy(enemy_config, spawn_position: Vector2):
	var enemy = enemy_scene.instantiate()
	enemy.config = enemy_config
	enemy.start_position = spawn_position
	enemy.global_position = spawn_position
	add_child(enemy)
	
func game_over():
	for n in self.get_children():
		self.remove_child(n)
		n.queue_free() 	
