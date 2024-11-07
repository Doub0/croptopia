extends Node

var Global
var has_he_entered_zea_house = 1
var change_it_enter = 0
signal he_has_entered_zea_house
func _process(delta):
	if has_he_entered_zea_house == 0:
		change_it_enter = 1
func null_it_out():
	has_he_entered_zea_house = 0
	change_it_enter = 1
