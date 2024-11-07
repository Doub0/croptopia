extends Node2D




func _on_area_2d_2_body_entered(body):
	get_tree().change_scene_to_file("res://top_of_mt_crag.tscn")
