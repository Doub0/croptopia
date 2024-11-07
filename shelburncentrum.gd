#extends Node2D
#@onready var transition = $Transition
#@onready var questTrans = $quest_transition
#@onready var player = $"../World/Player"
#@onready var NPC = $"../Player/World/npc"
#@onready var camera = $"../World/Player/Camera2D"
#@onready var quest_camera = $first_cutscene_follow/PathFollow2D/questcam
#@onready var quest_camera2 = $second_cutscene_follow/PathFollow2D/questcam
#var quest_is_finished = false
#var is_pathfollowing = false
#var is_pathfollowing2 = false
#func _ready():
#	var pathfollower = $first_cutscene_follow/PathFollow2D
#	var pathfollower2 = $second_cutscene_follow/PathFollow2D
#	pathfollower.visible = false
#	pathfollower2.visible = false
#	camera.enabled = true
#	quest_camera.enabled = false
#	transition.play("fade_out")
#
#func _physics_process(_delta):
#	if quest_is_finished:
#		var pathfollower = $first_cutscene_follow/PathFollow2D
#		var pathfollower2 = $second_cutscene_follow/PathFollow2D
#
#		if is_pathfollowing:
#			pathfollower2.visible = false
#			pathfollower.visible = true
#			quest_camera.enabled = true
#			quest_camera2.enabled = false
#			$first_cutscene_follow/PathFollow2D/AnimatedSprite2D.play("walk_up")
#			$first_cutscene_follow/PathFollow2D/AnimatedSprite2D2.play("walk_n")
#			camera.enabled = false
#			pathfollower.progress_ratio += 0.007
#			if pathfollower.progress_ratio >= 1:
#				is_pathfollowing2 = true
#		if is_pathfollowing2:
#			pathfollower.visible = false
#			pathfollower2.visible = true
#			camera.enabled = false
#			quest_camera.enabled = false
#			quest_camera2.enabled = true
#			$second_cutscene_follow/PathFollow2D/AnimatedSprite2D.play("walk_left")
#			$second_cutscene_follow/PathFollow2D/AnimatedSprite2D2.play("walk_w")
#			pathfollower2.progress_ratio += 0.001
#			if pathfollower2.progress_ratio >= 1:
#				get_tree().change_scene_to_file("res://transition.tscn")
#
#
#func _on_scenetrans_body_entered(body):
#	get_tree().change_scene_to_file("res://scenes/worldtest.tscn")
#
#
##func _on_area_2d_body_entered(body):
##	get_tree().change_scene_to_file("res://transition.tscn")
#
#func _on_npc_quest_is_finished():
#	quest_is_finished = true
#	player.position = Vector2(-1000,0)
#	is_pathfollowing = true
#	#if quest_is_finished:
#		#questTrans.play("quest_fade")
#		#var pathfollower = $first_cutscene_follow/PathFollow2D
#		#$first_cutscene_follow/PathFollow2D/AnimatedSprite2D.play("walk_up_idle")
#		#get_tree().create_timer(1)
#		#is_pathfollowing = true
#		#if is_pathfollowing:
#			#first_cam()
#func first_cam():
#	camera.enabled = false
#	quest_camera.enabled = true
#	quest_camera2.enabled = false
#	$first_cutscene_follow/PathFollow2D/AnimatedSprite2D.play("walk_left")
#	$first_cutscene_follow/PathFollow2D/AnimatedSprite2D2.play("walk_w")
#	is_pathfollowing2 = true
#	second_cam()
#func second_cam():
#	if is_pathfollowing2:
#		var pathfollower2 = $second_cutscene_follow/PathFollow2D
#		camera.enabled = false
#		quest_camera.enabled = false
#		quest_camera2.enabled = true
#		$second_cutscene_follow/PathFollow2D/AnimatedSprite2D.play("walk_left")
#		$second_cutscene_follow/PathFollow2D/AnimatedSprite2D2.play("walk_w")
#
#
#
#func _on_area_2d_body_entered(body):
#	get_tree().change_scene_to_file("res://transition.tscn")
