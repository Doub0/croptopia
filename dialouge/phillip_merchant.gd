extends Node2D

signal redbane_purchase
signal chive_purchase
signal pinecone_purchase

@onready var redbane_sell_button = $CanvasLayer/shop_ui/GridContainer/redbane_purchase_button
@onready var chive_sell_button = $CanvasLayer/shop_ui/GridContainer/chive_purchase_button
@onready var pinecone_sell_button = $CanvasLayer/shop_ui/GridContainer/pinecone_purchase_button

@onready var ui = $CanvasLayer/shop_ui
# Called when the node enters the scene tree for the first time.
func _ready():
	ui.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("shop"):
		ui.visible = true
	if Input.is_action_just_pressed("escape"):
		ui.visible = false


func _on_redbane_purchase_button_pressed():
	emit_signal("redbane_purchase")


func _on_chive_purchase_button_pressed():
	emit_signal("chive_purchase")


func _on_pinecone_purchase_button_pressed():
	emit_signal("pinecone_purchase")
