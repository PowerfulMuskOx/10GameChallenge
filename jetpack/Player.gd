extends CharacterBody2D

class_name Player

@export var gravity = 900.0
@export var jump_force = -300
@export var rotation_speed = 2

var STATE = ""

var is_dead = false

const SPEED = 400.0

var should_process_input = true

func _ready():
	velocity = Vector2.ZERO

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		STATE = "FALLING" 	
		
	if is_on_floor() && !is_dead:
		rotation = deg_to_rad(0)
		STATE = "WALKING"
			

	# Handle jump.
	if Input.is_action_pressed("fly") && should_process_input:
		velocity.y = jump_force
		rotation = deg_to_rad(-30)
		STATE = "FLYING"

	if velocity.y > SPEED:
		velocity.y = SPEED
		
	if STATE == "WALKING":
		$AnimatedSprite2D.play("walking")
	elif STATE == "FLYING":	
		$AnimatedSprite2D.play("flying")
	elif STATE == "FALLING":
		$AnimatedSprite2D.play("falling")
	else:
		$AnimatedSprite2D.play("dead")	
		
	if is_dead:
		STATE = ""	

	move_and_slide()
	rotate_player()
	
func rotate_player():
	if velocity.y > 0 && rad_to_deg(rotation) < 30:
		rotation += rotation_speed * deg_to_rad(1)
	elif velocity.y < 0 && rad_to_deg(rotation) > -30:
		rotation += rotation_speed * deg_to_rad(1)	
		
func stop():
	$AnimatedSprite2D.play("dead")
	rotation = deg_to_rad(0)
	velocity = Vector2.ZERO
	is_dead = true
	should_process_input = false
