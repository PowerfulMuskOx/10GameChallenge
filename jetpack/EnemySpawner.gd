extends Node

var enemy_scene = preload("res://enemy.tscn")

signal player_collide

@onready var spawn_timer = $SpawnTimer

var start_position = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_timer.start()


func start_spawning(pos): 
	start_position = pos
	spawn_timer.timeout.connect(spawn_enemy)

func spawn_enemy():
	var enemy = enemy_scene.instantiate() as Enemy
	add_child(enemy)
	
	enemy.set_speed(randf_range(-200, -400))
	
	var viewport_rect = get_viewport().get_camera_2d().get_viewport_rect()
	enemy.position.x = start_position.x
	enemy.position.y = randf_range(start_position.y, -250)
	
	enemy.player_collide.connect(_on_body_entered)
	
func _on_body_entered():
	player_collide.emit()
	stop()	
	
func stop():
	spawn_timer.stop()
	for enemy in get_children().filter(func (child): return child is Enemy):
		(enemy as Enemy).speed = 0	
