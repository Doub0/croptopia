extends Node2D

var redbaneberry = preload("res://redbaneberry.tscn")
var yes = false
var has_baneberry = false
@onready var cutscene_happened = false
@onready var cutscene_numb = 0

signal baneberry_placed
#var mouse_tile = get_global_mouse_position()
func _ready():
	cutscene_happened = true
	Tilemanager.tilemap = $TileMap
	$redbane_placeable.visible = false
	$dialogue/Sprite2D/first_philip_dialogue.visible = false
	$dialogue/zea/third_zea_dialogue.visible = false
	cutscene_start()
func _on_play_pressed():
	pass
#func _process(delta):
#	if Input.is_action_just_pressed("Right-Click"):
#		$ColorRect.visible = false
#	if Input.is_action_just_pressed("Right-Click"):
#
#		add_child(object_test)
#		object_test.position = Vector2(0,0)


#func _on_player_stick_held():
	#Tilemanager.tilemap = $TileMap


#func _on_control_test():
#	yes = true
#	if yes:
##		if Input.is_action_just_pressed("1"):
#		Tilemanager.tilemap = $TileMap
#		$testobj.visible = true
#		await get_tree().create_timer(3).timeout
#
#
func _on_redbaneberry_picked_up():
		custom()
#			if Input.is_action_just_pressed("Right-Click"):
#				add_child(object_test)
#				object_test.position = Vector2(0,0)
##		await get_tree().create_timer(3).timeout
#
#
#
#func _on_timer_timeout():
#	Tilemanager.tilemap = $TileMap
#	$testobj.visible = true
#	if Input.is_action_just_pressed("Right-Click"):
#			add_child(object_test)
#			object_test.position = Vector2(0,0)
#
#	await get_tree().create_timer(3).timeout
	
func _input(event):
   # Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		print(event.position)
		var redbaneberry_instance = redbaneberry.instantiate()
		add_child(redbaneberry_instance)
		redbaneberry_instance.position = $redbane_placeable.position
		
		emit_signal("baneberry_placed")

func custom():
	Tilemanager.tilemap = $TileMap
	$redbane_placeable.visible = true
	yes = true
	if Input.is_action_just_pressed("Right-Click"):
		var redbaneberry_instance = redbaneberry.instantiate()
		add_child(redbaneberry_instance)
		redbaneberry_instance.position = $redbane_placeable.position

func cutscene_start():
	$dialogue.visible = true
	$dialogue/zea.visible = true
	$dialogue/Sprite2D.visible = true

func _on_third_zea_dialogue_dialogue_finished():
#	$dialogue/Sprite2D/first_philip_dialogue.visible = true
	$dialogue/zea/third_zea_dialogue.visible = false
	
	
func cutscene_end():
	$dialogue.visible = false
	$dialogue/zea.visible = false
	$dialogue/Sprite2D.visible = false

func _on_first_philip_dialogue_dialogue_finished():
	cutscene_end()
