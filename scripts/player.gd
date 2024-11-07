extends CharacterBody2D

const speed = 100
var current_dir = "none"
var alt_dir = "none"
var player_state

var can_move

var alt_move_set = false
#
var save_file_path = "user://Saves/"
var save_file_name = "PlayerSave.tres"

var playerData = gamesaves.new()
#
signal stick_collected()
signal stick_held()
signal baneberry_held()
#
signal pinecone_collected()
signal elderberry_collected()
signal sorrel_collected()
signal redbane_collected()
signal chive_collected()

signal world_disable_building()

signal slot_1_selected
signal slot_2_selected
signal slot_3_selected
signal slot_4_selected
signal slot_5_selected
signal slot_6_selected
signal slot_7_selected
signal slot_8_selected
#
signal redbane_selected
signal chive_selected

signal tool_hit

var wields_axe = false

#var disable_build = false
@onready var item_sprite = $item_sprite

@onready var item_west_pos = $item_west_pos
@onready var item_north_pos = $item_north_pos
@onready var item_east_pos = $item_east_pos
@onready var item_south_pos = $item_south_pos

@onready var arm_movement = $arm_movement
@onready var item_movement = $item_movement
@export var inv: Inv
@export var item: InvItem
@onready var Item_Stick = "res://stick.tres"
@onready var camera = $Camera2D
@onready var test = preload("res://inventory/playerinv.tres")

func _ready():
	verify_save_directory(save_file_path)
	$AnimatedSprite2D.play("walk_down_idle")
	
	can_move = true
	arm_movement.visible = false
	item_movement.playback_active = false
func verify_save_directory(path: String):
	DirAccess.make_dir_absolute(path)
	
func _physics_process(_delta):
	player_move(_delta)
	# SAVE FUNCTIONS
func load_data():
	if ( ResourceLoader.exists( save_file_path + save_file_name ) ):
		playerData = ResourceLoader.load( save_file_path + save_file_name ).duplicate(true)
#		playerData = ResourceLoader.load(save_file_path + save_file_name).duplicate(true)
	on_start_load()
	print("loaded")
func save():
	ResourceSaver.save( playerData, save_file_path + save_file_name )
	print("saved")
func on_start_load():
	self.position = playerData.Save_pos
	#
func player_move(_delta):
	if can_move == true:
		if Input.is_action_pressed("up") and Input.is_action_pressed("left"):
			current_dir = "up-left"
			play_anim(1)
			velocity.y = -50
			velocity.x = -50
		elif Input.is_action_pressed("up") and Input.is_action_pressed("right"):
			current_dir = "up-right"
			play_anim(1)
			velocity.y = -50
			velocity.x = 50
		elif Input.is_action_pressed("down") and Input.is_action_pressed("left"):
			current_dir = "down-left"
			play_anim(1)
			velocity.y = 50
			velocity.x = -50
		elif Input.is_action_pressed("down") and Input.is_action_pressed("right"):
			current_dir = "down-right"
			play_anim(1)
			velocity.y = 50
			velocity.x = 50
		
		elif Input.is_action_pressed("Sprint-w"): #and Input.is_action_pressed("up"):
			current_dir = "sprint-forward"
			play_anim(1)
			velocity.y = -200
			velocity.x = 0
		elif Input.is_action_pressed("Sprint-a"):
			current_dir = "sprint-left"
			play_anim(1)
			velocity.y = 0
			velocity.x = -200
		elif Input.is_action_pressed("Sprint-s"):
			current_dir = "sprint-backwards"
			play_anim(1)
			velocity.y = 200
			velocity.x = 0
		elif Input.is_action_pressed("Sprint-d"):
			current_dir = "sprint-right"
			play_anim(1)
			velocity.y = 0
			velocity.x = 200
			
		elif Input.is_action_pressed("up"):
			current_dir = "up"
			play_anim(1)
			velocity.y = -100
			velocity.x = 0
			
		elif Input.is_action_pressed("left"):
			current_dir = "left"
			play_anim(1)
			velocity.x = -100
			velocity.y = 0
		elif Input.is_action_pressed("down"):
			current_dir = "down"
			play_anim(1)
			velocity.y = 100
			velocity.x = 0
		elif Input.is_action_pressed("right"):
			current_dir = "right"
			play_anim(1)
			velocity.x = 100
			velocity.y = 0
		#SPRINT MECHANICS#
			
		#remove later
		
		#elif Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_right"):
			#current_dir = ""
		else:
			play_anim(0)
			velocity.x = 0
			velocity.y = 0
			
		move_and_slide()
