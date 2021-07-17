extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#var dataString = {"studycode": "driving", "guid": "ab1235-x25", "data_version": "0.1", "data":""}
var dataString = {"filename": "ABCD23423", "filedata":""}


# Called when the node enters the scene tree for the first time.
func _ready():
	 pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _make_post_request(url, data_to_send):
	# Convert data to json string:
	var query = JSON.print(data_to_send)
	# Add 'Content-Type' header:
	var headers = ["Content-Type: application/json"]
	var http_client = HTTPClient.new()
	IP.clear_cache()
	var connErr = http_client.connect_to_host("http://192.168.0.12", 8081)
	var stmPeer = StreamPeer.new()
	http_client.set_connection(stmPeer)
	#while(http_client.get_status() == 1 or http_client.get_status() == 3):
	print(connErr)
	print(http_client.get_status())
	
	var returnVal = http_client.request(HTTPClient.METHOD_POST, url, headers, query)
	http_client.close()
	return returnVal
	
#func _notification(what):
#	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST or what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
#		dataString.filedata = global.dict
#		var outputCode = _make_post_request("CannonHTML2/record_result.php", dataString)
#		print(outputCode)
#		print("DONEONE")

func _exit_tree():
	dataString.filedata = global.dict
	var outputCode = _make_post_request("/CannonHTML2/record_result.php", dataString)
	print(outputCode)
	print("DONEONE")
