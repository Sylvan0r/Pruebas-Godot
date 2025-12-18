extends Area2D

@onready var game_manager: Node = %GameManager
@onready var pickup_sound: AudioStream = preload("res://assets/sounds/coin.wav") # tu sonido de moneda

func _on_body_entered(body: Node2D) -> void:
	# Sumar puntos
	game_manager.add_point()
	
	# Crear un AudioStreamPlayer2D temporal para reproducir el sonido
	var sfx = AudioStreamPlayer2D.new()
	sfx.volume_db = -10
	sfx.stream = pickup_sound
	sfx.position = global_position
	get_tree().current_scene.add_child(sfx)
	sfx.play()
	
	# Eliminar la moneda inmediatamente
	queue_free()
