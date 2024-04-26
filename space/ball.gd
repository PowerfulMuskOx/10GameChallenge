extends Area2D

class_name Ball

@onready var sprite = $Sprite2D

var speed = 4000

func _physics_process(delta):
	position -= transform.y * speed * delta
	
func explode():
	#print_debug("Explosion!!")
	speed = 0
	sprite.play("explosion")
	await sprite.animation_finished
	queue_free()

func _on_area_entered(area):
	#print_debug("HitDetection area entered by: " + area.name)
	if area.is_in_group("enemies"):
		explode()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_body_entered(body):
	if body.is_in_group("enemies"):
		body.explode()
		explode()
