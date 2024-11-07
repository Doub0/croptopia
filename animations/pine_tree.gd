extends Node2D

var state = "no pinecones"
var player_in_area = false
#var pinecone = preload("res://animations/pinecone.tscn")

func _ready():
	if state == "no pinecones":
		$fruiting_timer.start()
		
func _process(delta):
	if state == "no pinecones":
		$AnimatedSprite2D.play("pines")
	if state == "pinecones":
		$AnimatedSprite2D.play("pines")
		if player_in_area:
			if Input.is_action_just_pressed("e"):
				state = "no pinecones"
				$fruiting_timer.start()
				
func _on_pickable_area_body_entered(body):
	if body.has_method("player"):
		player_in_area = true

func _on_pickable_area_body_exited(body):
	if body.has_method("player"):
		player_in_area = false
		
func on_growth_timer_timeout():
	if state == "no pinecones":
		state == "pinecones"
		
func drop_pinecone():
	var pinecone_instance = pinecone.instantiate()
	pinecone_instance.global_position = $Marker2D.global_position
	get_parent().add_child(pinecone_instance)
	
	await get_tree().create_timer(3).timeout
	$growth_timer.start()
