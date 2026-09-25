extends Control

# Referencias a tus sliders y botón según los nombres de tu escena
@onready var music_slider: HSlider = $VBoxContainer/configButton/musicBus
@onready var sfx_slider: HSlider = $VBoxContainer/configButton/sfxBus
@onready var config_button: Button = $VBoxContainer/configButton

# Índices de los buses de audio (Nombres exactos de tu pestaña de Audio)
var music_bus_index: int
var sfx_bus_index: int

func _ready() -> void:
	# Dar el foco al botón de inicio
	$VBoxContainer/startButton.grab_focus()
	
	# Asegurarnos de que los sliders empiecen ocultos al iniciar el juego
	music_slider.visible = false
	sfx_slider.visible = false
	
	# Obtener los índices con los nombres exactos de tus buses: "Music" y "SFX"
	music_bus_index = AudioServer.get_bus_index("Music")
	sfx_bus_index = AudioServer.get_bus_index("SFX")
	
	# Inicializar los sliders con el volumen actual del juego
	music_slider.value = db_to_linear(AudioServer.get_bus_volume_db(music_bus_index))
	sfx_slider.value = db_to_linear(AudioServer.get_bus_volume_db(sfx_bus_index))
	
	# Conectar las señales de cambio de valor de los sliders por código
	music_slider.value_changed.connect(_on_music_slider_value_changed)
	sfx_slider.value_changed.connect(_on_sfx_slider_value_changed)
	
	# Conectar el botón de configuración por código para asegurar que funcione
	config_button.pressed.connect(_on_config_button_pressed)

# Función para iniciar el juego (Asegúrate de conectarla en el editor si no lo está)
func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")

# Función que controla el botón de configuración
func _on_config_button_pressed() -> void:
	music_slider.visible = !music_slider.visible
	sfx_slider.visible = !sfx_slider.visible
	
	if music_slider.visible:
		music_slider.grab_focus()

# Lógica para cambiar el volumen de la música
func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(music_bus_index, linear_to_db(value))
	AudioServer.set_bus_mute(music_bus_index, value <= 0.0)

# Lógica para cambiar el volumen de los efectos de sonido
func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(sfx_bus_index, linear_to_db(value))
	AudioServer.set_bus_mute(sfx_bus_index, value <= 0.0)
