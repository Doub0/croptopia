extends Node2D

var state = "no birch"
var player_in_area = false

var birch = preload("res://birch_collectable.tscn")

@export var item: InvItem
var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	if state == "no birch":
		$growth_timer.start()
		
func _process(delta):
	if state == "no birch":
		$AnimatedSprite2D.play("no_birch")
	if state == "birch":
		$AnimatedSprite2D.play("birch")
		if player_in_area:
			if Input.is_action_just_pressed("e"):
				state = "no birch"
				drop_birch()
				$AnimatedSprite2D.play("birch")

func _on_pickable_area_body_entered(body):
	if body.has_method("player"):
		player_in_area = true
		player = body


func _on_pickable_area_body_exited(body):
	if body.has_method("player"):
		player_in_area = false


func _on_growth_timer_timeout():
	if state == "no birch":
		state = "birch"
		
func drop_birch():
	
	await get_tree().create_timer(0.0).timeout
	var birch_instance = birch.instantiate()
	birch_instance.rotation = rotation
	birch_instance.global_position = $Marker2D.global_position
	get_parent().add_child(birch_instance)
	player.collect(item)
	await get_tree().create_timer(3).timeout
	$growth_timer.start()

