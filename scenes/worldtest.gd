extends Node2D

#@onready var main_menu_button = $content/main_menu_button
signal cutscene_over
signal exited_the_cutscene
signal start_music
signal entered_cutscene
signal disable_player
#@onready var transition = $Transition
@onready var questTrans = $spawn/zea_walk_cutscene/quest_transition
@onready var player = $player
@onready var NPC = $npc
@onready var camera = $player/Camera2D
@onready var quest_camera = $spawn/zea_walk_cutscene/first_cutscene_follow2/PathFollow2D/questcam
@onready var quest_camera2 = $spawn/zea_walk_cutscene/second_cutscene_follow2/PathFollow2D/questcam
@onready var pause_menu = $UI/Pause_Menu/pause_menu
@onready var zea_cam = $shelburne_town/shelburne/zea_house_cam
@onready var cutscene_cam = $scenetwo/cutscene_cam
@onready var background_music = $spawn/background_music
#@onready var zea_backgroundsong = $song
#Inside zea house#
@onready var inside_zea_cam = $inside_zea/Camera2D
@onready var man = $inside_zea/man
@onready var house = $inside_zea/house
@onready var unknown_dialogue = $inside_zea/unknown_dialogue
@onready var house_player = $inside_zea/cutscene_player
#@onready var zea_house_trans = $inside_zea/Transition
#TOP OF MTCRAG#
@onready var anim = $mt_crag/top_of_mt_crag/fireplace
@onready var logcam = $mt_crag/top_of_mt_crag/log_seat/Camera2D
@onready var michaelsprite = $mt_crag/top_of_mt_crag/log_seat/michael
@onready var zeadialogue = $mt_crag/top_of_mt_crag/third_zea_dialogue
@onready var markdialogue = $mt_crag/top_of_mt_crag/mark_dialogue
@onready var cutscenecam = $mt_crag/top_of_mt_crag/cutscene_cam

@onready var punisher_anim = $punisher_anim
@onready var death_screen = $UI/CanvasLayer/death_screen
@onready var death_music = $music/AudioStreamPlayer2D

@export var inv: Inv
@export var item: InvItem

var quest_is_finished = false
var is_pathfollowing = false
var is_pathfollowing2 = false
var cutscene_is_over = false

var is_openingcutscene = false #Asks if the opening cutscene is active

var has_player_entered_area = false #Asks if the player has entered the Area

var is_henryfollowing = false #The camera is not following a path?
var is_henryfollowing2 = false

var zea_house_happened = "false"

var redbaneberry = preload("res://redbaneberry.tscn")
var chives = preload("res://chive.tscn")
var yes = false

var has_baneberry = false
var has_chives = false

var selected_redbane = false
var selected_chives = false
var redbane_collected = false
var chive_collected = false

#PLACEMENT SCRIPT#
@onready var sunset = $UI/day_and_night/ui/sunset_rect/sunset_cycle
@onready var sunrise = $UI/day_and_night/ui/sunrise_rect/sunrise_cycle
@onready var sunset_rect = $UI/day_and_night/ui/sunset_rect
@onready var sunrise_rect = $UI/day_and_night/ui/sunrise_rect

@onready var night_rect = $UI/day_and_night/ui/night_rect
@onready var night = $UI/day_and_night/ui/night_rect/night_cycle
@onready var day = $UI/day_and_night/ui/day_rect/day_cycle
@onready var day_rect = $UI/day_and_night/ui/day_rect

@onready var day_counter = $UI/day_and_night/ui/CanvasLayer/Panel/Sprite2D/count
var day_count

var sunset_time
var sunrise_time

var night_time
var day_time

var phase

signal redbane_placed
signal chive_placed
signal decrease_redbane

signal disable_building
#####################
@onready var cutscene_happened = false
@onready var cutscene_numb = 0

