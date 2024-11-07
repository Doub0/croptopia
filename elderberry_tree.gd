extends Node2D

var state = "no elderberry"
var player_in_area = false

var elderberry = preload("res://elderberry_collectable.tscn")

@export var item: InvItem
var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	if state == "no elderberry":
		$growth_timer.start()
		
func _process(delta):
	if state == "no elderberry":
		$AnimatedSprite2D.play("no elderberry")
	if state == "elderberry":
		$AnimatedSprite2D.play("elderberry")
		if player_in_area:
			if Input.is_action_just_pressed("e"):
				state = "elderberry"
				drop_elderberry()
				$AnimatedSprite2D.play("elderberry")

func _on_pickable_area_body_entered(body):
	if body.has_method("player"):
		player_in_area = true
		player = body


func _on_pickable_area_body_exited(body):
	if body.has_method("player"):
		player_in_area = false


func _on_growth_timer_timeout():
	if state == "no elderberry":
		state = "elderberry"
		
func drop_elderberry():
	
	await get_tree().create_timer(0.0).timeout
	var elderberry_instance = elderberry.instantiate()
	elderberry_instance.rotation = rotation
	elderberry_instance.global_position = $Marker2D.global_position
	get_parent().add_child(elderberry_instance)
	player.collect(item)
	await get_tree().create_timer(3).timeout
	$growth_timer.start()
