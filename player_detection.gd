extends Area2D

# Define the player variable
var player = null


func _on_PlayerEntered(body):
	# Check if the entered body is the player
	if body.name == "Player":
		player = body
		# Implement logic when the player is detected
		# Example: Show a dialogue, start combat, etc.

func _on_PlayerExited(body):
	# Check if the exited body is the player
	if body.name == "Player":
		player = null
		# Implement logic when the player exits the detection area
		# Example: Stop combat, hide dialogue, etc.
