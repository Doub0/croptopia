extends Node2D

@onready var player = $player
@onready var anim2 = $Path2D/PathFollow2D/AnimatedSprite2D2
@onready var anim = $Path2D/PathFollow2D/AnimatedSprite2D
@onready var pathfollower = $Path2D/PathFollow2D
@onready var path = $Path2D
var is_pathfollowing = false
var death = false
#$Path2D/PathFollow2D/
# Called when the node enters the scene tree for the first time.
func _ready():
	var pathfollower = $Path2D/PathFollow2D
	anim.visible = false
	anim2.visible = false
	player.visible = true
	


func _on_area_2d_body_entered(body):
	is_pathfollowing = true
		
	

func _physics_process(_delta):
	if is_pathfollowing:
		player.visible = false
		anim.visible = true
		anim2.visible = false
		anim.play("falling")
		var has_happened = false
		var pathfollower = $Path2D/PathFollow2D
		pathfollower.progress_ratio += 0.007
		if pathfollower.progress_ratio >= 1:
			pass
#			if death:
#				#anim.position = player.position
##				player.visible = false
#				anim2.visible = true
#				#anim.position = anim2.position
#				anim2.play("falldamage")
#func _on_animated_sprite_2d_2_animation_finished():
#	#death = false
#	anim.visible = true
#	anim2.visible = false
#	player.visible = false
#	anim.play("falldamage")
##	player.position = path.position
##	var newvar = path.position
##	var player_pos = player.position
##	var equat = newvar - player_pos
##

func _process(delta):
	var pos = $Marker2D.position
	var minus = Vector2(0,-20)
	var equat = player.position - minus
	$Marker2D.position = equat
func _on_animated_sprite_2d_animation_finished():
	is_pathfollowing = false
	anim2.visible = true
	anim.visible = false
#	anim2.position = anim.position
	anim2.play("falldamage")
	


func _on_animated_sprite_2d_2_animation_finished():
	player.position = $Marker2D.position
	anim2.visible = false
	#path.position = player.position
	player.visible = true
