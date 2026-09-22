@tool
extends EditorPlugin

func _enter_tree() -> void:
	add_custom_type("WebAPI", "Node", preload("res://addons/webapi/webapi.gd"), preload("res://addons/webapi/icon.png"))
	if ProjectSettings.has_setting("autoload/Webserver"):
		return
	else:
		print_rich("[color=yellow]WARNING: [/color]make sure to add res://addons/webapi/webserver.gd as an Autoload in settings or the WebAPI node will [color=red][b]NOT[/b][/color] work")
	
	

func _exit_tree() -> void:
	remove_custom_type("WebAPI")
