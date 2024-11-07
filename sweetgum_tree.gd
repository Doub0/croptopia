extends Node2D


var state = "no sweetgum"
var player_in_area = false

var sweetgum = preload("res://sweetgum_collectable.tscn")

@export var item: InvItem
var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	if state == "no sweetgum":
		$growth_timer.start()
		
func _process(delta):
	if state == "no sweetgum":
		$AnimatedSprite2D.play("no sweetgum")
	if state == "sweetgum":
		$AnimatedSprite2D.play("sweetgum")
		if player_in_area:
			if Input.is_action_just_pressed("e"):
				state = "no sweetgums"
				drop_sweetgum()
				$AnimatedSprite2D.play("sweetgum")

func _on_pickable_area_body_entered(body):
	if body.has_method("player"):
		player_in_area = true
		player = body


func _on_pickable_area_body_exited(body):
	if body.has_method("player"):
		player_in_area = false


func _on_growth_timer_timeout():
	if state == "no sweetgum":
		state = "sweetgum"
		
func drop_sweetgum():
	
	await get_tree().create_timer(0.0).timeout
	var sweetgum_instance = sweetgum.instantiate()
	sweetgum_instance.rotation = rotation
	sweetgum_instance.global_position = $Marker2D.global_position
	get_parent().add_child(sweetgum_instance)
	player.collect(item)
	await get_tree().create_timer(3).timeout
	$growth_timer.start()

