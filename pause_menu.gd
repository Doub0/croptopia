extends Control

@onready var menu = $Control/menu
@onready var options = $Options
@onready var video = $Video
@onready var audio = $audio_settings
@onready var general = $general_settings
@onready var crt_shader = $crt
@onready var savebutton = $Save_button
@onready var color_redef = $color_redefinition
@onready var canvas = $background/CanvasLayer
var tog = false
# Called when the node enters the scene tree for the first time.

func _ready():
	menu.visible = false
	crt_shader.visible = false
	color_redef.visible = false
	$vibranto.visible = false
	options.visible = false
	video.visible = false
	audio.visible = false
	general.visible = false
	savebutton.visible = false
	canvas.visible = false
func _process(delta):
	if Input.is_action_just_pressed("escape"):
		if tog:
			untoggle()
		else:
			toggle()

func toggle():
	menu.visible = false
	options.visible = false
	video.visible = false
	audio.visible = false
	general.visible = false
	savebutton.visible = false
	canvas.visible = false
#	get_tree().paused = true
	tog = true
func untoggle():
	menu.visible = true
	options.visible = false
	video.visible = false
	audio.visible = false
	general.visible = false
	savebutton.visible = false
	canvas.visible = true
	tog = false
func _on_resume_pressed():
	toggle()


func _on_settings_pressed():
	show_and_hide(options, menu)
	
func show_and_hide(first, second):
	first.show()
	second.hide()


func _on_leave_pressed():
	get_tree().quit()


#settings#
func _on_general_pressed():
	show_and_hide(general, options)

func _on_video_pressed():
	show_and_hide(video, options)

func _on_audio_pressed():
	show_and_hide(audio, options)
##


func _on_video_shader_activate():
	$crt.visible = false
	$color_redefinition.visible = false
	$vibranto.visible = false

func _on_video_shaders_disabled():
	$crt.visible = true
	color_redef.visible = false
	$vibranto.visible = false


func _on_video_color_is_optimized():
	color_redef.visible = true
	$vibranto.visible = false
	$crt.visible = false

func _on_video_vibranto_activated():
	$vibranto.visible = true
	color_redef.visible = false
	$crt.visible = false
