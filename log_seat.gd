extends CharacterBody2D

signal sitting

var its_true = false
func _ready():
	$michael.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	


func _on_area_2d_body_entered(body):
	if Input.is_action_just_pressed("e"):
		$michael.visible = true
#	its_true = true
#	if its_true:
#		emit_signal("sitting")
