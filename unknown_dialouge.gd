extends CanvasLayer

func _ready():
	$dialouge_box.visible = false
	get_tree().create_timer(2)
	$dialouge_box.visible = true
		
