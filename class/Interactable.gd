extends Area2D
class_name Interactable


@export var hint := ""
@onready var label: Label = $Label
var active := false


func _on_area_entered(area: Area2D) -> void:
	if area.get_parent() is CharacterBody2D:
		label.text = "[E] %s" % hint
		label.visible = true
		active = true


func _on_area_exited(area: Area2D) -> void:
	if area.get_parent() is CharacterBody2D:
		label.visible = false
		active = false
