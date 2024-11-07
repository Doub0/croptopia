extends Node2D

var state = "no whitepinecone"
var player_in_area = false

var whitepinecone = preload("res://inventory/whitepine_collectable.tscn")

@export var item: InvItem
var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	if state == "no whitepinecone":
		$growth_timer.start()
		
func _process(delta):
	if state == "no whitepinecone":
		$AnimatedSprite2D.play("no_pinecone")
	if state == "whitepinecone":
		$AnimatedSprite2D.play("pinecone")
		if player_in_area:
			if Input.is_action_just_pressed("e"):
				state = "no whitepinecone"
				drop_whitepinecone()
				$AnimatedSprite2D.play("pinecone")

func _on_pickable_area_body_entered(body):
	if body.has_method("player"):
		player_in_area = true
		player = body


func _on_pickable_area_body_exited(body):
	if body.has_method("player"):
		player_in_area = false


func _on_growth_timer_timeout():
	if state == "no whitepinecone":
		state = "whitepinecone"
		
func drop_whitepinecone():
	
	await get_tree().create_timer(0.0).timeout
	var whitepinecone_instance = whitepinecone.instantiate()
	whitepinecone_instance.rotation = rotation
	whitepinecone_instance.global_position = $Marker2D.global_position
	get_parent().add_child(whitepinecone_instance)
	player.collect(item)
	await get_tree().create_timer(3).timeout
	$growth_timer.start()
