extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

	
func _on_area_2d_body_entered(body):
	if Input.is_action_just_pressed("e"):
		get_tree().change_scene_to_file("res://inside_zea_house.tscn")
