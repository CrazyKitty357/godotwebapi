extends WebAPI
@onready var hello_world_text: RichTextLabel = $"../VBoxContainer/HelloWorldText"

func _ready() -> void:
	super()
	
	print_rich("[i]sample_text[/i]")

func handle_request(data: Dictionary) -> String:
	# print(data)
	match data["path"]:
		"/hello":
			print_rich("[wave]hello world[/wave]")
			print("")
			hello_world_text.show()
			var cwd = DirAccess.open(".").get_current_dir()
			
			return "hello world! (look at your godot terminal or game preview window for more information) If you want to learn how this example works go read the code located at %s/addons/example/web_api.gd" % cwd
		"/data":
			return "%s" % data
		"/quit":
			get_tree().quit(0)
			return "byebye!"
		_:
			# print(data)
			return (
				"<html>
					<head>
						<title>
							GDWebAPI
						</title>
					</head>
					<body>
						<h1>
							hello world!
						</h1>
						<p>
							this static website is hosted in godot!
						</p>
						<p>
							the current time is %s.
						</p>
						<a href='hello'>
							click me for a funky suprise :D
						</a>
						<br>
						<a href='data'>click me if you want to see your browser data (request headers)</a>
						<br>
						<a href='quit'>click me to close the example application</a>
					</body>
				</html>") % [Time.get_datetime_string_from_system(false, true)]


func _on_button_pressed() -> void:
	OS.shell_open("http://localhost:60407")
