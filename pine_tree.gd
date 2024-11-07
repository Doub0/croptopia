extends Node2D

var state = "no pinecones"
var player_in_area = false

var pinecone = preload("res://pinecone_collectable.tscn")

var health = 18
@onready var pine_health_bar = $pine_health_bar/ColorRect

@export var item: InvItem
var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pine_health_bar.visible = false
	if state == "no pinecones":
		$growth_timer.start()
		
func _process(delta):
	if state == "no pinecones":
		$AnimatedSprite2D.play("no pinecones")
	if state == "pinecones":
		$AnimatedSprite2D.play("pinecones")
		if player_in_area:
			if Input.is_action_just_pressed("e"):
				state = "no pinecones"
				drop_pinecone()
				$AnimatedSprite2D.play("pinecones")
	if state == "stub":
		$AnimatedSprite2D.play("stub")
		
		
	if health == 0:
		item = preload("res://inventory/items/spruce_log.tres")
		player.collect(item)
		state = "stub"
		pine_health_bar.set_size(Vector2(0,3), true)
	if health == 6:
		pine_health_bar.set_size(Vector2(10,3), true)
	if health == 12:
		pine_health_bar.set_size(Vector2(20,3), true)
	if health == 18:
		pine_health_bar.set_size(Vector2(30,3), true)

func _on_pickable_area_body_entered(body):
	if body.has_method("player"):
		player_in_area = true
		player = body


func _on_pickable_area_body_exited(body):
	if body.has_method("player"):
		player_in_area = false


func _on_growth_timer_timeout():
	if state == "no pinecones":
		state = "pinecones"
		
func drop_pinecone():
	item = preload("res://inventory/pinecone.tres")
	await get_tree().create_timer(0.0).timeout
	var pinecone_instance = pinecone.instantiate()
	pinecone_instance.rotation = rotation
	pinecone_instance.global_position = $Marker2D.global_position
	get_parent().add_child(pinecone_instance)
	player.collect(item)
	await get_tree().create_timer(3).timeout
	$growth_timer.start()


func _on_player_tool_hit():
	if player_in_area:
		pine_health_bar.visible = true
		health = health - 1
		print("Pine tree chopped")
