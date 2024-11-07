extends Control

@onready var sunset = $sunset_rect/sunset_cycle
@onready var sunrise = $sunrise_rect/sunrise_cycle
@onready var sunset_rect = $sunset_rect
@onready var sunrise_rect = $sunrise_rect

@onready var night_rect = $night_rect
@onready var night = $night_rect/night_cycle
@onready var day = $day_rect/day_cycle
@onready var day_rect = $day_rect

#Day counter code
@onready var day_counter = $CanvasLayer/Panel/Sprite2D/count
var day_count
#
var addition = 1

var sunset_time
var sunrise_time

var night_time
var day_time

var phase

#OBJECT VARIABLES


# Called when the node enters the scene tree for the first time.
func _ready():
	day_count = 0
	phase = "day"
	day_time = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if phase == "sunset":
		sunrise_time = false
		sunset_time = true
		night_time = false
		day_time = false
		sunrise_rect.visible = false
		sunset_rect.visible = true
		night_rect.visible = false
		day_rect.visible = false
		sunset.play("day_night_cycle")
		
	if phase == "sunrise":
		sunrise_time = true
		sunset_time = false
		night_time = false
		day_time = false
		sunset_rect.visible = false
		sunrise_rect.visible = true
		night_rect.visible = false
		day_rect.visible = false
		sunrise.play("day_night_cycle_reverse")
		
	if phase == "night":
		sunrise_time = false
		sunset_time = false
		night_time = true
		day_time = false
		sunset_rect.visible = false
		sunrise_rect.visible = false
		night_rect.visible = true
		day_rect.visible = false
		night.play("night_cycle")
		
	if phase == "day":
		sunrise_time = false
		sunset_time = false
		night_time = false
		day_time = true
		sunset_rect.visible = false
		sunrise_rect.visible = false
		night_rect.visible = false
		day_rect.visible = true
		day.play("day_cycle")
		#the day count \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
		#\\\\\\\\\\\\\\\\\\\\\\\
		#SCRIPT FOR OBJECTS

func _on_sunset_cycle_animation_finished(anim_name):
	phase = "night"


func _on_sunrise_cycle_animation_finished(anim_name):
	phase = "day"
	day_counter.text = str(day_count + 1)
	day_count = day_count + 1


func _on_night_cycle_animation_finished(anim_name):
	phase = "sunrise"


func _on_day_cycle_animation_finished(anim_name):
	phase = "sunset"