@onready var animplayer = $spawn/henry_cutscene/world2openingcutscene/AnimationPlayer #Prepares the Animation Player node which contains the Opening Cutscene
@onready var henry_camera = $spawn/henry_cutscene/world2openingcutscene/Path2D/PathFollow2D/Camera2D #Prepares Cutscene Camera
signal baneberry_placed

#SHOP VARIABLES

@onready var money_counter = $UI/money_count/Panel/Sprite2D/count
var money_count = 0

var redbane_sold
var chive_sold
var pinecone_sold

@onready var redbane_counter = $michael_plot/phillip/phillip_merchant/CanvasLayer/shop_ui/redbane_count
@onready var chive_counter = $michael_plot/phillip/phillip_merchant/CanvasLayer/shop_ui/chive_count
@onready var pinecone_counter = $michael_plot/phillip/phillip_merchant/CanvasLayer/shop_ui/pinecone_count

@export var redbane = 0
@export var chive = 0
@export var pinecone = 0

@onready var seller = $michael_plot/phillip/phillip_merchant

@onready var inventory = $UI/Inventory/Crafting_menu/Inv_UI/NinePatchRect/GridContainer/inv_UI_slot

signal update_slot

func _ready():
	#background_music.play() #REINCORPORATE LATER#
	death_screen.visible = false
	cutscene_happened = true
##
	cutscene_start()
	
	var pathfollower = $spawn/zea_walk_cutscene/first_cutscene_follow2/PathFollow2D
	var pathfollower2 = $spawn/zea_walk_cutscene/second_cutscene_follow2/PathFollow2D
	pathfollower.visible = false
	pathfollower2.visible = false
	camera.enabled = true
	quest_camera.enabled = false
	quest_camera2.enabled = false
	zea_cam.enabled = false
	cutscene_cam.enabled = false
	inside_zea_cam.enabled = false
	unknown_dialogue.visible = false
	man.visible = false
	house_player.visible = false
#	player..enabled = false  // modified this btw
	$scenetwo/second_dialogue_zea.visible = false
	markdialogue.visible = false  
	zeadialogue.visible = false
	$scenetwo/AnimatedSprite2D.visible = false   
	
	#Former test_enviroment code
	day_count = 0
	phase = "day"
	day_time = true

	Tilemanager.tilemap = $michael_plot/placement_mechanic/TileMap
	$michael_plot/placement_mechanic/redbane_placeable.visible = false
	$michael_plot/placement_mechanic/chive_placeable.visible = false
	
	money_count = 0
	redbane = 0
	chive = 0
	pinecone = 0
	redbane_sold = false
	chive_sold = false
	pinecone_sold = false

func _process(delta):
	redbane_counter.text = str(redbane)
	chive_counter.text = str(chive)
	pinecone_counter.text = str(pinecone)
	if phase == "sunset":
		sunrise_time = false
		sunset_time = true
		night_time = false
		day_time = false
		sunrise_rect.visible = false
		sunset_rect.visible = true
		night_rect.visible = false
		day_rect.visible = false
		sunset.play("day_night_cycle")
		
	if phase == "sunrise":
		sunrise_time = true
		sunset_time = false
		night_time = false
		day_time = false
		sunset_rect.visible = false
		sunrise_rect.visible = true
		night_rect.visible = false
		day_rect.visible = false
		sunrise.play("day_night_cycle_reverse")
		
	if phase == "night":
		sunrise_time = false
		sunset_time = false
		night_time = true
		day_time = false
		sunset_rect.visible = false
		sunrise_rect.visible = false
		night_rect.visible = true
		day_rect.visible = false
		night.play("night_cycle")
		
	if phase == "day":
		sunrise_time = false
		sunset_time = false
		night_time = false
		day_time = true
		sunset_rect.visible = false
		sunrise_rect.visible = false
		night_rect.visible = false
		day_rect.visible = true
		day.play("day_cycle")
		#the day count \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
		#\\\\\\\\\\\\\\\\\\\\\\\
