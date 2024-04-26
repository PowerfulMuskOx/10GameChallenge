extends Node

@onready var ship = $Ship
@onready var enemy_spawner = $EnemySpawner
@onready var enemy_move_timer = $EnemyMoveTimer
@onready var ui = $UI

var points = 0
var lives

# Called when the node enters the scene tree for the first time.
func _ready():
	lives = 3
	ship.ship_hit_signal.connect(ship_hit)
	enemy_spawner.create_spawner()
	var children = enemy_spawner.get_children()
	for child in children:
		if child.is_in_group("enemy"):
			child.enemy_killed.connect(increase_points)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if lives < 1:
		ship.game_over()
		game_over()
	
func increase_points(pts):
	points += pts
	ui.update_points(points)
	
func ship_hit():
	lives -= 1
	ui.update_lives(lives)	
	
func game_over():
	enemy_spawner.game_over()

func _on_enemy_move_timer_timeout():
	var ran = int(randf_range(1,3))
	for enemy in enemy_spawner.get_children():
		enemy.move_enemy(ran)	
