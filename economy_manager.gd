extends Node

var economic_state

var price = 1
@onready var price_display = $price
var inflation_value: float
var inflation_value_round
@onready var economic_span: Array
@onready var demand_display = $demand_status_icon
@onready var demand_status = $demand_status_message

@onready var low_demand = preload("res://assets/bad_economy.png")
@onready var neutral = preload("res://assets/decent_economy.png")
@onready var high_demand = preload("res://assets/good_economy.png")

var low_mode = false
var high_mode = false
var neutral_mode = true

var demand_texture

var economy_on = false
var count = 0
var inflation
# Called when the node enters the scene tree for the first time.
func _ready():
	price_display.text = str(price)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	price_display.text = str(price)
	if economy_on:
		if inflation > 0.75:
			economic_state = "high demand"
			print("The demand is High")
#		if inflation > 0.75:
#			economic_state = "high demand"
#			print("The demand is Low")	
#		if inflation > 1:
#			economic_state = "high demand"
#			print("The demand is High")
#		if inflation < 1:
#			economic_state = "high demand"
#			print("The demand is High")
		if inflation < 0.55:
			economic_state = "neutral"
			print("The demand is Low")
		if inflation < 0.25:
			economic_state = "low demand"
			print("The demand is Low")
#		else:
#			economic_state = "neutral"
#			print("The demand is Neutral")
			
		if economic_state == "neutral":
			demand_display.texture = neutral
			demand_status.text = str("NORMAL")
		if economic_state == "high demand":
			demand_display.texture = high_demand
			demand_status.text = str("HIGH")
		if economic_state == "low demand":
			demand_display.texture = low_demand
			demand_status.text = str("LOW")
		
		
	if Input.is_action_just_pressed("n"):
		inflation_value = randf_range(-0.1,1.3)
		if inflation_value_round is int:
			print("Integer chosen")
		inflation_value_round = float(str( inflation_value ).pad_decimals(2))
		inflation = choose([inflation_value_round,inflation_value_round,inflation_value_round])
		
		
		randomize()
		price_fluxuation()
		economy_on = true
		
func choose(inflation):
	inflation.shuffle()
	return inflation.front()

func price_fluxuation():
	price = price * inflation
	price_display.text = str(price)


func _on_phillip_merchant_elderberry_selected():
	price = 1

func _on_phillip_merchant_pinecone_selected():
	price = 1

func _on_phillip_merchant_sorrel_selected():
	price = 1


func _on_phillip_merchant_chive_selected():
	price = 1


func _on_phillip_merchant_baneberry_selected():
	print("SELECTED BANE")
	count = count + 1
	if count == 0:
		price = 0
	if count > 1:
		price = 1.5
	