#		#SCRIPT FOR OBJECTS
#	if redbane_collected == true:
#		Tilemanager.tilemap = $test2/TileMap
#		$test2/redbane_placeable.visible = true
##			$test/dialogue/Sprite2D/first_philip_dialogue.visible = false
##			$test/dialogue/zea/third_zea_dialogue.visible = false
#		selected_redbane = true
#		chive_collected = false
#		selected_chives = false
#
#	#THE OTHER OBJECTS
#		$test2/chive_placeable.visible = false
	if selected_redbane == true:
		print("selected redbaneberry!")
		Tilemanager.tilemap = $michael_plot/placement_mechanic/TileMap
		$michael_plot/placement_mechanic/redbane_placeable.visible = true
		$michael_plot/placement_mechanic/chive_placeable.visible = true
#		selected_redbane = true
#		chive_collected = false
#		selected_chives = false
		if Input.is_action_just_pressed("Right-Click") or Input.is_action_just_pressed("left click"):
			var redbaneberry_instance = redbaneberry.instantiate()
			add_child(redbaneberry_instance)
			redbaneberry_instance.position = $michael_plot/placement_mechanic/redbane_placeable.position
			emit_signal("redbane_placed")
			print("working like usual")
	if selected_redbane == false:
		$michael_plot/placement_mechanic/redbane_placeable.visible = false
	
	#############################################
#	if chive_collected == true:
#		Tilemanager.tilemap = $test2/TileMap
#		$test2/chive_placeable.visible = true
#		$test2/redbane_placeable.visible = false
#		selected_chives = true
#		redbane_collected = false
#		selected_redbane = false
	if selected_chives == true:
		print("selected chives!")
		Tilemanager.tilemap = $michael_plot/placement_mechanic/TileMap
		$michael_plot/placement_mechanic/chive_placeable.visible = true
		$michael_plot/placement_mechanic/redbane_placeable.visible = false
#		selected_chives = true
#		redbane_collected = false
#		selected_redbane = false
		if Input.is_action_just_pressed("Right-Click") or Input.is_action_just_pressed("left click"):
			var chive_instance = chives.instantiate()
			add_child(chive_instance)
			chive_instance.position = $michael_plot/placement_mechanic/chive_placeable.position
			emit_signal("chive_placed")
			print("working like usual")
	if selected_chives == false:
		$michael_plot/placement_mechanic/chive_placeable.visible = false
	
func _physics_process(_delta):
	if quest_is_finished:
		var pathfollower = $spawn/zea_walk_cutscene/first_cutscene_follow2/PathFollow2D
		var pathfollower2 = $spawn/zea_walk_cutscene/second_cutscene_follow2/PathFollow2D
		
		if is_pathfollowing:
