extends Node

@onready var player = $"../Player"
@onready var obstacle_spawner = $"../ObstacleSpawner"
@onready var ground = $"../Ground"
@onready var fade = $"../Fade"
@onready var ui = $"../UI"
var points = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	player.game_started.connect(on_game_started)
	ground.bird_crashed.connect(end_game)
	obstacle_spawner.bird_crashed.connect(end_game)
	obstacle_spawner.point_scored.connect(on_point_scored)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func on_game_started():
	obstacle_spawner.start_spawning_obst()	
	
func end_game():
	fade.play()
	ground.stop()
	player.kill()
	obstacle_spawner.stop()	
	ui.on_game_over()
	
func on_point_scored():
	points += 1	
	ui.update_points(points)
