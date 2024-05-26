extends StaticBody2D
@onready var player = $"../../Player"

func _physics_process(delta):
	if player.position.y > position.y:
		z_index = 0
	else:
		z_index = 2

func _on_collision_area_body_entered(body):
	if body == player:
		var tween = create_tween()
		tween.tween_property(self,"modulate",Color(1,1,1,0.7),0.3)

func _on_collision_area_body_exited(body):
	if body == player:
		var tween = create_tween()
		tween.tween_property(self,"modulate",Color(1,1,1,1),0.3)