#			emit_signal("start_music")
#			background_music.stop()
#			zea_backgroundsong.play()
			pathfollower2.visible = false
			pathfollower.visible = true
			quest_camera.enabled = true
			quest_camera2.enabled = false
			$spawn/zea_walk_cutscene/first_cutscene_follow2/PathFollow2D/AnimatedSprite2D.play("walk_up")
			$spawn/zea_walk_cutscene/first_cutscene_follow2/PathFollow2D/AnimatedSprite2D2.play("walk_n")
			camera.enabled = false
			#
			cutscenecam.enabled = false
			#$Node2D/world2/world2openingcutscene/Path2D/PathFollow2D/Camera2D.enabled = false
			pathfollower.progress_ratio += 0.007
			if pathfollower.progress_ratio >= 1:
				is_pathfollowing2 = true
		if is_pathfollowing2:
			pathfollower.visible = false
			pathfollower2.visible = true
			camera.enabled = false
			$spawn/henry_cutscene/world2openingcutscene/Path2D/PathFollow2D/Camera2D.enabled = false
			quest_camera.enabled = false
			quest_camera2.enabled = true
			$spawn/zea_walk_cutscene/second_cutscene_follow2/PathFollow2D/AnimatedSprite2D.play("walk_left")
			$spawn/zea_walk_cutscene/second_cutscene_follow2/PathFollow2D/AnimatedSprite2D2.play("walk_w")
			pathfollower2.progress_ratio += 0.001
			if pathfollower2.progress_ratio >= 1:
				player.position = Vector2(-1000, -1000)
				quest_camera.enabled = false
				quest_camera2.enabled = false
				camera.enabled = false
				cutscene_cam.enabled = true
				is_pathfollowing = false
				is_pathfollowing2 = false
				$scenetwo/second_dialogue_zea.visible = true
				$scenetwo/second_dialogue_zea.start()
	if is_openingcutscene:
		var henryfollower = $spawn/henry_cutscene/world2openingcutscene/Path2D/PathFollow2D
		var henryfollower2 = $spawn/henry_cutscene/world2openingcutscene/Path2D2/PathFollow2D
		
		if is_henryfollowing:
			henryfollower.progress_ratio += 0.002
			
			
			if henryfollower.progress_ratio >= 1:
				cutsceneending()
				
		if is_henryfollowing2:
			henryfollower2.progress_ratio += 0.001
			$spawn/henry_cutscene/world2openingcutscene/Path2D2/PathFollow2D/AnimatedSprite2D.play("default")
			
			if henryfollower2.progress_ratio >= 1:
				cutsceneending()


#func _on_area_2d_body_entered(body):
#	get_tree().change_scene_to_file("res://transition.tscn")

func _on_npc_quest_is_finished():
	quest_is_finished = true
	player.position = Vector2(-1000,0)
	is_pathfollowing = true

func _on_npc_quest_quest_finished():
	quest_is_finished = true
	player.position = Vector2(-1000,0)
	is_pathfollowing = true

func _on_second_dialogue_zea_dialogue_finished():
	print("test")
	camera.enabled = true
	cutscene_cam.enabled = false
	player.position = Vector2(-5100,-3031)

func _on_cutscene_trigger_body_entered(body):
	cutscene_cam.enabled = true
	camera.enabled = false
#	player..enabled = false
	$scenetwo/zea.visible = true
	$scenetwo/AnimatedSprite2D.visible = true
	$scenetwo/second_dialogue_zea.visible = true
	$scenetwo/second_dialogue_zea.start()

func _on_enter_house_body_entered(body):
#	if zea_house_happened == "false":
	inside_zea_cam.enabled = true
	camera.enabled = false
	unknown_dialogue.visible = true
	unknown_dialogue.start()
	man.visible = true
	house_player.visible = true
	player.position = Vector2(-8721,-381)
	if zea_house_happened == "true":
		inside_zea_cam.enabled = true
		camera.enabled = false
		unknown_dialogue.visible = false
		man.visible = false
		house_player.visible = false
		player.position = Vector2(-8721,-381)

func _on_area_2d_body_entered(body):
	player.position = Vector2(-1000, -1000)
	camera.enabled = false
	cutscene_cam.enabled = true
	$scenetwo/second_dialogue_zea.visible = true
	$scenetwo/second_dialogue_zea.start()


func _on_exit_house_body_entered(body):
	inside_zea_cam.enabled = false
	camera.enabled = true
	unknown_dialogue.visible = false
	man.visible = false
	player.position = Vector2(-5069,-2873)
	zea_house_happened = "true"


func _on_unknown_dialogue_dialogue_finished():
	inside_zea_cam.enabled = true
	camera.enabled = false
	unknown_dialogue.visible = false
	man.visible = true
	house_player.visible = false


func _on_area_2d_2_body_entered(body):
	player.position =  Vector2(-5571,-8305.001)


func _on_top_mt_entrance_body_entered(body):
	logcam.enabled = false
	zeadialogue.visible = false
	markdialogue.visible = false
	$mt_crag/top_of_mt_crag/Sprite2D.visible = false
