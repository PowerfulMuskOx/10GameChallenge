extends Area2D

signal ship_hit_signal

var ball = preload("res://ball.tscn")

@onready var cooldown_timer = $CooldownTimer
@onready var sprite = $Sprite2D

const speed = 400
var screen_size

var allow_shoot_input = true
var allow_moving_input = true

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	var velocity = Vector2.ZERO
	# Handle moving.
	if Input.is_action_pressed("left") && allow_moving_input:
		velocity.x -= 1
	elif Input.is_action_pressed("right") && allow_moving_input:
		velocity.x += 1
		
	if Input.is_action_just_pressed("shoot") && allow_shoot_input:
		shoot()
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	position += velocity * delta	
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.x < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
		
func ship_hit():
	ship_hit_signal.emit()
		
func game_over():
	explode()		
	
func explode():
	allow_moving_input = false
	allow_shoot_input = false
	sprite.play("explosion")
	await sprite.animation_finished
	
func shoot():
	var b = ball.instantiate()
	b.position = position
	owner.add_child(b)
	allow_shoot_input = false
	cooldown_timer.start()


func _on_cooldown_timer_timeout():
	allow_shoot_input = true
