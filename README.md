# godotwebapi

this is an addon designed to let developers add a custom http interface which would allow them to be able to control their godot application remotely, via the web!

## How to add
1. copy this repo
    - `git clone https://github.com/CrazyKitty357/godotwebapi.git`
    - or `https://github.com/CrazyKitty357/godotwebapi/archive/refs/heads/main.zip`

2. if downloaded via link unzip the file
3. move `webapi` folder that's in `addons` to the `addons` folder of your project
4. make `res://addons/webapi/webserver.gd` an autoload
5. add a `WebAPI` node to your scene of choice
6. extend the WebAPI node (right click the node -> Extend Script...)
7. add `@tool` to the top of the script
8. if you have the default `_ready` and `_process` functions delete them.
9. right click on the WebAPI node and click on documentation
10. copy the code snippet via clicking on the 2 squares on the top right of the code snippet box
11. go back to the code and paste it in.
12. edit the match statement to fit your needs.
13. start the project.
14. go to http://localhost:60407 (named that way because it looks a bit like the word godot) and you should see the request go through.