#
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	its_true = true
#
#
func _on_log_seat_sitting():
	if Input.is_action_just_pressed("e"):
		logcam.enabled = true
		michaelsprite.visible = true
#
#
func _on_mtcrag_cutscene_trigger_body_entered(body):
	zeadialogue.visible = true
	cutscenecam.enabled = true
	camera.enabled = false
#
#
#
func _on_third_zea_dialogue_dialogue_finished():
	markdialogue.visible = true
	zeadialogue.visible = false
	$mt_crag/top_of_mt_crag/Sprite2D.visible = true
#
#

func _on_mark_dialogue_dialogue_finished():
	markdialogue.visible = false
	cutscenecam.enabled = false
	$mt_crag/top_of_mt_crag/mtcrag_cutscene_trigger.monitoring = false
	$mt_crag/top_of_mt_crag/Sprite2D.visible = false
	camera.enabled = true
	player.position = $sandbox_post_cutscene.position

#
#func _on_redbaneberry_picked_up():
#		custom()
#
#func custom():
#	Tilemanager.tilemap = $michael_plot/test_enviroment/test2/TileMap
#	$michael_plot/test_enviroment/test2/redbane_placeable.visible = true
#	yes = true
#	if Input.is_action_just_pressed("e"):
#		var redbaneberry_instance = redbaneberry.instantiate()
#		add_child(redbaneberry_instance)
#		redbaneberry_instance.position = $michael_plot/test_enviroment/test2/redbane_placeable.position
#		print("working like usual")
#		var chive_instance = chives.instantiate()
#		add_child(chive_instance)
#		chive_instance.position = $michael_plot/test_enviroment/test2/chive_placeable.position

func cutscene_start():
	$michael_plot/map/dialogue.visible = true
	$michael_plot/map/dialogue/zea.visible = true
	$michael_plot/map/dialogue/Sprite2D.visible = true 
	
func cutscene_end():
	$michael_plot/map/dialogue.visible = false
	$michael_plot/mapt/dialogue/zea.visible = false
	$michael_plot/map/dialogue/Sprite2D.visible = false

func _on_first_philip_dialogue_dialogue_finished():
	cutscene_end()
	
#func filter(item):
#	if item.name == "redbaneberry":
#		print("nig")
#

func _on_player_redbane_collected():
	redbane = redbane + 1


func _on_player_chive_collected():
	chive = chive + 1
	
func _on_player_detection_body_entered(body): #Tells the Script what to do if a player has entered a ChildNode(Ex. a button, label, an image) but specifically an Area2D node which registers players in a set area
	if body.has_method("player"): #If the body that enters is a player
		player = body #Player is the same as Body
		if !has_player_entered_area: #If the player has not entered the area do this:
			has_player_entered_area = true #Has the player entered the area
			cutsceneopening() #Starts the function below
			
func cutsceneopening(): #Instructions of what the Cutscene Opening will contain
	is_openingcutscene = true #Is the Opening Cutscene active
	animplayer.play("color_fade") #Plays an animation, and this one is a simple color fading overlay
	player.camera.enabled = false #Disables the Player's integrated camera
	henry_camera.enabled = true #Enables the cutscene camera
	cutscenecam.enabled = false
	is_henryfollowing = true #Makes it so that the camera follows a set path
	is_henryfollowing2 = true
	$spawn/henry_cutscene/world2openingcutscene/Path2D2/PathFollow2D/AnimatedSprite2D.play("default")
	
func cutsceneending(): #Instructions of what the Cutscene Ending will contain
	is_henryfollowing = false #Stops the camera's set path following
	is_openingcutscene = false #Has the opening cutscene not happened
	henry_camera.enabled = false #Stops the cutscene camera
	player.camera.enabled = true #Switches to the Player's integrated camera
	$spawn/henry_cutscene/world2openingcutscene.visible = false #The cutscene is not visible
	$spawn/henry_cutscene/world2main.visible = true #Normal player scene
	$spawn/henry_cutscene/world2openingcutscene/Path2D2/PathFollow2D/AnimatedSprite2D.visible = false


