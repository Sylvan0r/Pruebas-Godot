extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -300.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump: AudioStreamPlayer = $AudioStreamPlayer

# Referencia a tus controles táctiles (Ajusta la ruta si están dentro de la cámara, ej: $Camera2D/TouchscreenControls)
@onready var touchscreen_controls: CanvasLayer = $Camera2D/TouchscreenControls

func _ready() -> void:
	# === DETECCIÓN DE ANDROID / MÓVIL ===
	if OS.has_feature("mobile") or OS.has_feature("android"):
		touchscreen_controls.visible = true
	else:
		# Si estás probando en PC, los oculta automáticamente para que no estorben
		touchscreen_controls.visible = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump.play()
		velocity.y = JUMP_VELOCITY

	# Direction can be: -1, 0 , 1
	var direction := Input.get_axis("move_left", "move_right")
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
