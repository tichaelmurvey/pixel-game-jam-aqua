extends Node2D

var agent;
var cloud = preload("res://components/env/cloud.tscn")
var clouds = []
var max_clouds = 1
var cloud_ready = true
# Called when the node enters the scene tree for the first time.
func _ready():
	#get parent characterbody
	agent = get_parent()
	#connect to touched floor signal
	agent.touched_floor.connect(make_cloud_ready)
	#add down as protected angle
	print("cloud ready")

func remove():
	#reset agent variables
	queue_free()


var previous_frame_floor = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_just_pressed("jump") and previous_frame_floor == false and cloud_ready == true:
		print("cloud jump")
		agent.play_sound("cloud")
		#create cloud
		var cloud_instance = cloud.instantiate()
		clouds.append(cloud_instance)
		if clouds.size() > max_clouds:
			var cloud_to_remove = clouds.pop_front()
			cloud_to_remove.queue_free()
		#position at player feet
		cloud_instance.position = agent.position + Vector2(0, agent.get_height())
		get_tree().get_root().get_node("game").add_child(cloud_instance)
		agent.jump()
		cloud_ready = false
		hide()
	previous_frame_floor = agent.is_on_floor()


func make_cloud_ready():
	cloud_ready = true
	show()