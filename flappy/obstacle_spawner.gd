extends Node

class_name ObstacleSpawner

signal bird_crashed
signal point_scored

var obstacle_pair_scene = preload("res://obstacle_pair.tscn")

@export var obst_speed = -150

@onready var spawn_timer = $SpawnTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_timer.start()
	
func start_spawning_obst():
	spawn_timer.timeout.connect(spawn_obst)


func spawn_obst():
	var obst = obstacle_pair_scene.instantiate() as ObstaclePair
	add_child(obst)
	
	var viewport_rect = get_viewport().get_camera_2d().get_viewport_rect()
	obst.position.x = viewport_rect.end.x
	
	var half_height = viewport_rect.size.y / 2
	obst.position.y = randf_range(viewport_rect.size.y * -0.1 - half_height, viewport_rect.size.y * 0.25 - half_height)
	
	obst.bird_entered.connect(on_bird_entered)
	obst.point_scored.connect(on_point_scored)
	obst.set_speed(obst_speed)


func on_bird_entered():
	bird_crashed.emit()
	stop()
	
func on_point_scored():
	point_scored.emit()	
	
func stop():
	spawn_timer.stop()
	for obst in get_children().filter(func (child): return child is ObstaclePair):
		(obst as ObstaclePair).speed = 0
		
