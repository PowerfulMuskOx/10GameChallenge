extends CanvasLayer

@onready var points = $Points
@onready var high_score = $HighScore
@onready var life_1 = $GridContainer/Life1
@onready var life_2 = $GridContainer/Life2
@onready var life_3 = $GridContainer/Life3
@onready var box_container = $BoxContainer

var life:= load("res://art/lettuce_small.png")
var no_life:= load("res://art/leaf.png")


# Called when the node enters the scene tree for the first time.
func _ready():
	points.text = "%d" % 0
	high_score.text = "High Score: %d" % 0
	life_1.texture = life
	life_2.texture = life
	life_3.texture = life
	
func update_points(pts: int):
	points.text = "%d" % pts
	
func update_high_score(points: int):
	high_score.text = "High Score: %d" % points
	
func update_lives(lives: int):
	if lives == 2:
		life_3.texture = no_life
	elif lives == 1: 
		life_3.texture = no_life
		life_2.texture = no_life
	elif lives == 0:
		life_3.texture = no_life
		life_2.texture = no_life
		life_1.texture = no_life
		
func on_game_over():
	box_container.visible = true
	
func _on_button_pressed():
	get_tree().reload_current_scene()
