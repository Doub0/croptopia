extends StaticBody2D

@export var item: InvItem
var player = null

func _ready():
	fallfromtree()
	
func fallfromtree():
	$AnimationPlayer.play("fallingfromtree")
	await get_tree().create_timer(1.5).timeout
	$AnimationPlayer.play("fade")
	print("+1 pinecone")
	await get_tree().create_timer(0.3).timeout
	queue_free()
	
func playercollect():
	player.collect(item)
