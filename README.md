# godotwebapi

this is an addon designed to let developers add a custom http interface which would allow them to be able to control their godot application remotely, via the web!

## How to add
1. copy this repo
	- `git clone https://github.com/CrazyKitty357/godotwebapi.git`
	- or `https://github.com/CrazyKitty357/godotwebapi/archive/refs/heads/main.zip`
	1.5. if downloaded via link unzip the file
2. move `webapi` folder that's in `addons` to the `addons` folder of your project
3. move `addons/webapi/script_templates` to `res://`
4. enable the addon
5. make `res://addons/webapi/webserver.gd` an autoload
6. add a `WebAPI` node to your scene of choice
7. extend the WebAPI node (right click the node -> Extend Script...)
8. click on the dropdown by `Template`, you should see a new template under `Project Templates` called `WebAPI: Template`.
9. click on `Create`.
10. edit the match statement to fit your needs.
11. start the project.
12. go to http://localhost:60407 (named that way because it looks a bit like the word godot) in your web browser and you should see the request go through.