func _on_judge_trigger_body_entered(body):
	punisher_anim.play("morph")


#func _on_boykisser_player_death():
#	emit_signal("disable_player")
#	background_music.stop()
#	death_music.play()
#	$player/AnimatedSprite2D.play("death")
#	await get_tree().create_timer(1.5).timeout
#	death_screen.visible = true
	


func _on_phillip_merchant_chive_purchase():
	if chive > 10:
		redbane_sold = true
		chive_sold = false
		pinecone_sold = false
		money_counter.text = str(money_count + 1)
		money_count = money_count + 1
		chive = chive - 10
		
	else:
		money_counter.text = str("INVALID")
		await get_tree().create_timer(0.5).timeout
		money_counter.text = str(money_count)


func _on_phillip_merchant_redbane_purchase():
	if redbane > 10:
		redbane_sold = false
		chive_sold = false
		pinecone_sold = true
		money_counter.text = str(money_count + 1)
		money_count = money_count + 1
		redbane = redbane - 10
		emit_signal("update_slot")
	else:
		money_counter.text = str("INVALID")
		await get_tree().create_timer(0.5).timeout
		money_counter.text = str(money_count)


func _on_sunset_cycle_animation_finished(anim_name):
	phase = "night"


func _on_sunrise_cycle_animation_finished(anim_name):
	phase = "day"
	day_counter.text = str(day_count + 1)
	day_count = day_count + 1


func _on_night_cycle_animation_finished(anim_name):
	phase = "sunrise"


func _on_day_cycle_animation_finished(anim_name):
	phase = "sunset"
	
func _on_player_world_disable_building():
	$michael_plot/placement_mechanic/redbane_placeable.visible = false
	selected_redbane = false
	$michael_plot/placement_mechanic/chive_placeable.visible = false
	selected_chives = false


#func _on_crafting_menu_disable_world_build():
#	redbane_collected = false
#	$test2/redbane_placeable.visible = false


#func _on_chive_picked_up():
#	Tilemanager.tilemap = $test2/TileMap
#	$test2/chive_placeable.visible = true
#	yes = true
#	if Input.is_action_just_pressed("e"):
#		chive_collected = true
#		redbane_collected = false


func _on_chive_placed():
	chive = chive - 1
	player.deprive(item)
	print("less chives")



func _on_player_chive_selected():
	print("Chives have been selected in the main scene!")
	$michael_plot/placement_mechanic/chive_placeable.visible = true
	selected_chives = true
	selected_redbane = false


func _on_player_redbane_selected():
	print("Redbane have been selected in the main scene!")
	$michael_plot/placement_mechanic/redbane_placeable.visible = true
	selected_chives = false
	selected_redbane = true


func _on_disable_building():
	selected_redbane = false
	$michael_plot/placement_mechanic/chive_placeable.visible = false
#	$test2/chive_placeable.visible = false
	selected_chives = false
	$michael_plot/placement_mechanic/redbane_placeable.visible = false

func _on_crafting_menu_disable_world_build():
	redbane_collected = false
	$michael_plot/placement_mechanic/redbane_placeable.visible = false


func _on_redbane_placed():
	redbane = redbane - 1
	player.deprive(item)
	print("less redbanes")

func _on_deer_deer_clear():
	pass


func _on_cave_entry_body_entered(body):
	player.position = $player_entry.position


func _on_cave_exited_cave():
	player.position = $cave_entry_location.position


func _on_brock_started_hunting():
	Tilemanager.tilemap = $test2/TileMap


func _on_phillip_merchant_axe_purchase():
	player.can_move = false
	player.alt_move_set = true
	player.wields_axe = true
	item = preload("res://scenes/items/iron_axe.tres")
	player.collect(item)
#	$Node2D/objects/player/AnimatedSprite2D.play("wield_walk_s")
	print("WIELD THE TOOL!!!!!!!!")
