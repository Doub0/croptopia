extends Node2D

var state = "no redbaneberry"
var player_in_area = false

signal picked_up

var redbaneberry = preload("res://redbaneberry_collectable.tscn")

@export var item: InvItem
var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	if state == "no redbaneberry":
		$growth_timer.start()
		
func _process(delta):
	if state == "no redbaneberry":
		$AnimatedSprite2D.play("no_redbaneberry")
	if state == "redbaneberry":
		$AnimatedSprite2D.play("redbaneberry")
		if player_in_area:
			if Input.is_action_just_pressed("e"):
				state = "no redbaneberry"
				drop_redbaneberry()
				$AnimatedSprite2D.play("redbaneberry")

func _on_pickable_area_body_entered(body):
	if body.has_method("player"):
		player_in_area = true
		player = body


func _on_pickable_area_body_exited(body):
	if body.has_method("player"):
		player_in_area = false


func _on_growth_timer_timeout():
	if state == "no redbaneberry":
		state = "redbaneberry"
		
func drop_redbaneberry():
	
	await get_tree().create_timer(0.0).timeout
	var redbaneberry_instance = redbaneberry.instantiate()
	redbaneberry_instance.rotation = rotation
	redbaneberry_instance.global_position = $Marker2D.global_position
	get_parent().add_child(redbaneberry_instance)
	player.collect(item)
	emit_signal("picked_up")
	await get_tree().create_timer(3).timeout
	$growth_timer.start()


func _on_node_2d_baneberry_placed():
	player.deprive(item)
