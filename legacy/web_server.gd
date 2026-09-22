extends Node

var server : TCPServer
var thread : Thread

var port : int = 8080 # change this to specify port number

func _ready():
	server = TCPServer.new()
	var err = server.listen(port)
	if err != OK:
		print("Failed to start server on port " + str(port))
		return
	print("Server started on port " + str(port))


	thread = Thread.new()
	var callable = Callable(self, "_process_connections")
	thread.start(callable)

func _process_connections():
	while true:
		var client = server.take_connection()
		if client:
			# Send a simple output response to the client
			var html_content = "<html><body><h1>Hello, World!</h1></body></html>"
			var response = "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\nContent-Length: %d\r\n\r\n" % len(html_content)
			response += html_content
			
			# Log the response being sent, optionally you can comment the below line out and replace it with whatever code you want to run for your scene
			print("Sending response: %s" % response)
			
			client.put_utf8_string(response)
			# client.close()  # Uncommenting this line stops the server once the server gets pinged.
