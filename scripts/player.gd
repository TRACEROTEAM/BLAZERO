extends CharacterBody2D


@export var SPEED = 100.0
@export var ACCELERATION := 0.3
const JUMP_VELOCITY = -400.0
@onready var sprite_2d: Sprite2D = $Graphics/Sprite2D
@onready var graphics: Node2D = $Graphics
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var pause_menu = $Hud/Pause_menu

var current_menu = "HUD"

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	pause_menu.hide()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("move_down"):
		sprite_2d.frame = 0
	elif event.is_action_pressed("move_up"):
		sprite_2d.frame = 1
	elif event.is_action_pressed("move_left"):
		sprite_2d.frame = 2
		graphics.scale.x = 1
	elif event.is_action_pressed("move_right"):
		sprite_2d.frame = 2
		graphics.scale.x = -1
		
func _unhandled_input(_event):
	# Pause.
	if Input.is_action_just_pressed("pause"):
		match current_menu :
			"HUD":
				current_menu = "Pause"
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
				pause_menu.show()
		print(current_menu)
		
func _physics_process(delta: float) -> void:
	var input_direction := Vector2(
		Input.get_axis("move_left","move_right"),
		Input.get_axis("move_up","move_down")
	).normalized()
	if input_direction != Vector2.ZERO:
		velocity = input_direction * SPEED
		animation_player.play("run")
	else:
		velocity = velocity.lerp(Vector2.ZERO,0.1)
		animation_player.play("idle")
	move_and_slide()
