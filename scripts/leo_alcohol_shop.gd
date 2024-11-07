extends Node2D

@onready var ui = $CanvasLayer/shop_ui

var ui_open = false
var player_in_shop_area = false
# Called when the node enters the scene tree for the first time.
func _ready():
	ui.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	if player_in_shop_area:

	if Input.is_action_just_pressed("arrow_right") and player_in_shop_area:
		if !ui_open:
			shop_open()
			print("shop open!")
				
		else:
			shop_close()
			print("shop close!")

func shop_open():
	ui_open = true
	ui.visible = true
	
func shop_close():
	ui_open = false
	ui.visible = false


func _on_shop_open_body_entered(body):
	player_in_shop_area = true


func _on_shop_open_body_exited(body):
	player_in_shop_area = false
