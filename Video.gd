extends Control

@onready var button = $video_settings/Button
@onready var button2 = $GridContainer/Button2
@onready var grid1 = $video_settings
@onready var grid2 = $GridContainer

@onready var shader_options = $shaders
signal shader_activate
signal shaders_disabled
signal color_is_optimized
signal vibranto_activated

var it_is_fullscreen = false
var it_is_miniscreen = false

var pushed_down = false
var pushed_up = true

func _ready():
	emit_signal("shader_activate")
	add_items()
	button.visible = true
	button2.visible = false
	grid2.move_to_front()
	grid2.position = Vector2(-100,0)
func _on_button_pressed():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
#	it_is_fullscreen = true
#	if it_is_fullscreen:
	button.visible = false
	button2.visible = true
	button.disabled = true
	button2.disabled = false
	grid1.position = Vector2(-100,0)
	grid2.position = Vector2(417,114)
#
#
#
func _on_button_2_pressed():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	grid1.position = Vector2(417,114)
	button.visible = true
	button.disabled = false
	button2.visible = false
	button2.disabled = true
	grid2.position = Vector2(-100,0)

func _on_optimize_item_selected(index):
	DisplayServer.window_set_vsync_mode(index)


#func _on_button_button_down():
#	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
#	pushed_down = true
#	if pushed_down:
#		button.text = "FullScreen"
#
#
#func _on_button_button_up():
#	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
#	pushed_up = true
#	if pushed_up:
#		button.text = "Mini"
#
#
#func _on_button_toggled(button_pressed):
#	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
#	pushed_up = true
#	if pushed_up:
#		button.text = "Mini"
#		if button_pressed:
#			return





func _on_shaders_item_selected(index):
	var current_selected = index
	
	if current_selected == 0:
		emit_signal("shader_activate")
	if current_selected == 1:
		emit_signal("shaders_disabled")
	if current_selected == 2:
		emit_signal("color_is_optimized")
	if current_selected == 3:
		emit_signal("vibranto_activated")

func add_items():
	shader_options.add_item("disable")
	shader_options.add_item("CRT")
	shader_options.add_item("Low-res")
	shader_options.add_item("Vibranto")
