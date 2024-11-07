extends CharacterBody2D

@export var speed = 200
@onready var player = get_parent().get_node("player")

var death = false
var dir = Vector2.DOWN

signal player_death
func _ready():
	$AnimatedSprite2D.play("walk_s")
func _process(delta):
	if death == true:
		emit_signal("player_death")
#	if dir.x == -1:
##		dir = "right"
#		$AnimatedSprite2D.play("walk_e")
#	if dir.x == 1:
##		dir = "left"
#		$AnimatedSprite2D.play("walk_w")
#	if dir.y == -1:
##		dir = "north"
#		$AnimatedSprite2D.play("walk_n")
#	if dir.y == 1:
##		dir = "south"
#		$AnimatedSprite2D.play("walk_s")
		

func _physics_process(delta):		
	
	position += (player.position - position) / speed
	
#	if(player.position.y - position.y) < 0:
#		$AnimatedSprite2D.play("walk_s")
	
	if (player.position.y - position.y) > 0:
			$AnimatedSprite2D.play("walk_s")
	
	elif (player.position.x - position.x) < 0:
		$AnimatedSprite2D.play("walk_w")
	elif (player.position.x - position.x) > 0:
		$AnimatedSprite2D.play("walk_e")
	
	
	var north = Vector2(0,-20)
	var south = Vector2(0,-20)
	var west = Vector2(0,-20)
	var east = Vector2(0,-20)
	
		
	
#	if position.distance_to(player_position) > 3:
#		move_and_collide(target_position * speed)
#		look_at(target_position)


func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		death = true
