extends Node2D

var state = "no chive"
var player_in_area = false

var chive = preload("res://chive_collectable.tscn")

signal picked_up

@export var item: InvItem
var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	if state == "no chive":
		$growth_timer.start()
		
func _process(delta):
	if state == "no chive":
		$AnimatedSprite2D.play("no_chive")
	if state == "chive":
		$AnimatedSprite2D.play("chive")
		if player_in_area:
			if Input.is_action_just_pressed("e"):
				state = "no chive"
				drop_chive()
				$AnimatedSprite2D.play("chive")

func _on_pickable_area_body_entered(body):
	if body.has_method("player"):
		player_in_area = true
		player = body


func _on_pickable_area_body_exited(body):
	if body.has_method("player"):
		player_in_area = false


func _on_growth_timer_timeout():
	if state == "no chive":
		state = "chive"
		
func drop_chive():
	
	await get_tree().create_timer(0.0).timeout
	var chive_instance = chive.instantiate()
	chive_instance.rotation = rotation
	chive_instance.global_position = $Marker2D.global_position
	get_parent().add_child(chive_instance)
	player.collect(item)
	emit_signal("picked_up")
	await get_tree().create_timer(3).timeout
	$growth_timer.start()