#	if can_move == false:
#		return
		
	if alt_move_set == true:
		print("Wield Moveset")
		if Input.is_action_pressed("up"):
			alt_dir = "up"
			$AnimatedSprite2D.play("wield_walk_n")
			item_sprite.show_behind_parent = true
			item_sprite.rotation = 0
			$AnimatedSprite2D.flip_h = false 
			item_sprite.texture = preload("res://assets/iron_axe_back.png")
			item_sprite.position = item_north_pos.position
			velocity.y = -100
			velocity.x = 0
			
		elif Input.is_action_pressed("left"):
			alt_dir = "left"
			$AnimatedSprite2D.flip_h = false
			item_sprite.show_behind_parent = false
			item_sprite.rotation = 0
			$AnimatedSprite2D.play("wield_walk_w")
			item_sprite.texture = preload("res://assets/iron_axe.png")
			item_sprite.flip_h = true
			item_sprite.position = item_west_pos.position
			velocity.x = -100
			velocity.y = 0
		elif Input.is_action_pressed("down"):
			alt_dir = "down"
			$AnimatedSprite2D.play("wield_walk_s")
			item_sprite.show_behind_parent = false
			item_sprite.rotation = 0
			$AnimatedSprite2D.flip_h = false
			item_sprite.texture = preload("res://assets/iron_axe_front.png")
			item_sprite.position = item_south_pos.position
			velocity.y = 100
			velocity.x = 0
		elif Input.is_action_pressed("right"):
			alt_dir = "right"
			$AnimatedSprite2D.flip_h = true
			item_sprite.show_behind_parent = false
			item_sprite.rotation = -45
			$AnimatedSprite2D.play("wield_walk_w")
			item_sprite.texture = preload("res://assets/iron_axe.png")
			item_sprite.flip_h = false
			item_sprite.position = item_east_pos.position
			velocity.x = 100
			velocity.y = 0	
		else:
			$AnimatedSprite2D.play("wield_walk_idle_s")
			item_sprite.show_behind_parent = false
			item_sprite.rotation = 0
			$AnimatedSprite2D.flip_h = false
			item_sprite.texture = preload("res://assets/iron_axe_front.png")
			item_sprite.position = item_south_pos.position
			velocity.y = 0
			velocity.x = 0
		move_and_slide()
	if wields_axe == true:
		print("Axe in hand")
		if alt_dir == "down":
			arm_movement.visible = false
			if Input.is_action_pressed("left click"):
				arm_movement.visible = true
				arm_movement.play("front")
				item_movement.playback_active = true
				item_movement.play("slash_front")
				
				emit_signal("tool_hit")
		elif alt_dir == "left":
			arm_movement.visible = false
			if Input.is_action_pressed("left click"):
				arm_movement.visible = true
				item_movement.playback_active = true
				arm_movement.play("left")
				item_movement.play("slash_left")
				
				emit_signal("tool_hit")
		elif alt_dir == "up":
			arm_movement.visible = false
			if Input.is_action_pressed("left click"):
				arm_movement.visible = true
				item_movement.playback_active = true
				arm_movement.play("back")
				item_movement.play("slash_back")
				
				emit_signal("tool_hit")
		elif alt_dir == "right":
			arm_movement.visible = false
			if Input.is_action_pressed("left click"):
				arm_movement.visible = true
				item_movement.playback_active = true
				arm_movement.play("right")
				item_movement.play("slash_right")
				
				emit_signal("tool_hit")
	if Input.is_action_pressed("chat"):
		wields_axe = true
		alt_move_set = true
			
