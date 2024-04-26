extends CharacterBody2D

class_name Enemy

signal enemy_killed

@onready var shoot_timer = $ShootTimer
@onready var sprite = $Sprite2D
@onready var ray_cast = $RayCast2D
@onready var move_timer = $MoveTimer
@onready var stop_timer = $StopTimer


var enemy_bomb = preload("res://enemy_bomb.tscn")

var config: Resource
var should_shoot = false
var points = 0
var speed

var move = false
var state = "CENTER"
var previous_direction = "LEFT"

# Called when the node enters the scene tree for the first time.
func _ready():
	should_shoot = false
	sprite.animation = config.sprite
	points = config.points
	shoot_timer.wait_time = int(randf_range(4, 8))
	shoot_timer.start()
	move_timer.start()
	

func _process(delta):
	if !ray_cast.is_colliding():
		should_shoot = true
	else:
		should_shoot = false	
		
	if move:
		position.x -= speed * delta	
	
func _on_shoot_timer_timeout():
	shoot()

func shoot():
	if should_shoot:
		var b = enemy_bomb.instantiate()
		b.global_position = global_position
		b.top_level = true
		add_child(b)
	
func explode():
	enemy_killed.emit(points)
	sprite.play("explosion")
	await sprite.animation_finished
	queue_free()
	
func start_moving():
	stop_timer.start()
	if state == "CENTER" && previous_direction == "LEFT":
		speed = -100.0
		state = "RIGHT"
		previous_direction = "RIGHT"
	elif state == "CENTER" && previous_direction == "RIGHT":
		speed = 100.0
		state = "LEFT"
		previous_direction = "LEFT"	
	elif state == "RIGHT" && previous_direction == "RIGHT":
		speed = 100.0
		state = "CENTER"
	elif state == "LEFT" && previous_direction == "LEFT":
		speed = -100.0
		state = "CENTER"	
	move = true	

func _on_move_timer_timeout():
	start_moving()

func _on_stop_timer_timeout():
	move = false
