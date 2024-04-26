extends Area2D

class_name Jimmy

@onready var sprite = $Sprite2D

signal jimmy_killed

var speed = -200.0

var points = 100

func _process(delta):
	position.x -= speed * delta

func explode():
	jimmy_killed.emit(points)
	speed = 0
	points = 0
	sprite.play("explosion")
	await sprite.animation_finished
	queue_free()

func _on_area_entered(area):
	if area.is_in_group("friendly"):
		explode()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