func _process(delta):
	#print(inv.chive_amount) #PRINT CHIVE AMOUNT
	if Input.is_action_just_pressed("k"):
		save()
	if Input.is_action_just_pressed("l"):
		load_data()
	playerData.Update_pos(self.position)
	if Input.is_action_just_pressed("1"):
		inv.select(item)
		inv.selected_slot_1 = true
		inv.selected_slot_2 = false
		inv.selected_slot_3 = false
		inv.selected_slot_4 = false
		inv.selected_slot_5 = false
		inv.selected_slot_6 = false
		inv.selected_slot_7 = false
		inv.selected_slot_8 = false
		emit_signal("slot_1_selected")
		if inv.slot_1_h_rb == true:
			emit_signal("redbane_selected")
			inv.slot_1_h_ch = false
			inv.slot_2_h_rb = false
			inv.slot_2_h_ch = false
			inv.slot_3_h_rb = false
			inv.slot_3_h_ch = false
			inv.slot_4_h_rb = false
			inv.slot_4_h_ch = false
			inv.slot_5_h_rb = false
			inv.slot_5_h_ch = false
			inv.slot_6_h_rb = false
			inv.slot_6_h_ch = false
			inv.slot_7_h_rb = false
			inv.slot_7_h_ch = false
			inv.slot_8_h_rb = false
			inv.slot_8_h_ch = false
		if inv.slot_1_h_ch == true:
			emit_signal("chive_selected")
			inv.slot_1_h_rb = false
			inv.slot_2_h_rb = false
			inv.slot_2_h_ch = false
			inv.slot_3_h_rb = false
			inv.slot_3_h_ch = false
			inv.slot_4_h_rb = false
			inv.slot_4_h_ch = false
			inv.slot_5_h_rb = false
			inv.slot_5_h_ch = false
			inv.slot_6_h_rb = false
			inv.slot_6_h_ch = false
			inv.slot_7_h_rb = false
			inv.slot_7_h_ch = false
			inv.slot_8_h_rb = false
			inv.slot_8_h_ch = false
		if inv.slot_1_h_iax == true:
			wields_axe = true
			inv.slot_1_h_rb = false
			inv.slot_2_h_rb = false
			inv.slot_2_h_ch = false
			inv.slot_3_h_rb = false
			inv.slot_3_h_ch = false
			inv.slot_4_h_rb = false
			inv.slot_4_h_ch = false
			inv.slot_5_h_rb = false
			inv.slot_5_h_ch = false
			inv.slot_6_h_rb = false
			inv.slot_6_h_ch = false
			inv.slot_7_h_rb = false
			inv.slot_7_h_ch = false
			inv.slot_8_h_rb = false
			inv.slot_8_h_ch = false
			print("Axe in slot 1")
	if Input.is_action_just_pressed("2"):
		inv.select(item)
		inv.selected_slot_1 = false
		inv.selected_slot_2 = true
		inv.selected_slot_3 = false
		inv.selected_slot_4 = false
		inv.selected_slot_5 = false
		inv.selected_slot_6 = false
		inv.selected_slot_7 = false
		inv.selected_slot_8 = false
		emit_signal("slot_2_selected")
		if inv.slot_2_h_rb == true:
			emit_signal("redbane_selected")
			inv.slot_1_h_ch = false
			inv.slot_1_h_rb = false
			inv.slot_2_h_ch = false
			inv.slot_3_h_rb = false
			inv.slot_3_h_ch = false
			inv.slot_4_h_rb = false
			inv.slot_4_h_ch = false
			inv.slot_5_h_rb = false
			inv.slot_5_h_ch = false
			inv.slot_6_h_rb = false
			inv.slot_6_h_ch = false
			inv.slot_7_h_rb = false
			inv.slot_7_h_ch = false
			inv.slot_8_h_rb = false
			inv.slot_8_h_ch = false
		if inv.slot_2_h_ch == true:
			emit_signal("chive_selected")
			inv.slot_1_h_ch = false
			inv.slot_1_h_rb = false
			inv.slot_2_h_rb = false
			inv.slot_3_h_rb = false
			inv.slot_3_h_ch = false
			inv.slot_4_h_rb = false
			inv.slot_4_h_ch = false
			inv.slot_5_h_rb = false
			inv.slot_5_h_ch = false
			inv.slot_6_h_rb = false
			inv.slot_6_h_ch = false
			inv.slot_7_h_rb = false
			inv.slot_7_h_ch = false
			inv.slot_8_h_rb = false
			inv.slot_8_h_ch = false
	if Input.is_action_just_pressed("3"):
		inv.select(item)
		inv.selected_slot_1 = false
		inv.selected_slot_2 = false
		inv.selected_slot_3 = true
		inv.selected_slot_4 = false
		inv.selected_slot_5 = false
		inv.selected_slot_6 = false
		inv.selected_slot_7 = false
		inv.selected_slot_8 = false
		emit_signal("slot_3_selected")
		if inv.slot_3_h_rb == true:
			emit_signal("redbane_selected")
		elif inv.slot_3_h_ch == true:
			emit_signal("chive_selected")
	if Input.is_action_just_pressed("4"):
		inv.select(item)
		inv.selected_slot_1 = false
		inv.selected_slot_2 = false
		inv.selected_slot_3 = false
		inv.selected_slot_4 = true
		inv.selected_slot_5 = false
		inv.selected_slot_6 = false
		inv.selected_slot_7 = false
		inv.selected_slot_8 = false
		emit_signal("slot_4_selected")
		if inv.slot_4_h_rb == true:
			emit_signal("redbane_selected")
		elif inv.slot_4_h_ch == true:
			emit_signal("chive_selected")
	if Input.is_action_just_pressed("5"):
		inv.select(item)
		inv.selected_slot_1 = false
		inv.selected_slot_2 = false
		inv.selected_slot_3 = false
		inv.selected_slot_4 = false
		inv.selected_slot_5 = true
		inv.selected_slot_6 = false
		inv.selected_slot_7 = false
		inv.selected_slot_8 = false
		emit_signal("slot_5_selected")
		if inv.slot_5_h_rb == true:
			emit_signal("redbane_selected")
		elif inv.slot_5_h_ch == true:
			emit_signal("chive_selected")
	if Input.is_action_just_pressed("6"):
		inv.select(item)
		inv.selected_slot_1 = false
		inv.selected_slot_2 = false
		inv.selected_slot_3 = false
		inv.selected_slot_4 = false
		inv.selected_slot_5 = false
		inv.selected_slot_6 = true
		inv.selected_slot_7 = false
		inv.selected_slot_8 = false
		emit_signal("slot_6_selected")
		if inv.slot_6_h_rb == true:
			emit_signal("redbane_selected")
		elif inv.slot_6_h_ch == true:
			emit_signal("chive_selected")
	if Input.is_action_just_pressed("7"):
		inv.select(item)
		inv.selected_slot_1 = false
		inv.selected_slot_2 = false
		inv.selected_slot_3 = false
		inv.selected_slot_4 = false
		inv.selected_slot_5 = false
		inv.selected_slot_6 = false
		inv.selected_slot_7 = true
		inv.selected_slot_8 = false
		emit_signal("slot_7_selected")
		if inv.slot_7_h_rb == true:
			emit_signal("redbane_selected")
		elif inv.slot_7_h_ch == true:
			emit_signal("chive_selected")
	if Input.is_action_just_pressed("8"):
		inv.select(item)
		inv.selected_slot_1 = false
		inv.selected_slot_2 = false
		inv.selected_slot_3 = false
		inv.selected_slot_4 = false
		inv.selected_slot_5 = false
		inv.selected_slot_6 = false
		inv.selected_slot_7 = false
		inv.selected_slot_8 = true
		emit_signal("slot_8_selected")
		if inv.slot_8_h_rb == true:
			emit_signal("redbane_selected")
		elif inv.slot_8_h_ch == true:
			emit_signal("chive_selected")
	if inv.disable_build == true:
		disable_build()
		inv.disable_build = false
