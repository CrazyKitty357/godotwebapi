@tool
extends "res://addons/webapi/webapi.gd"

func _ready() -> void:
	super()
	
	# your custom init code go here
	# print("WebAPI node is added to scene")

func handle_request(data: Dictionary) -> String:
		
	# print(data) # you can uncomment this if you want to see debug information regarding what the browser is requesting
	
	match data["path"]:
		"/":
			# Run whatever code you want whenever that endpoint is hit.
			print("Godot: 'hello browser!'")
			
			# Send data back to the browser as a string
			return "Browser: 'hello godot!'"
		## this is what you send to the browser when none of your endpoints are hit (like a 404 error except it will always give 200)
		_:
			return ""
