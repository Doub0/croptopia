extends Button

func _on_button_pressed():
	$Ghettosmosh.play()
	
func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/worldtest.tscn") 
