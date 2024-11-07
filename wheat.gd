extends Node2D

var state = "no wheat"
var player_in_area = false

var wheat = preload("res://wheat_collectable.tscn")

@export var item: InvItem
var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	if state == "no wheat":
		$growth_timer.start()
		
func _process(delta):
	if state == "no wheat":
		$AnimatedSprite2D.play("no_wheat")
	if state == "wheat":
		$AnimatedSprite2D.play("wheat")
		if player_in_area:
			if Input.is_action_just_pressed("e"):
				state = "no wheat"
				drop_chive()
				$AnimatedSprite2D.play("wheat")

func _on_pickable_area_body_entered(body):
	if body.has_method("player"):
		player_in_area = true
		player = body


func _on_pickable_area_body_exited(body):
	if body.has_method("player"):
		player_in_area = false


func _on_growth_timer_timeout():
	if state == "no wheat":
		state = "wheat"
		
func drop_chive():
	
	await get_tree().create_timer(0.0).timeout
	var wheat_instance = wheat.instantiate()
	wheat_instance.rotation = rotation
	wheat_instance.global_position = $Marker2D.global_position
	get_parent().add_child(wheat_instance)
	player.collect(item)
	await get_tree().create_timer(3).timeout
	$growth_timer.start()

