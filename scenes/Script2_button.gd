extends Button


func _pressed() -> void:
	DialogueManager.show_example_dialogue_balloon(preload("res://dialog/first.dialogue"))
