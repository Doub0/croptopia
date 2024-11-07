extends Button

@onready var animplayer = $world2openingcutscene/AnimationPlayer
@onready var camera = $world2openingcutscene/Path2D/PathFollow2D/Camera2D

var is_openingcutscene = false

var has_player_entered_area = false
var player = null

var is_pathfollowing = false

func _physics_process(_delta):
	if is_openingcutscene:
		var pathfollower = $world2openingcutscene/Path2D/PathFollow2D
		
		if is_pathfollowing:
			pathfollower.progress_ratio += 0.001
			
			if pathfollower.progress_ratio >= 1:
				cutsceneending()


# Called when the node enters the scene tree for the first time.

func cutsceneopening():
	is_openingcutscene = true	
	animplayer.play("color_fade")
	player.camera.enabled = false
	camera.enabled = true
	is_pathfollowing = true
	
func cutsceneending():
	is_pathfollowing = false
	is_openingcutscene = false
	camera.enabled = false
	player.camera.enabled = true
	$world2openingcutscene.visible = false
	$world2main.visible = true
