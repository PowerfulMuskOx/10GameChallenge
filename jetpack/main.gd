extends Node

@onready var enemy_spawner = $EnemySpawner
@onready var spawn_position = $SpawnPosition
@onready var player = $Player
@onready var points_timer = $PointsTimer
@onready var ground = $Ground
@onready var ui = $UI

var save_file = "res://save.txt"
var highscore = 0
var points = 0


var enemy = preload("res://enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	if FileAccess.file_exists(save_file):
		var file = FileAccess.open(save_file,FileAccess.READ)
		highscore = int(file.get_line())
	else:
		highscore = 0	
	ui.update_high_score(highscore)
	points_timer.start()
	enemy_spawner.start_spawning(spawn_position.position)
	enemy_spawner.player_collide.connect(end_game)

func end_game():
	player.stop()
	points_timer.stop()
	ground.stop()
	ui.on_game_over()
	if points > highscore:
		update_high_score()
	save_data()
	
func update_high_score():
	highscore = points
	ui.update_high_score(highscore)


func _on_points_timer_timeout():
	points += 1	
	ui.update_points(points)
	
func save_data():
	var file = FileAccess.open(save_file, FileAccess.WRITE)
	file.store_string(str(highscore))
