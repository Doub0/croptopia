extends Node2D

var state = "no sorrel"
var player_in_area = false

var sorrel = preload("res://sorrel_collectable.tscn")

@export var item: InvItem
var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	if state == "no sorrel":
		$growth_timer.start()
		
func _process(delta):
	if state == "no sorrel":
		$AnimatedSprite2D.play("no_sorrel")
	if state == "sorrel":
		$AnimatedSprite2D.play("sorrel")
		if player_in_area:
			if Input.is_action_just_pressed("e"):
				state = "no sorrel"
				drop_sorrel()
				$AnimatedSprite2D.play("sorrel")

func _on_pickable_area_body_entered(body):
	if body.has_method("player"):
		player_in_area = true
		player = body


func _on_pickable_area_body_exited(body):
	if body.has_method("player"):
		player_in_area = false


func _on_growth_timer_timeout():
	if state == "no sorrel":
		state = "sorrel"
		
func drop_sorrel():
	
	await get_tree().create_timer(0.0).timeout
	var sorrel_instance = sorrel.instantiate()
	sorrel_instance.rotation = rotation
	sorrel_instance.global_position = $Marker2D.global_position
	get_parent().add_child(sorrel_instance)
	player.collect(item)
	await get_tree().create_timer(3).timeout
	$growth_timer.start()

