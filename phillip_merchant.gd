extends Node2D

signal redbane_purchase
signal chive_purchase
signal pinecone_purchase
signal axe_purchase

@onready var redbane_sell_button = $CanvasLayer/shop_ui/GridContainer/redbane_purchase_button
@onready var chive_sell_button = $CanvasLayer/shop_ui/GridContainer/chive_purchase_button
@onready var pinecone_sell_button = $CanvasLayer/shop_ui/GridContainer/pinecone_purchase_button

@onready var ui = $CanvasLayer/shop_ui

@onready var music = $CanvasLayer/shop_ui/music

@onready var music_stop = $CanvasLayer/shop_ui/music.playing
@onready var music_time = $CanvasLayer/shop_ui/music.get_stream_playback()
#VERY ADCANCED SHOP CODE DONT BE FOOLED!

@onready var redbaneberry_icon = preload("res://pixil-frame-0 - 2024-01-16T123135.698.png")
@onready var chive_icon = preload("res://pixil-frame-0 - 2024-01-16T124429.661.png")
@onready var sorrel_icon = preload("res://pixil-frame-0 - 2024-01-16T170843.375.png")
@onready var pinecone_icon = preload("res://pixil-frame-0 - 2024-01-22T145636.059.png")
@onready var elderberry_icon = preload("res://assets/pixil-frame-0 - 2024-01-16T112753.850.png")
@onready var axe_icon = preload("res://assets/iron_axe.png")

@onready var info_text = $CanvasLayer/shop_ui/info_frame/info_text
@onready var info_icon = $CanvasLayer/shop_ui/item_icon/info_icon
@onready var purchase_button = $CanvasLayer/shop_ui/usd_coin
@onready var price_text = $CanvasLayer/shop_ui/item_amount

@onready var demand_ui_position = $CanvasLayer/shop_ui/demand_frame/demand_ui_position
@onready var demand_ui_out_position = $CanvasLayer/shop_ui/demand_frame/demand_ui_out_position

var page_1
var page_2
var page_3
var page_4
var page_5
var selected_baneberry
var selected_chives
var selected_sorrel
var selected_elderberry
var selected_pinecone
var selected_axe

signal baneberry_selected
signal chive_selected
signal sorrel_selected
signal elderberry_selected
signal pinecone_selected

