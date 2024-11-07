extends CharacterBody2D

const speed = 100
var current_dir = "none"
var player_state

signal stick_collected()
#
signal pinecone_collected()
signal elderberry_collected()
signal sorrel_collected()
signal redbane_collected()
signal chive_collected()
#
@export var inv: Inv

func _ready():
	$AnimatedSprite2D.play("walk_down_idle")
	
@onready var Item_Stick = "res://stick.tres"
@onready var camera = $Camera2D

func _physics_process(_delta):
	player_move(_delta)
	
func player_move(_delta):
	
	if Input.is_action_pressed("ui_up"):
		current_dir = "up"
		play_anim(1)
		velocity.y = -100
		velocity.x = 0
		
	elif Input.is_action_pressed("ui_left"):
		current_dir = "left"
		play_anim(1)
		velocity.x = -100
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		current_dir = "down"
		play_anim(1)
		velocity.y = 100
		velocity.x = 0
	elif Input.is_action_pressed("ui_right"):
		current_dir = "right"
		play_anim(1)
		velocity.x = 100
		velocity.y = 0
		
	#remove later
	elif Input.is_action_pressed("SHIFT"):
		current_dir = "up"
		play_anim(1)
		velocity.y = -200
		velocity.x = 0
	
	#elif Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_right"):
		#current_dir = ""
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0	
		
	move_and_slide()
	
func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
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
	if str(item) == "<<Resource#-9223371983721331293>":
		print("picked up stick")
		emit_signal("stick_collected")
	if str(item) == "<Resource#-9223371968873495145>":
		print("picked up stick")
		emit_signal("stick_collected")
	if str(item) == "<Resource#-9223371983738108517>":
		print("picked up stick")
		emit_signal("stick_collected")
		
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

