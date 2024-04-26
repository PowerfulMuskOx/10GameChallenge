extends Area2D

signal ship_hit
signal ball_hit

@onready var sprite = $Sprite2D

var speed = 2500

func _ready():
	pass

func _physics_process(delta):
	position += transform.y * speed * delta
	
func explode():
	speed = 0
	sprite.play("explosion")
	await sprite.animation_finished	
	queue_free()

func _on_area_entered(area):
	#print_debug("HitDetection area entered by: " + area.name)
	if area.is_in_group("friendly"):
		if area.is_in_group("ship"):
			ship_hit.emit()
			area.ship_hit()
		if area.is_in_group("ball"):
			ball_hit.emit()
		explode()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
