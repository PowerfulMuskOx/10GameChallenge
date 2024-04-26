extends CharacterBody2D

class_name Enemy

signal enemy_killed

@onready var shoot_timer = $ShootTimer
@onready var sprite = $Sprite2D
@onready var ray_cast = $RayCast2D
@onready var target = get_node("../Enemy");

var enemy_bomb = preload("res://enemy_bomb.tscn")

var config: Resource
var should_shoot = false
var start_position: Vector2
var points = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.animation = config.sprite
	points = config.points
	shoot_timer.wait_time = int(randf_range(4, 8))
	shoot_timer.start()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !ray_cast.is_colliding():
		should_shoot = true
	
func _on_shoot_timer_timeout():
	shoot()

func shoot():
	if should_shoot:
		var b = enemy_bomb.instantiate()
		b.position = position
		add_child(b)
	
func explode():
	enemy_killed.emit(points)
	sprite.play("explosion")
	await sprite.animation_finished
	queue_free()
	
func move_left():
	#print_debug("Moving left")
	position.x -= 100
	
func move_right():
	#print_debug("Moving right")
	position.x += 100	
	
func move_enemy(ran: int):
	if position.x == start_position.x:
		#print_debug("Center")
		if ran == 1:
			move_left()
		elif ran == 2	:
			move_right()
	elif position.x < start_position.x:
		#print_debug("Left")
		move_right()
	elif position.x > start_position.x:	
		#print_debug("Right")
		move_left()
