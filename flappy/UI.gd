extends CanvasLayer

@onready var point_label = $MarginContainer/PointLabel
@onready var game_over_box = $MarginContainer/GameOverBox


# Called when the node enters the scene tree for the first time.
func _ready():
	point_label.text = "%d" % 0
	
func update_points(points: int):
	point_label.text = "%d" % points
	
func on_game_over():
	game_over_box.visible = true
	
func _on_button_pressed():
	get_tree().reload_current_scene()
