extends Node2D


var state = "no maple"
var player_in_area = false

var maple = preload("res://maple_collectable.tscn")

@export var item: InvItem
var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	if state == "no maple":
		$growth_timer.start()
		
func _process(delta):
	if state == "no maple":
		$AnimatedSprite2D.play("no_maple")
	if state == "maple":
		$AnimatedSprite2D.play("maple")
		if player_in_area:
			if Input.is_action_just_pressed("e"):
				state = "no maple"
				drop_maple()
				$AnimatedSprite2D.play("maple")

func _on_pickable_area_body_entered(body):
	if body.has_method("player"):
		player_in_area = true
		player = body


func _on_pickable_area_body_exited(body):
	if body.has_method("player"):
		player_in_area = false


func _on_growth_timer_timeout():
	if state == "no maple":
		state = "maple"
		
func drop_maple():
	
	await get_tree().create_timer(0.0).timeout
	var maple_instance = maple.instantiate()
	maple_instance.rotation = rotation
	maple_instance.global_position = $Marker2D.global_position
	get_parent().add_child(maple_instance)
	player.collect(item)
	await get_tree().create_timer(3).timeout
	$growth_timer.start()
