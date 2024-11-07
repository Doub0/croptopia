extends CharacterBody2D

const speed = 30
var current_state = IDLE

signal quest_is_finished
signal started_hunting

var dir = Vector2.RIGHT
var start_pos

var soldier_pos_e
var soldier_pos_w
var soldier_pos_n
var soldier_pos_s

var is_roaming = true
var is_chatting = false
var is_hunting = false

@onready var variant_1 = $variant_1


var player
var player_in_chat_zone = false

var direction

enum {
	IDLE,
	NEW_DIR,
	MOVE
}

func _ready():
	randomize()
	start_pos = position
func _process(delta):
	if current_state == 0 or current_state == 1 and !is_chatting:
		variant_1.play("idle")
	elif current_state == 2 and !is_hunting:
		if dir.x == -1:
			variant_1.play("walk_e")
		if dir.x == 1:
			variant_1.play("walk_w")
		if dir.y == -1:
			variant_1.play("walk_n")
		if dir.y == 1:
			variant_1.play("walk_s")

	if is_roaming:
		match current_state:
			IDLE:
				pass
			NEW_DIR:
				dir = choose([Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN])
			MOVE:
				move(delta)
#	if is_hunting == true:
#		is_roaming = false
#		hunt(delta)
	if Input.is_action_pressed("arrow_up"):
		is_hunting = true
		hunt(delta)
		
		emit_signal("started_hunting")
#		$AnimatedSprite2D.play("hunt")
#		for i in 1000:
	if is_hunting:
		var north = Vector2(0,player.position.y)
		var south = Vector2(0,player.position.y)
		var west = Vector2(player.position.x,0)
		var east = Vector2(player.position.x,0)
		
		var is_searching
		
		var up
		var down
		var left
		var right

		if direction == "down":
			is_searching = false
			return_pos()
			position = position.move_toward(soldier_pos_s,1)
			variant_1.play("walk_s")
			print("Direction is down")
			if position == soldier_pos_s:
				print("go south")
				hunt(delta)
	#			if (player.position.y - dir.y) == 0:
	#				is_roaming = false
	#				position = position.move_toward(west,1)
	#				print("move south1")
	#				if position == west:
	#					hunt(delta)
	#			if (player.position.y - position.y) == 0:
	#				is_roaming = false
	#				position = position.move_toward(east,1)
	#				print("move south2")
	#				if position == east:
	#					hunt(delta)
	#			if (player.position.x - dir.x) == 0:
	#				is_roaming = false
	#				position = position.move_toward(north,1)
	#				print("move south3")
	#				if position == north:
	#					hunt(delta)
	#
	#			if (player.position.x - position.x) == 0:
	#				is_roaming = false
	#				position = position.move_toward(south,1)
	#				print("move south4")
	#				if position == south:
	#					hunt(delta)

		if direction == "up":
			is_searching = false
			return_pos()
			position = position.move_toward(soldier_pos_n,1)
			variant_1.play("walk_n")
			print("Direction is up")
			if position == soldier_pos_n:
				print("go west")
				hunt(delta)
	##			if (player.position.y - dir.y) == 0:
	#			is_roaming = false
	#			position = position.move_toward(west,1)
	#			print("move west")
	#			if position == west:
	#				hunt(delta)
	#
	#			if (player.position.y - position.y) == 0:
	#				is_roaming = false
	#				position = position.move_toward(east,1)
	##				return_pos()
	#				print("move up then east :")
	#				if (player.position.x - position.x) == 0:
	#					print("hit east")
	#					hunt(delta)
	#
	#			if (player.position.x - dir.x) == 0:
	#				is_roaming = false
	#				position = position.move_toward(north,1)
	#				print("move west")
	#				if player.position.y == position.y:
	#					hunt(delta)
	#
	#
	#			if (player.position.x - position.x) == 0:
	#				is_roaming = false
	#				position = position.move_toward(south,1)
	#				print("move up then east")
	#				if position == south:
	#					hunt(delta)

		if direction == "right":
			is_searching = false
			return_pos()
			position = position.move_toward(soldier_pos_e,1)
			variant_1.play("walk_e")
			print("Direction is right")
			if position == soldier_pos_e:
				print("go east")
				hunt(delta)
	#			if (player.position.x - dir.x) == 0:
	#				is_roaming = false
	#				position = position.move_toward(north,1)
	#				print("move east#")
	#				if position == north:
	#					hunt(delta)
	#
	#			if (player.position.x - position.x) == 0:
	#				is_roaming = false
	#				position = position.move_toward(north,1)
	#				print("move east!")
	#				if position == north:
	#					hunt(delta)
	#
	#			if (player.position.y - dir.y) == 0:
	#				is_roaming = false
	#				position = position.move_toward(east,1)
	#				print("move east(")
	#				if position == east:
	#					hunt(delta)

	#			if (player.position.y - position.y) == 0:
	#				is_roaming = false
	#				position = position.move_toward(west,1)
	#				print("move east$")
	#				if position == west:
	#					hunt(delta)

		if direction == "left":
			is_searching = false
			return_pos()
			position = position.move_toward(soldier_pos_w,1)
			variant_1.play("walk_w")
			print("Direction is left")
			if position == soldier_pos_w:
				print("go west")
				hunt(delta)
				
	#			if (player.position.x - dir.x) == 0:
	#				is_roaming = false
	#				position = position.move_toward(north,1)
	#				print("move north")
	#				if position == north:
	#					hunt(delta)
	#
	#			if (player.position.x - position.x) == 0:
	#				is_roaming = false
	#				position = position.move_toward(south,1)
	#				print("move south&")
	#				if position == south:
	#					hunt(delta)
	#
	#			if (player.position.y - dir.y) == 0:
	#				is_roaming = false
	#				position = position.move_toward(east,1)
	#				print("move east[")
	#				if position == east:
#					hunt(delta)
#
#			if (player.position.y - position.y) == 0:
#				is_roaming = false
#				position = position.move_toward(west,1)
#				print("move east{")
#				if position == west:
#					hunt(delta)
				
				
		if Input.is_action_just_pressed("arrow_down"):
			print("force hunt")
			hunt(delta)

func choose(array):
	array.shuffle()
	return array.front()

func move(delta):
#	if !is_chatting:
		velocity = dir * speed
		move_and_slide()



func _on_chat_detection_area_body_entered(body):
	if body.has_method("player"):
		player = body
		is_roaming = false
		is_hunting = true
#		if is_hunting:
##			for i in 100000:
#				print("weeeee")
#				position += (player.position - position) / speed
#				position += (player.position - position) / speed
#			position = player.position - position / speed
#			position = player.position - position / speed
#			position = player.position - position / speed
#			position = player.position - position / speed
		
		print("Player in Area")

func hunt(delta):	
	if (player.position.y - position.y) > 0:
		direction = "down"
		print("Direction chosen as down")

	if (player.position.x - position.x) > 0:
		direction = "right"
		print("Direction chosen as right")
	
	if (player.position.x - position.x) < 0:
		direction = "left"
		print("Direction chosen as left")
		
	if (player.position.y - position.y) < 0:
		direction = "up"
		print("Direction chosen as up")
				
func _on_timer_timeout():
	$Timer.wait_time = choose([0.5, 1, 1.5])
	current_state = choose([IDLE, NEW_DIR, MOVE])

func test_hunt():
	pass


func _on_chat_detection_area_body_exited(body):
	pass # Replace with function body.

func return_pos():
	var east = Vector2(player.position.x,0)
	var north = Vector2(0,player.position.y)
	var south = Vector2(0,player.position.y)
	var west = Vector2(player.position.x,0)
	
	var soldier_y = Vector2(0,position.y)
	var soldier_x = Vector2(position.x,0)
	soldier_pos_e = east + soldier_y
	soldier_pos_w = west + soldier_y
	
	soldier_pos_n = soldier_x + north 
	soldier_pos_s = soldier_x + south
	
	return soldier_pos_e
	return soldier_pos_w
