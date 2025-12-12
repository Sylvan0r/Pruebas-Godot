extends Control

func _ready():
	$VBoxContainer/startButton.grab_focus()

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")
