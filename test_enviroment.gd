extends Node2D

class_name world

@export var inv: Inv
@export var item: InvItem

@onready var sunset = $ui/sunset_rect/sunset_cycle
@onready var sunrise = $ui/sunrise_rect/sunrise_cycle
@onready var sunset_rect = $ui/sunset_rect
@onready var sunrise_rect = $ui/sunrise_rect

@onready var night_rect = $ui/night_rect
@onready var night = $ui/night_rect/night_cycle
@onready var day = $ui/day_rect/day_cycle
@onready var day_rect = $ui/day_rect

@onready var player = $Node2D/objects/player

#Day counter code
@onready var day_counter = $ui/CanvasLayer/Panel/Sprite2D/count
var day_count
#
var addition = 1

var sunset_time
var sunrise_time

var night_time
var day_time

var phase
#OBJECT VARIABLES

var redbaneberry = preload("res://redbaneberry.tscn")
var chives = preload("res://chive.tscn")
var yes = false

var has_baneberry = false
var has_chives = false

var selected_redbane = false
var selected_chives = false
var redbane_collected = false
var chive_collected = false

signal redbane_placed
signal chive_placed
signal decrease_redbane

signal disable_building

#SHOP VARIABLES

@onready var money_counter = $ui/money_count/Panel/Sprite2D/count
var money_count = 0

var redbane_sold
var chive_sold
var pinecone_sold

@onready var redbane_counter = $Node2D/objects/phillip_merchant/CanvasLayer/shop_ui/redbane_count
@onready var chive_counter = $Node2D/objects/phillip_merchant/CanvasLayer/shop_ui/chive_count
@onready var pinecone_counter = $Node2D/objects/phillip_merchant/CanvasLayer/shop_ui/pinecone_count

@export var redbane = 0
@export var chive = 0
@export var pinecone = 0

@onready var camera = $Node2D/objects/player/Camera2D
@onready var seller = $Node2D/objects/phillip_merchant

@onready var inventory = $Node2D/objects/player/CanvasLayer/Crafting_menu/Inv_UI/NinePatchRect/GridContainer/inv_UI_slot

signal update_slot
# Called when the node enters the scene tree for the first time.
func _ready():
	day_count = 0
	phase = "day"
	day_time = true

	Tilemanager.tilemap = $test2/TileMap
	$test2/redbane_placeable.visible = false
	$test2/chive_placeable.visible = false
	
	money_count = 0
	redbane = 0
	chive = 0
	pinecone = 0
	redbane_sold = false
	chive_sold = false
	pinecone_sold = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
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
		Tilemanager.tilemap = $test2/TileMap
		$test2/redbane_placeable.visible = true
		$test2/chive_placeable.visible = true
#		selected_redbane = true
#		chive_collected = false
#		selected_chives = false
		if Input.is_action_just_pressed("Right-Click") or Input.is_action_just_pressed("left click"):
			var redbaneberry_instance = redbaneberry.instantiate()
			add_child(redbaneberry_instance)
			redbaneberry_instance.position = $test2/redbane_placeable.position
			emit_signal("redbane_placed")
			print("working like usual")
	if selected_redbane == false:
		$test2/redbane_placeable.visible = false
	
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
		Tilemanager.tilemap = $test2/TileMap
		$test2/chive_placeable.visible = true
		$test2/redbane_placeable.visible = false
#		selected_chives = true
#		redbane_collected = false
#		selected_redbane = false
		if Input.is_action_just_pressed("Right-Click") or Input.is_action_just_pressed("left click"):
			var chive_instance = chives.instantiate()
			add_child(chive_instance)
			chive_instance.position = $test2/chive_placeable.position
			emit_signal("chive_placed")
			print("working like usual")
	if selected_chives == false:
		$test2/chive_placeable.visible = false

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


#func _on_redbaneberry_picked_up():
#	Tilemanager.tilemap = $test2/TileMap
#	$test2/redbane_placeable.visible = true
#	yes = true
#	if Input.is_action_just_pressed("e"):
#		redbane_collected = true
#		chive_collected = false
#		var redbaneberry_instance = redbaneberry.instantiate()
#		add_child(redbaneberry_instance)
#		redbaneberry_instance.position = $test2/redbane_placeable.position
##		print("working like usual")
#		var chive_instance = chives.instantiate()
#		add_child(chive_instance)
#		chive_instance.position = $test2/chive_placeable.position
		
		#CONTINUATIONS BELOW -----------------------------------------------------------

#func purchase():
#	money_counter.text = str(money_count + 1)
#	money_count = money_count + 1


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


func _on_phillip_merchant_pinecone_purchase():
#	if chive == 10:
#		redbane_sold = false
#		chive_sold = true
#		pinecone_sold = false
#		purchase()
	if pinecone > 10:
		redbane_sold = true
		chive_sold = false
		pinecone_sold = false
		money_counter.text = str(money_count + 1)
		money_count = money_count + 1
		pinecone = pinecone - 10
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


func _on_player_pinecone_collected():
	pinecone = pinecone + 1


func _on_player_redbane_collected():
	redbane = redbane + 1


func _on_player_chive_collected():
	chive = chive + 1


func _on_redbane_placed():
	redbane = redbane - 1
	player.deprive(item)

func _on_player_world_disable_building():
	$test2/redbane_placeable.visible = false
	selected_redbane = false
	$test2/chive_placeable.visible = false
	selected_chives = false


func _on_crafting_menu_disable_world_build():
	redbane_collected = false
	$test2/redbane_placeable.visible = false


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
	$test2/chive_placeable.visible = true
	selected_chives = true
	selected_redbane = false


func _on_player_redbane_selected():
	print("Redbane have been selected in the main scene!")
	$test2/redbane_placeable.visible = true
	selected_chives = false
	selected_redbane = true


func _on_disable_building():
	selected_redbane = false
	$test2/chive_placeable.visible = false
#	$test2/chive_placeable.visible = false
	selected_chives = false
	$test2/redbane_placeable.visible = false
