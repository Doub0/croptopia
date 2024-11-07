extends Node2D

#var object_test = preload("res://object_test.tscn").instantiate()

func _ready():
	pass
func _on_play_pressed():
	pass
func _process(delta):
	pass
	#if Input.is_action_just_pressed("Right-Click"):
		#add_child(object_test)
		#object_test.position = Vector2(0,0)


func _on_player_stick_held():
	Tilemanager.tilemap = $TileMap