#	if inv.disable_build == false:
#		print("Don't disable build :C")
#		if disable_build == true:
#			print("disable building!!!!!!!!!!!!!!!")
#			emit_signal("disable_building")
func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	if dir == "up-left":
		anim.flip_h = false
		if movement == 1:
			anim.play("walk_left")
		elif movement == 0:
			anim.play("walk_left_idle")
	if dir == "up-right":
		anim.flip_h = true
		if movement == 1:
			anim.play("walk_left")
		elif movement == 0:
			anim.play("walk_left_idle")
	if dir == "down-left":
		anim.flip_h = false
		if movement == 1:
			anim.play("walk_left")
		elif movement == 0:
			anim.play("walk_left_idle")
	if dir == "down-right":
		anim.flip_h = true
		if movement == 1:
			anim.play("walk_left")
		elif movement == 0:
			anim.play("walk_left_idle")
	if dir == "left":
		anim.flip_h = false
		if movement == 1:
			anim.play("walk_left")
		elif movement == 0:
			anim.play("walk_left_idle")
	if dir == "right":
		anim.flip_h = true
		if movement == 1:
			anim.play("walk_left")
		elif movement == 0:
			anim.play("walk_left_idle")
	if dir == "down":
		anim.flip_h = true
		if movement == 1:
			anim.play("walk_down")
		elif movement == 0:
			anim.play("walk_down_idle")
	if dir == "up":
		anim.flip_h = true
		if movement == 1:
			anim.play("walk_up")
		elif movement == 0:
			anim.play("walk_up_idle")
			
	if dir == "sprint-forward":
		anim.flip_h = false
		if movement == 1:
			anim.play("walk_up")
		elif movement == 0:
			anim.play("walk_up_idle")
	if dir == "sprint-left":
		anim.flip_h = false
		if movement == 1:
			anim.play("walk_left")
		elif movement == 0:
			anim.play("walk_left_idle")
	if dir == "sprint-backwards":
		anim.flip_h = false
		if movement == 1:
			anim.play("walk_down")
		elif movement == 0:
			anim.play("walk_down_idle")
	if dir == "sprint-right":
		anim.flip_h = true
		if movement == 1:
			anim.play("walk_left")
		elif movement == 0:
			anim.play("walk_up_idle")
