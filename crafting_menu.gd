extends Control

@onready var root = self
@onready var menu = $Menu
@onready var character = $Character
@onready var inventory = $Inv_UI
@onready var map = $Map
@onready var crafting = $Crafting

@onready var info_popup = $Map/markers/info_popup
@onready var shelburne_info = $Map/markers/info_popup/shelburne_info
@onready var shelburne_forest_info = $Map/markers/info_popup/shelburne_forest_info
@onready var spawn_info = $Map/markers/info_popup/spawn_info
@onready var sandbox_info = $Map/markers/info_popup/sandbox_info

@onready var shelburne_button = $Map/markers/shelburne_centrum
@onready var shelburne_forest_button = $Map/markers/shelburne_forest
@onready var spawn_button = $Map/markers/spawn_marker
@onready var sandbox_button = $Map/markers/sandbox

@onready var zoom_cam = $zoom_cam
@onready var map_pos = $Map/Container/map_pos
@onready var map_anchor = $anchor_point

var selected_tab_index : int = 0

var postclick = false

signal update_slot

signal disable_world_build()
# Called when the node enters the scene tree for the first time.
func _ready():
	menu.visible = false
	character.visible = false
	inventory.visible = false
	map.visible = false
	crafting.visible = false
	
	info_popup.visible = true
	shelburne_info.visible = false
	shelburne_forest_info.visible = false
	spawn_info.visible = false
	sandbox_info.visible = false
	
	zoom_cam.position = Vector2(zoom_cam.position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var cam_pos = get_viewport().get_mouse_position()
	if Input.is_action_just_pressed("m"):
		open()
	if Input.is_action_just_pressed("escape"):
		exit()
	if Input.is_action_just_pressed("Mouse_scroll_up"):
		map.scale = Vector2(6,6)
#		get_viewport().get_mouse_position()
#		var cam_pos = get_viewport().get_mouse_position()
#		zoom_cam.position = Vector2(cam_pos)
#		if cam_pos > Vector2(0,0):
#			get_tree().quit
#		if cam_pos > Vector2(1512.14,1119.378):
#			get_tree().quit
	if Input.is_action_just_pressed("Mouse_scroll_down"):
		map.scale = Vector2(3,3)
	if Input.is_action_just_released("Right-Click"):
		map_anchor.position = cam_pos
		map_anchor.reparent(root, true)
#		map.reparent(root, true)
#		map_anchor.reparent(root, true)
		map.reparent(map_anchor, true)
#		map_anchor.reparent(root, true)
#		map.reparent(root, true)
#		map.position = map_anchor.position
		#get_tree().create_timer(1)
#		postclick = true
	if Input.is_action_pressed("Right-Click"):
#		zoom_cam.zoom = Vector2(1,1)
#		var cam_pos = get_viewport().get_mouse_position()
#		zoom_cam.position = Vector2(cam_pos)
#		map.position = map_anchor.position#Vector2(cam_pos)-Vector2(750,400)
#		map_anchor.reparent(root, true)
#		map.reparent(root, true)
#		map_anchor.reparent(root, true)
#		map.reparent(map_anchor, true)
#		map_anchor.reparent(root, true)
##		map.reparent(root, true)
##		map_anchor.reparent(root, true)
#		map.reparent(map_anchor, true)
		map.position = map_anchor.position
		
#		postclick = true
#	if postclick == true:
#		get_tree().create_timer(3).timeout
#		var cam_pos = get_viewport().get_mouse_position()
#		map_anchor.position = cam_pos
		
#		map_anchor.position = cam_pos


func _on_inventory_pressed():
	show_and_hide(inventory, character, map, crafting)


func _on_character_pressed():
	show_and_hide(character, crafting, map, inventory)


func _on_map_pressed():
	show_and_hide(map, inventory, character, crafting)


func _on_crafting_pressed():
	show_and_hide(crafting, inventory, character, map)

func show_and_hide(first, second, third, fourth):
	first.show()
	second.hide()
	third.hide()
	fourth.hide()

func _on_inventory_tab_clicked(tab):
	show_and_hide(inventory, character, map, crafting)


func _on_character_tab_clicked(tab):
	show_and_hide(character, crafting, map, inventory)
	

func _on_map_tab_clicked(tab):
	show_and_hide(map, inventory, character, crafting)


func _on_crafting_tab_clicked(tab):
	show_and_hide(crafting, inventory, character, map)


func _on_tab_container_tab_clicked(tab : int):
	if tab == 0:
		show_and_hide(inventory, character, map, crafting)
	if tab == 1:
		show_and_hide(character, crafting, map, inventory)
	if tab == 2:
		show_and_hide(map, inventory, character, crafting)
	if tab == 3:
		show_and_hide(crafting, inventory, character, map)


func _on_exit_menu_pressed():
	exit()
	
func open():
	menu.visible = true
	character.visible = false
	inventory.visible = true
	map.visible = false
	crafting.visible = false
func exit():
	menu.visible = false
	character.visible = false
	inventory.visible = false
	map.visible = false
	crafting.visible = false



func clicked():
	self.visible = true


#func _on_shelburne_forest_pressed():
#	shelburne_forest_info.visible = true
	

func _on_shelburne_forest_toggled(button_pressed):
	if button_pressed == true:
		shelburne_forest_info.show()
		shelburne_forest_button.icon = preload("res://inventory/marker_clicked.png")
		
	else:
		shelburne_forest_info.hide()
		shelburne_forest_button.icon = preload("res://inventory/marker_notclicked.png")
		
func _on_spawn_marker_toggled(button_pressed):
	if button_pressed == true:
		spawn_info.show()
		spawn_button.icon = preload("res://inventory/marker_clicked.png")
		
	else:
		spawn_info.hide()
		spawn_button.icon = preload("res://inventory/marker_notclicked.png")


func _on_shelburne_centrum_toggled(button_pressed):
	if button_pressed == true:
		shelburne_info.show()
		shelburne_button.icon = preload("res://inventory/marker_clicked.png")
		
	else:
		shelburne_info.hide()
		shelburne_button.icon = preload("res://inventory/marker_notclicked.png")



func _on_sandbox_toggled(button_pressed):
	if button_pressed == true:
		sandbox_info.show()
		sandbox_button.icon = preload("res://inventory/marker_clicked.png")
		
	else:
		sandbox_info.hide()
		sandbox_button.icon = preload("res://inventory/marker_notclicked.png")


func _on_test_enviroment_update_slot():
	update_slot.emit()


func _on_inv_ui_slot_disable_building():
	emit_signal("disable_world_build")


func _on_node_2d_update_slot():
	update_slot.emit()
