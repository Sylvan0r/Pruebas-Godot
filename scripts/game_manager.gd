extends Node

@onready var win_label: Label = %WinLabel
@onready var score_label: Label = %ScoreLabel
var score = 0

func add_point():
	score += 1
	score_label.text = ": " + str(score) + " / 18"
	if score == 18:
		win_game()

func win_game():
	win_label.show()
	win_label.text = "YOU WIN!"
