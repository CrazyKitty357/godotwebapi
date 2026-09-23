extends Node

var server : TCPServer
var thread : Thread
var web_api : WebAPI

var request_mutex = Mutex.new()
var request_queue: Array = []
var request_semaphore = Semaphore.new()

var port : int = 60407 # change this to specify the port number

## change this to change what content type your browser expects.[br]
## useful types:[br]
## "text/html" - used when sending an html web page[br]
## "text/text" - used for sending raw text[br]
## "application/json" - used when sending json data[br]
var html_content_type = "text/html" 

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

## Binds webserver.gd to a WebAPI node.
func register_web_api(api: WebAPI):
	web_api = api

func _process(delta: float) -> void:
	while true:
		request_mutex.lock()
		
		if request_queue.is_empty():
			request_mutex.unlock()
			break
		
		var request = request_queue.pop_front()
		
		request_mutex.unlock()
		
		_process_request(request)

func _process_connections():
	while true:
		var client = server.take_connection()
		if client:
			
			while client.get_available_bytes() == 0:
				OS.delay_msec(10)
			
			var raw_request = client.get_utf8_string(client.get_available_bytes())
			var data = _parse_data(raw_request)
			# print(request)
			
			var request = {
				"data": data,
				"response": "",
				"semaphore": Semaphore.new()
			}
			
			request_mutex.lock()
			request_queue.push_back(request)
			request_mutex.unlock()
			
			request_semaphore.post()
			request.semaphore.wait()
			
			var html_content = request.response
			
			var response = (
				"HTTP/1.1 200 OK\r\n" +
				"Content-Type: %s\r\n" +
				"Content-Length: %d\r\n" +
				"Connection: close\r\n" +
				"\r\n" +
				"%s"
				) % [html_content_type, html_content.to_utf8_buffer().size(), html_content]
			
			client.put_data(response.to_utf8_buffer())
			client.disconnect_from_host()

## internal function that converts the browser's/curl's request headers to a dict and sends them to the request queue
func _process_request(request: Dictionary):
	var data: Dictionary = request["data"]
	
	if web_api:
		request["response"] = web_api.handle_request(data)
	else:
		request["response"] = "OK"
	
	request.semaphore.post()


## internal function that converts the request string to a dictionary
func _parse_data(raw: String) -> Dictionary:
	var lines = raw.split("\r\n")
	var first_line = lines[0].split(" ")
	
	var request = {
		"method": first_line[0],
		"path": first_line[1],
		"version": first_line[2],
		"headers": {},
		"body": ""
	}
	
	var i = 1
	
	while i < lines.size():
		if lines[i] == "":
			i += 1
			break
		
		var seperator = lines[i].find(":")
		if seperator == -1:
			i += 1
			continue
		
		var key = lines[i].substr(0, seperator)
		var value = lines[i].substr(seperator + 1).strip_edges()
		
		request["headers"][key] = value
		i += 1
	
	if i < lines.size():
		request["body"] = "\r\n".join(lines.slice(i))
	
	return request

## internal function used to move the data from the server back to the WebAPI node.
func _emit_request(api: WebAPI, data: Dictionary) -> void:
	api.request_received.emit(data)
