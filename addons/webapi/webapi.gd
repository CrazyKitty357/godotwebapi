@tool
extends Node
class_name WebAPI
## A node that allows you to control godot via a curl request or a browser![br]
## [br]
## It's recommended to have your node extend from this and it's code should have the handle_request function.

func _ready() -> void:
	if Engine.is_editor_hint():
		return

	var web_server = get_node("/root/Webserver")
	web_server.register_web_api(self)

## A powerful endpoint that handles the requests.[br] [br]
## [b]Example[/b] (yes, the function has to be called "handle_request" to work.)
## [codeblock]
## func handle_request(data: Dictionary) -> String:
##		
##	# print(data["path"])
## 	
##	match data["path"]:
##		"/":
##			print("root page!")
##			return "this should load when you go to http://localhost:60407"
##		"/api/time":
##			print("time!")
##			return Time.get_datetime_string_from_system()
##		"/api/ping":
##			print("ping!")
##			return "pong!"
##		"/api/neofetch":
##			print("neofetch!")
##			var output = []
##			OS.execute("fastfetch", [], output)
##			return output[0]
##		"/api/quit":
##			print("quit!")
##			get_tree().quit(0)
##			return "byebye!"
##		_:
##			return "OK"
## [/codeblock]
func handle_request(data: Dictionary) -> String:
	return ""
