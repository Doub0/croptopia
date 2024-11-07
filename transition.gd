extends Node2D #The script extends the scene's main node
pass
##@onready var camera = $unique_player/Camera2D2
##@onready var player = 
#signal entered_the_cutscene
#signal exited_the_cutscene
#var it_has_happened = false
##var player = null
#
#func _ready():
##	$second_dialogue_zea.hide()
#	cutscene_cam.enabled = false
##	player..enabled = false
#	$zea.visible = false
#	$AnimatedSprite2D.visible = false
#	#$second_dialogue_zea.visible = false
#	it_has_happened = false
#func _on_area_2d_2_body_entered(body):
##	player = body
##	player.position = Vector2(-1000, -1000)
#	cutscene_cam.enabled = true
##	player..enabled = false
#	$zea.visible = true
#	$AnimatedSprite2D.visible = true
#	$second_dialogue_zea.visible = true
#	$second_dialogue_zea.start()
#	it_has_happened = true
#	emit_signal("entered_the_cutscene")
#
#
#
#func _on_second_dialogue_zea_dialogue_finished():
#	get_tree().create_timer(1)
##	camera.enabled = true
#	cutscene_cam.enabled = false
#	$zea.visible = false
#	$AnimatedSprite2D.visible = false
##	player.position = Vector2(120,-8)
#	emit_signal("exited_the_cutscene")
#
#
#
#func _on_area_2d_body_entered(body):
#	get_tree().change_scene_to_file("res://shelburne.tscn")
#
#
#func _on_node_2d_cutscene_over():
#	cutscene_cam.enabled = true
##	player..enabled = false
#	$zea.visible = true
#	$AnimatedSprite2D.visible = true
#	$second_dialogue_zea.visible = true
#	$second_dialogue_zea.start()
#	it_has_happened = true
#	emit_signal("entered_the_cutscene")
#
