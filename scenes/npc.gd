extends CharacterBody2D

const speed = 30
var current_state = IDLE

signal quest_is_finished

var dir = Vector2.RIGHT
var start_pos

var is_roaming = true
var is_chatting = false

var player
var player_in_chat_zone = false

enum {
	IDLE,
	NEW_DIR,
	MOVE
}

func _ready():
	randomize()
	start_pos = position
func _process(delta):
	if current_state == 0 or current_state == 1:
		$AnimatedSprite2D.play("idle")
	elif current_state == 2 and !is_chatting:
		if dir.x == -1:
			$AnimatedSprite2D.play("walk_e")
		if dir.x == 1:
			$AnimatedSprite2D.play("walk_w")
		if dir.y == -1:
			$AnimatedSprite2D.play("walk_n")
		if dir.y == 1:
			$AnimatedSprite2D.play("walk_s")

	if is_roaming:
		match current_state:
			IDLE:
				pass
			NEW_DIR:
				dir = choose([Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN])
			MOVE:
				move(delta)
	if Input.is_action_just_pressed("chat"):
		print("chatting with npc")
		$Dialogue.start()
		is_roaming = false
		is_chatting = true
		$AnimatedSprite2D.play("idle")
	if Input.is_action_just_pressed("quest"):
		print("quest has started")
		$npc_quest.next_quest()
		is_roaming = false
		is_chatting = true
		$AnimatedSprite2D.play("idle")
func choose(array):
	array.shuffle()
	return array.front()

func move(delta):
	if !is_chatting:
		velocity = dir * speed
		move_and_slide()



func _on_chat_detection_area_body_entered(body):
	if body.has_method("player"):
		player = body
		player_in_chat_zone = true
		print("Player in Area")


func _on_chat_detection_area_body_exited(body):
	if body.has_method("player"):
		player_in_chat_zone = false

func _on_timer_timeout():
	$Timer.wait_time = choose([0.5, 1, 1.5])
	current_state = choose([IDLE, NEW_DIR, MOVE])


func _on_dialogue_dialogue_finished():
	is_chatting = false
	is_roaming = true

func _on_npc_quest_quest_menu_closed():
	is_chatting = false
	is_roaming = true

func _on_player_stick_collected():
	$npc_quest.stick_collected()
#

#
func _on_player_elderberry_collected():
	$npc_quest.elderberry_collected()


func _on_player_pinecone_collected():
	$npc_quest.pinecone_collected()


func _on_player_redbane_collected():
	$npc_quest.redbane_collected()


func _on_player_sorrel_collected():
	$npc_quest.sorrel_collected()
#
func _on_player_chive_collected():
	$npc_quest.chive_collected()


func _on_npc_quest_quest_finished():
	emit_signal("quest_is_finished")
	position = Vector2(0,0)
