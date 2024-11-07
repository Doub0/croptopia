extends Node2D

var state = "no oak"
var player_in_area = false

var oak = preload("res://oak_collectable.tscn")

@export var item: InvItem
var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	if state == "no oak":
		$growth_timer.start()
		
func _process(delta):
	if state == "no oak":
		$AnimatedSprite2D.play("no_oak")
	if state == "oak":
		$AnimatedSprite2D.play("oak")
		if player_in_area:
			if Input.is_action_just_pressed("e"):
				state = "no oak"
				drop_oak()
				$AnimatedSprite2D.play("oak")

func _on_pickable_area_body_entered(body):
	if body.has_method("player"):
		player_in_area = true
		player = body


func _on_pickable_area_body_exited(body):
	if body.has_method("player"):
		player_in_area = false


func _on_growth_timer_timeout():
	if state == "no oak":
		state = "oak"
		
func drop_oak():
	
	await get_tree().create_timer(0.0).timeout
	var oak_instance = oak.instantiate()
	oak_instance.rotation = rotation
	oak_instance.global_position = $Marker2D.global_position
	get_parent().add_child(oak_instance)
	player.collect(item)
	await get_tree().create_timer(3).timeout
	$growth_timer.start()
