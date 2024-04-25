extends CanvasLayer

@onready var high_score_points = $MarginContainer/HighScorePoints
@onready var points_label = $MarginContainer/Points

@onready var game_over_box = $MarginContainer/GameOverBox




# Called when the node enters the scene tree for the first time.
func _ready():
	points_label.text = "%d" % 0
	high_score_points.text = "%d" % 0
	
func update_points(points: int):
	points_label.text = "%d" % points
	
func update_high_score(points: int):
	high_score_points.text = "%d" % points
	
func on_game_over():
	game_over_box.visible = true
	
func _on_button_pressed():
	get_tree().reload_current_scene()
