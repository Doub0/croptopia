extends Node2D


@onready var soldier = preload("res://scenes/lunar_soldier.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var soldier_instance = soldier.instantiate()
	if Input.is_action_just_pressed("Inventory"):
		soldier_instance.position = $spawn_pos.position
		add_child(soldier_instance)
		print("Should be generated")
