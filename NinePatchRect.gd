extends NinePatchRect


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	get_tree().create_timer(2)
	visible = true
