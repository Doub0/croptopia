extends Node2D

@onready var anim = $fireplace
@onready var logcam = $log_seat/Camera2D
@onready var michaelsprite = $log_seat/michael
@onready var zeadialogue = $third_zea_dialogue
@onready var markdialogue = $mark_dialogue
@onready var cutscenecam = $cutscene_cam
var its_true = false

# Called when the node enters the scene tree for the first time.
func _ready():
	logcam.enabled = false
	zeadialogue.visible = false
	markdialogue.visible = false
	$Sprite2D.visible = false
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	its_true = true


func _on_log_seat_sitting():
	if Input.is_action_just_pressed("e"):
		logcam.enabled = true
		michaelsprite.visible = true


func _on_cutscene_trigger_body_entered(body):
	zeadialogue.visible = true
	cutscenecam.enabled = true
	


func _on_third_zea_dialogue_dialogue_finished():
	markdialogue.visible = true
	zeadialogue.visible = false
	$Sprite2D.visible = true


func _on_mark_dialogue_dialogue_finished():
	markdialogue.visible = false
	cutscenecam.enabled = false
	$cutscene_trigger.monitoring = false
	$Sprite2D.visible = false


func _on_enter_body_entered(body):
	logcam.enabled = false
	anim.play("default")
	zeadialogue.visible = false
	markdialogue.visible = false
	$Sprite2D.visible = false
