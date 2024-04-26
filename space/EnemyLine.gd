extends Node2D

@onready var spawn_area = $SpawnArea

var enemy_scene = preload("res://enemy.tscn")
const GRID_SIZE = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func create_row(): 
	for y in spawn_area.get_shape().get_size().y:
		for x in spawn_area.get_shape().get_size().x:
			var enemy = enemy_scene.instantiate()
			enemy.position = Vector2(x, y) * GRID_SIZE
			spawn_area.add_child(enemy)
