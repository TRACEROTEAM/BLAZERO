extends Control
var current_menu : String = "Ready"

@onready var animation = $AnimationPlayer
@onready var timer = $Main/HBoxContainer/Timer
@onready var login_window = $LoginWindow
@onready var setting_and_qq = $SettingAndQq

func _input(event):
	if current_menu == "Ready" \
	and (event is InputEventKey or event is InputEventMouseButton) \
	and !Rect2(setting_and_qq.position, setting_and_qq.size).has_point(get_local_mouse_position()):
		login_window.position.x = get_window().size.x/2 - login_window.size.x/2
		login_window.position.y = get_window().size.y/2 - login_window.size.y/2
		login_window.show()
		
func _on_timer_timeout():
	if current_menu == "Main":
		animation.play_backwards("ToMainMenu")
		current_menu = "Ready"

#Options
func _on_options_button_pressed():
	if current_menu == "Main" and !animation.is_playing():
		animation.play("Options")
		current_menu = "Options"
func _on_options_back_button_pressed():
	if current_menu == "Options":
		animation.play_backwards("Options")
		current_menu = "Main"

#Exit
func _on_exit_button_pressed():
	if current_menu == "Main" and !animation.is_playing():
		animation.play("Exit")
		current_menu = "Exit"
func _on_cancel_button_pressed():
	if current_menu == "Exit":
		animation.play_backwards("Exit")
		current_menu = "Main"
func _on_confirm_button_pressed():
	if current_menu == "Exit":	get_tree().quit()

#World
func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/world.tscn")

func _on_login_button_pressed():
	login_window.hide()
	setting_and_qq.hide()
	animation.play("ToMainMenu")
	current_menu = "Main"

func _on_login_window_close_requested():
	login_window.hide()
