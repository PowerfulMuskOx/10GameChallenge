extends CharacterBody2D

class_name Player

signal game_started

@export var gravity = 900.0
@export var jump_force = -300
@export var rotation_speed = 2

var max_speed = 400

var is_started = false
var should_process_input = true

func _ready():
	velocity = Vector2.ZERO

func _physics_process(delta):
	#   Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") && should_process_input:
		if !is_started:
			game_started.emit()
			$AnimatedSprite2D.play()
			is_started = true
		jump()
	
	if is_started == false:
		return
	velocity.y += gravity * delta
	
	if(velocity.y > max_speed):
		velocity.y = max_speed

	move_and_collide(velocity * delta)
	
	rotate_player()
	
func jump():
	velocity.y = jump_force
	rotation = deg_to_rad(-30)
	
func rotate_player():
	if velocity.y > 0 && rad_to_deg(rotation) < 90:
		rotation += rotation_speed * deg_to_rad(1)
	elif velocity.y < 0 && rad_to_deg(rotation) > -30:
		rotation -= rotation_speed * deg_to_rad(1)	
		
func kill():
	should_process_input = false
		
func stop():
	$AnimatedSprite2D.stop()
	gravity = 0
	velocity = Vector2.ZERO		
	
