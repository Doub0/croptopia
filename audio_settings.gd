extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_master_slider_value_changed(value):
	set_volume(0,value)


func _on_sound_slider_value_changed(value):
	set_volume(1,value)


func _on_music_slider_value_changed(value):
	set_volume(2,value)

func set_volume(idx, value):
	AudioServer.set_bus_volume_db(idx, linear_to_db(value))