var page_num = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	ui.visible = false
	$CanvasLayer/shop_ui/product_frame/GridContainer/shop_slot1/shop_slot_sprite.texture = redbaneberry_icon
	$CanvasLayer/shop_ui/product_frame/GridContainer/shop_slot2/shop_slot_sprite.texture = chive_icon
	$CanvasLayer/shop_ui/product_frame/GridContainer/shop_slot3/shop_slot_sprite.texture = elderberry_icon
	$CanvasLayer/shop_ui/product_frame/GridContainer/shop_slot4/shop_slot_sprite.texture = pinecone_icon
	$CanvasLayer/shop_ui/product_frame/GridContainer/shop_slot5/shop_slot_sprite.texture = sorrel_icon 
	$CanvasLayer/shop_ui/product_frame/GridContainer/shop_slot6/shop_slot_sprite.texture = axe_icon 
	$CanvasLayer/shop_ui/product_frame/GridContainer/shop_slot7/shop_slot_sprite.texture = chive_icon 
	$CanvasLayer/shop_ui/product_frame/GridContainer/shop_slot8/shop_slot_sprite.texture = chive_icon 
	$CanvasLayer/shop_ui/product_frame/GridContainer/shop_slot9/shop_slot_sprite.texture = chive_icon 
	$CanvasLayer/shop_ui/product_frame/GridContainer/shop_slot10/shop_slot_sprite.texture = chive_icon 
	$CanvasLayer/shop_ui/product_frame/GridContainer/shop_slot11/shop_slot_sprite.texture = chive_icon 
	$CanvasLayer/shop_ui/product_frame/GridContainer/shop_slot12/shop_slot_sprite.texture = chive_icon 
	$CanvasLayer/shop_ui/product_frame/GridContainer/shop_slot13/shop_slot_sprite.texture = chive_icon 
	$CanvasLayer/shop_ui/product_frame/GridContainer/shop_slot14/shop_slot_sprite.texture = chive_icon 
	$CanvasLayer/shop_ui/product_frame/GridContainer/shop_slot15/shop_slot_sprite.texture = chive_icon 
	$CanvasLayer/shop_ui/product_frame/GridContainer/shop_slot16/shop_slot_sprite.texture = chive_icon 
	$CanvasLayer/shop_ui/product_frame/GridContainer/shop_slot17/shop_slot_sprite.texture = chive_icon 
	$CanvasLayer/shop_ui/product_frame/GridContainer/shop_slot18/shop_slot_sprite.texture = chive_icon 
	$CanvasLayer/shop_ui/product_frame/GridContainer/shop_slot19/shop_slot_sprite.texture = chive_icon 
	$CanvasLayer/shop_ui/product_frame/GridContainer/shop_slot20/shop_slot_sprite.texture = chive_icon 
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var music_timestamp
	if Input.is_action_just_pressed("shop"):
		ui.visible = true
		music.play()
	if Input.is_action_just_pressed("escape"):
		ui.visible = false
		music.playing = false
		
		
		
	if selected_baneberry:
		info_icon.texture = redbaneberry_icon
		info_text.text = str("Name: Red Baneberry 
							Use: Food or crafting 
							Rarity: Common")
		price_text.text = str("/ 8 Redbaneberry")
		emit_signal("baneberry_selected")
	if selected_chives:
		info_icon.texture = chive_icon
		info_text.text = str("Name: Chives
							Use: Food or crafting 
							Rarity: Common")
		price_text.text = str("/ 8 Chives")
	if selected_elderberry:
		info_icon.texture = elderberry_icon
		info_text.text = str("Name: Elderberries
							Use: Food or crafting 
							Rarity: Uncommon")
		price_text.text = str("/ 4 Elderberry")
	if selected_sorrel:
		info_icon.texture = sorrel_icon
		info_text.text = str("Name: Sorrel
							Use: Food or crafting 
							Rarity: Uncommon")
		price_text.text = str("/ 6 Sorrel")
	if selected_pinecone:
		info_icon.texture = pinecone_icon
		info_text.text = str("Name: Pinecone
							Use: Food or crafting 
							Rarity: Common")
		price_text.text = str("/ 12 Pinecone")
	if selected_axe:
		info_icon.texture = axe_icon
		info_text.text = str("Name: Iron Axe
							Use: Tool
							Rarity: Epic")
		price_text.text = str("/ 12 Pinecone")


func _on_redbane_purchase_button_pressed():
	emit_signal("redbane_purchase")


func _on_chive_purchase_button_pressed():
	emit_signal("chive_purchase")


func _on_pinecone_purchase_button_pressed():
	emit_signal("pinecone_purchase")



func _on_shop_slot_1_button_pressed():
	selected_baneberry = true
	selected_chives = false
	selected_elderberry = false
	selected_pinecone = false
	selected_sorrel = false
	selected_axe = false

func _on_shop_slot_2_button_2_pressed():
	selected_baneberry = false
	selected_chives = true
	selected_elderberry = false
	selected_pinecone = false
	selected_sorrel = false
	selected_axe = false

func _on_shop_slot_3_button_pressed():
	selected_baneberry = false
	selected_chives = false
	selected_elderberry = true
	selected_pinecone = false
	selected_sorrel = false
	selected_axe = false

func _on_shop_slot_4_button_pressed():
	selected_baneberry = false
	selected_chives = false
	selected_elderberry = false
	selected_pinecone = true
	selected_sorrel = false
	selected_axe = false

func _on_shop_slot_5_button_pressed():
	selected_baneberry = false
	selected_chives = false
	selected_elderberry = false
	selected_pinecone = false
	selected_sorrel = true
	selected_axe = false


func _on_usd_coin_pressed():
	if selected_baneberry == true:
		emit_signal("redbane_purchase")
		print("Redbane Purchase")
	elif selected_chives == true:
		emit_signal("chive_purchase")
	elif selected_axe:
		emit_signal("axe_purchase")


func _on_demand_info_button_pressed():
	$CanvasLayer/shop_ui/demand_frame/ui_page_1.position = demand_ui_position.position


func _on_next_ui_page_pressed():
	page_num = page_num + 1
	if page_num == 1:
		$CanvasLayer/shop_ui/demand_frame/ui_page_1.position = demand_ui_out_position.position
		$CanvasLayer/shop_ui/demand_frame/ui_page_2.position = demand_ui_position.position
	if page_num == 2:
		$CanvasLayer/shop_ui/demand_frame/ui_page_2.position = demand_ui_out_position.position
		$CanvasLayer/shop_ui/demand_frame/ui_page_3.position = demand_ui_position.position
	if page_num == 3:
		$CanvasLayer/shop_ui/demand_frame/ui_page_3.position = demand_ui_out_position.position
		$CanvasLayer/shop_ui/demand_frame/ui_page_4.position = demand_ui_position.position
	if page_num == 4:
		$CanvasLayer/shop_ui/demand_frame/ui_page_4.position = demand_ui_out_position.position
		$CanvasLayer/shop_ui/demand_frame/ui_page_5.position = demand_ui_position.position
	if page_num == 5:
		$CanvasLayer/shop_ui/demand_frame/ui_page_5.position = demand_ui_out_position.position
		$CanvasLayer/shop_ui/demand_frame/ui_page_6.position = demand_ui_position.position
	if page_num == 6:
		$CanvasLayer/shop_ui/demand_frame/ui_page_6.position = demand_ui_out_position.position
		$CanvasLayer/shop_ui/demand_frame/ui_page_7.position = demand_ui_position.position
	if page_num == 7:
		$CanvasLayer/shop_ui/demand_frame/ui_page_7.position = demand_ui_out_position.position
		$CanvasLayer/shop_ui/demand_frame/ui_page_8.position = demand_ui_position.position
	if page_num == 8:
		$CanvasLayer/shop_ui/demand_frame/ui_page_8.position = demand_ui_out_position.position
		page_num = 0


func _on_shop_slot_6_button_pressed():
	selected_baneberry = false
	selected_chives = false
	selected_elderberry = false
	selected_pinecone = false
	selected_sorrel = false
	selected_axe = true
