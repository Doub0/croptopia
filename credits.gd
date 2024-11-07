extends Node2D
@onready var camera_main = $Camera2D
@onready var camera2 = $secondcut
# Called when the node enters the scene tree for the first time.
func _ready():
	camera_main.enabled = true
	camera2.enabled = false
	
	var doub = $doubo
	var gwizz = $gwizz
	doub.visible = false
	gwizz.visible = false
	$AnimatedSprite2D.play("background")
	$vapour.start()
	await get_tree().create_timer(3).timeout
	$AnimationPlayer.play("role1anim")
	await get_tree().create_timer(1).timeout
	$AnimationPlayer.play("role2anim")
	await get_tree().create_timer(1).timeout
	$AnimationPlayer.play("role3anim")
	await get_tree().create_timer(1).timeout
	$AnimationPlayer.play("role4anim")
	await get_tree().create_timer(1.5).timeout
	doub.visible = true
	gwizz.visible = true
	$doubo.play("doubo_dance")
	$gwizz.play("gwizz_dance")
	await get_tree().create_timer(1.5).timeout
	$AnimationPlayer.play_backwards("fade")
	doub.visible = false
	gwizz.visible = false
	camera_main.enabled = false
	camera2.enabled = true
	$AnimationPlayer.play("fade")
	await get_tree().create_timer(1.5).timeout
	$AnimationPlayer.play("role5_anim")
	await get_tree().create_timer(5).timeout
	$AnimationPlayer.play("role7_anim")
	await get_tree().create_timer(5).timeout
	$AnimationPlayer.play("role8_anim")
	await get_tree().create_timer(3).timeout
	$AnimationPlayer.play("button?anim")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("escape"):
		get_tree().change_scene_to_file("res://scenes/settings.tscn")
	elif Input.is_action_just_pressed("chat"):
		get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
