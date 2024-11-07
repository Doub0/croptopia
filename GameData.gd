extends Resource

class_name gamesaves

@export var Save_pos: Vector2
@export var dont_happen: bool

func Update_pos(value: Vector2):
	Save_pos = value
func has_happened(dont_happen: bool):
	dont_happen = true
