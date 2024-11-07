extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$anim.play("first_stage")
	$first_stage_timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_first_stage_timer_timeout():
	$anim.play("second_stage")
	if $anim.animation_changed:
		$second_stage_timer.start()


func _on_second_stage_timer_timeout():
	$anim.play("third_stage")
	$third_stage_timer.start()

func _on_third_stage_timer_timeout():
	$anim.play("fourth_stage")