func _on_player_detection_body_entered():
	print("Body entered")
	
func player():
	pass
	
func collect(item):
	inv.insert(item)
	#print(item)
	if str(item) == Item_Stick:
		print("picked up stick")
		emit_signal("stick_collected")
	if item.name == "Stick":
		print(item.name)
		emit_signal("stick_collected")
	#	
	if item.name == "Elderberry":
		print(item.name)
		emit_signal("elderberry_collected")
		
	if item.name == "pinecone":
		print(item.name)
		emit_signal("pinecone_collected")
		
	if item.name == "redbaneberry":
		print(item.name)
		emit_signal("redbane_collected")
		
	if item.name == "Sorrel":
		print(item.name)
		emit_signal("sorrel_collected")
		
	if item.name == "Chives":
		print(item.name)
		emit_signal("chive_collected")
		
	if item.name == "Wheat":
		print(item.name)
		emit_signal("wheat_collected")
	#
	if str(item) == "<Resource#-9223371984006543980>":
		print("picked up stick")
		emit_signal("stick_collected")
	if str(item) == "<Resource#-9223371933943331429>":
		print("picked up stick")
		emit_signal("stick_collected")
	if str(item) == "<Resource#-9223371982899247729>":
		print("picked up stick")
		emit_signal("stick_collected")
	if str(item) == "<Resource#-9223371979376032353>":
		print("picked up stick")
		emit_signal("stick_collected")
	if str(item) == "<Resource#-9223371968873495145>":
		print("picked up stick")
		emit_signal("stick_collected")
		if str(item) == "<Resource#-9223371982899247729>":
			print("picked up stick")
			emit_signal("stick_collected")
#	if Input.is_action_just_pressed("1"):
#		if item.name == "Stick":
#			emit_signal("stick_held")
	if Input.is_action_just_pressed("1"):
		if item.name == "redbaneberry":
			emit_signal("baneberry_held")
	if inv.resource_name == "redbaneberry":
		if Input.is_action_just_pressed("1"):
			emit_signal("baneberry_held")		
	#if str(item) == "Resource#-9223371763822349058":
		#print("PICKED UP ELDERBERRY")
		#emit_signal("elderberry_collected")
	#if str(item) == "Resource#-922337176202718692":
		#print("PICKED UP RED BANEBERRY")
		#emit_signal("redbaneberry_collected")
	#if str(item) == "Resource#-9223371758252313289":
		#print("PICKED UP SORREL")
		#emit_signal("sorrel_collected")
	#if str(item) == "Resource#-9223371760232024798":
		#print("PICKED UP CHIVE")
		#emit_signal("chive_collected")


func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func rando(inv):
	if Input.is_action_just_pressed("1"):
		if test.item.name == "redbaneberry":
			emit_signal("baneberry_held")
			


func deprive(item):
	inv.decrease(item)


func _on_node_2d_baneberry_placed(item):
	inv.decrease(item)

func disable_build():
#	disable_build = true
#	if disable_build == true:
	print("disable building!!!!!!!!!!!!!!!")
	emit_signal("world_disable_building")


func _on_phillip_merchant_chive_purchase():
	print("Bought Redbane!")
	inv.chive_bought = true
	inv.shop(item)


func _on_phillip_merchant_pinecone_purchase():
	pass # Replace with function body.


func _on_phillip_merchant_redbane_purchase():
	print("Bought Chives!")
	inv.redbane_bought = true
	inv.shop(item)


func _on_deer_killed():
	pass # Replace with function body.
