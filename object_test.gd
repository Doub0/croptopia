extends Sprite2D

func _process(delta):
	var mouse_tile = Tilemanager.tilemap.local_to_map(get_global_mouse_position())
	var local_pos = Tilemanager.tilemap.map_to_local(mouse_tile)
	var world_pos = Tilemanager.tilemap.to_global(local_pos)
	global_position = world_pos

#func _on_area_2d_body_entered(body):
#	$area2D/CollisionShape2D.modulate[]
	

func _on_area_2d_area_entered(area):
	$area2D/CollisionShape2D.modulate = Color(255,0,0)


func _on_area_2d_area_exited(area):
	$area2D/CollisionShape2D.modulate = Color(0,255,0)
