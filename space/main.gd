extends Node

@onready var ship = $Ship
@onready var enemy_spawner = $EnemySpawner
@onready var enemy_move_timer = $EnemyMoveTimer
@onready var ui = $UI

var save_file = "res://save.txt"
var points = 0
var highscore = 0
var lives

# Called when the node enters the scene tree for the first time.
func _ready():
	lives = 3
	if FileAccess.file_exists(save_file):
		var file = FileAccess.open(save_file,FileAccess.READ)
		highscore = int(file.get_line())
	else:
		highscore = 0	
	ui.update_high_score(highscore)
	ship.ship_hit_signal.connect(ship_hit)
	enemy_spawner.create_spawner()
	enemy_spawner.all_enemies_dead.connect(game_over)
	var children = enemy_spawner.get_children()
	for child in children:
		if child.is_in_group("enemy"):
			child.enemy_killed.connect(increase_points)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if lives < 1:
		game_over()
	
func increase_points(pts):
	points += pts
	ui.update_points(points)
	
func ship_hit():
	lives -= 1
	ui.update_lives(lives)	

func victory():
	game_over()
	
func game_over():
	ship.game_over()
	enemy_spawner.game_over()
	ui.on_game_over()
	if(points > highscore):
		update_high_score()
	save_data()

func update_high_score():
	highscore = points
	ui.update_high_score(highscore)

func _on_enemy_move_timer_timeout():
	var ran = int(randf_range(1,3))
	for enemy in enemy_spawner.get_children():
		enemy.move_enemy(ran)	
		
func save_data():
	var file = FileAccess.open(save_file, FileAccess.WRITE)
	file.store_string(str(highscore))		
