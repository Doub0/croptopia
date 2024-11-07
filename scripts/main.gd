extends Node2D

@onready var splash = null
@onready var anim = $splash_cam/CanvasLayer/AnimationPlayer
@onready var textrect = $splash_cam/CanvasLayer/AnimationPlayer/TextureRect
@onready var colorect1 = $splash_cam/CanvasLayer/AnimationPlayer/ColorRect
@onready var colorect2 = $splash_cam/CanvasLayer/AnimationPlayer/ColorRect2
@onready var maincam = $Camera2D
@onready var splashcam = $splash_cam
func _ready():
	splashcam.enabled = true
	maincam.enabled = false
	anim.play("splash")
	textrect.visible = true
	colorect1.visible = true
	colorect2.visible = true
	$AudioStreamPlayer2D.stop()

func _on_play_pressed():
	print_debug( get_tree().change_scene_to_file("res://scenes/worldtest.tscn")) 
#extends Node2D
	
#@onready var play_button = $content/play_button

##func _ready() -> void:
	#play_button.connect('pressed', self, 'on_play')
	
#func on_play() -> void:
	#get_tree().change_scene('res://scenes/worldtest.tscn')	
	
	
	
	#CORE BUTTON FUNCTIONS - DO NOT REMOVE


func _on_exit_pressed():
	get_tree().quit()


func _on_label_mouse_entered():
	if Input.is_action_just_pressed("left click"):
		get_tree().change_scene_to_file("res://credits.tscn")
		
func _process(delta):
	if Input.is_action_just_pressed("chat"):
		get_tree().change_scene_to_file("res://credits.tscn")
	if Input.is_action_just_pressed("down"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("e"):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)


func _on_timer_2_timeout():
	maincam.enabled = true
	splashcam.enabled = false
	textrect.visible = false
	colorect1.visible = false
	colorect2.visible = false
	$AudioStreamPlayer2D.play()


func _on_setting_pressed():
	get_tree().change_scene_to_file("settings")
