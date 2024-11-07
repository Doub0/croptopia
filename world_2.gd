extends Node2D #The script extends the scene's main node

@onready var animplayer = $world2openingcutscene/AnimationPlayer #Prepares the Animation Player node which contains the Opening Cutscene
@onready var camera = $world2openingcutscene/Path2D/PathFollow2D/Camera2D #Prepares Cutscene Camera

var is_openingcutscene = false #Asks if the opening cutscene is active

var has_player_entered_area = false #Asks if the player has entered the Area
var player = null #Put's the players value to null (0)

var is_pathfollowing = false #The camera is not following a path?
var is_pathfollowing2 = false

func _physics_process(_delta):
	if is_openingcutscene:
		var pathfollower = $world2openingcutscene/Path2D/PathFollow2D
		var pathfollower2 = $world2openingcutscene/Path2D2/PathFollow2D
		
		if is_pathfollowing:
			pathfollower.progress_ratio += 0.007
			
			
			if pathfollower.progress_ratio >= 1:
				cutsceneending()
				
		if is_pathfollowing2:
			pathfollower2.progress_ratio += 0.005
			$world2openingcutscene/Path2D2/PathFollow2D/AnimatedSprite2D.play("default")
			
			if pathfollower2.progress_ratio >= 1:
				cutsceneending()

func _on_player_detection_body_entered(body): #Tells the Script what to do if a player has entered a ChildNode(Ex. a button, label, an image) but specifically an Area2D node which registers players in a set area
	if body.has_method("player"): #If the body that enters is a player
		player = body #Player is the same as Body
		if !has_player_entered_area: #If the player has not entered the area do this:
			has_player_entered_area = true #Has the player entered the area
			cutsceneopening() #Starts the function below
			
func cutsceneopening(): #Instructions of what the Cutscene Opening will contain
	is_openingcutscene = true #Is the Opening Cutscene active
	animplayer.play("color_fade") #Plays an animation, and this one is a simple color fading overlay
	player.camera.enabled = false #Disables the Player's integrated camera
	camera.enabled = true #Enables the cutscene camera
	is_pathfollowing = true #Makes it so that the camera follows a set path
	is_pathfollowing2 = true
	$world2openingcutscene/Path2D2/PathFollow2D/AnimatedSprite2D.play("default")
	
func cutsceneending(): #Instructions of what the Cutscene Ending will contain
	is_pathfollowing = false #Stops the camera's set path following
	is_openingcutscene = false #Has the opening cutscene not happened
	camera.enabled = false #Stops the cutscene camera
	player.camera.enabled = true #Switches to the Player's integrated camera
	$world2openingcutscene.visible = false #The cutscene is not visible
	$world2main.visible = true #Normal player scene
	$world2openingcutscene/Path2D2/PathFollow2D/AnimatedSprite2D.visible = false
