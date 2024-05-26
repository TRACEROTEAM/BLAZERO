extends CharacterBody2D


@export var SPEED = 1
@export var DASH = 0.5

@export var FRICTION = 10
@export var ACCELERATION = 2
const JUMP_VELOCITY = -400.0

@onready var sprite_2d: Sprite2D = $Graphics/Sprite2D
@onready var graphics: Node2D = $Graphics
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var animationTree = $CharacterTex/CharacterAnimationTree
@onready var animationState = animationTree.get("parameters/playback")

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
	#Move Input
	var input_direction := Vector2(
		Input.get_axis("move_left","move_right"),
		Input.get_axis("move_up","move_down")
	).normalized()
	
	#Dash Input
	var isDash = 0
	isDash = Input.get_action_strength("dash")
	
	#Move & Animate
	if input_direction != Vector2.ZERO:
		#velocity = input_direction * SPEED
		velocity = input_direction * (SPEED + isDash * DASH) * 100
		if velocity.x * input_direction.x <= 0 and velocity.x!=0:
			velocity = Vector2(0,velocity.y)
		if velocity.y * input_direction.y <= 0 and velocity.y!=0:
			velocity = Vector2(velocity.x,0)
		
		animationTree.set("parameters/Idle/blend_position",Vector2(input_direction.x,input_direction.y))
		animationTree.set("parameters/Walk/blend_position",Vector2(input_direction.x,input_direction.y))
		animationState.travel("Walk")
		
		#animation_player.play("run")
	else:
		velocity = velocity.lerp(Vector2.ZERO,0.9)
		
		animationState.travel("Idle")
		
		#animation_player.play("idle")
		
	move_and_slide()
	#print(velocity,input_direction)
