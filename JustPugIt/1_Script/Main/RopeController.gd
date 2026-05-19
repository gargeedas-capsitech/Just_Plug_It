extends Node2D
class_name  Rope

@export var segment_scene: PackedScene
@export var segment_count: int = 1
@export var segment_distance: float = 8.0
@export var plug_scene: PackedScene
@export var  ropesegmentParent: Node2D
@export var camera: Camera2D
@export var gamePanelController :GamePanelController

var segment_touch_switch: int = 0
var _is_already_cut: bool = false
var _is_all_touch: bool = false
var switch_count: int = 2

var _plug: Area2D
var _joint: PinJoint2D

var _segments: Array = []
var _joints: Dictionary = {}              
var switch_counter: Dictionary = {}      
var last_gravity_direction = Vector2.DOWN

var _current_gravity_force: Vector2 = Vector2(0, 600)

var count: int = 0
var wireCount: int = 0


func set_initial_segment():
	var anchor = StaticBody2D.new()
	if(ropesegmentParent!=null):
		ropesegmentParent.add_child(anchor)

	var previous: Node2D = anchor

	for i in range(segment_count):
		var segment = segment_scene.instantiate() as RigidBody2D
		_setup_segment(segment)
		if(ropesegmentParent!=null):
			ropesegmentParent.add_child(segment)

		_segments.append(segment)
		segment.position = Vector2(0, i * segment_distance)

		var joint = PinJoint2D.new()
		if(ropesegmentParent!=null):
			ropesegmentParent.add_child(joint)

		joint.position = segment.position
		joint.node_a = previous.get_path()
		joint.node_b = segment.get_path()
		joint.disable_collision = true
		
		# Softer joints reduce shockwave
		joint.softness = 0.02
		joint.bias = 0.0
		previous = segment

	if plug_scene == null:
		push_error("Error: You forgot to attach the Plug Scene in the Inspector!")
		return

	_plug = plug_scene.instantiate() as Area2D
	if(ropesegmentParent!=null):
		ropesegmentParent.add_child(_plug)

	attach_plug(_segments[-1])
	if camera != null:
		if camera.has_signal("rotation_changed"):
			if not camera.rotation_changed.is_connected(_on_camera_rotation_changed):
				camera.rotation_changed.connect(_on_camera_rotation_changed)
			print("Rope ✓ camera signal connected")
		else:
			push_error("Camera has no rotation_changed signal!")
	else:
		push_error("Camera not assigned!")

func _setup_segment(seg: RigidBody2D) -> void:
	seg.gravity_scale = 0
	seg.mass = 0.8
	# var mat= PhysicsMaterial.new()
	# mat.friction = 0.0
	# mat.bounce = 0.0
	# seg.physics_material_override = mat
	seg.can_sleep = false
	seg.sleeping = false

	seg.linear_damp = 2.0
	seg.angular_damp = 3.0

	seg.continuous_cd = RigidBody2D.CCD_MODE_CAST_RAY

	seg.max_contacts_reported = 1

	seg.constant_force = _current_gravity_force

func _on_camera_rotation_changed(new_rotation: float) -> void:
	var strength: float = ProjectSettings.get_setting("physics/2d/default_gravity")

	_current_gravity_force = Vector2.DOWN.rotated(new_rotation) * strength

	for seg in _segments:
		if is_instance_valid(seg):
			seg.constant_force = _current_gravity_force
			seg.sleeping = false

func set_switch_count(value: int):
	switch_count = value
	if switch_count <= 0:
		_is_all_touch = true
	print("switch count is printed ", switch_count, " ho ", switch_counter.size())


func visibility_update(body: Node, is_touching: bool):
	if not switch_counter.has(body):
		switch_counter[body] = 0

	if is_touching:
		switch_counter[body] += 1
		
	else:
		switch_counter[body] -= 1

	if switch_counter[body] < 0:
		switch_counter[body] = 0

	var component = body.get_node_or_null("Shader") as Sprite2D
	if component:
		if switch_counter[body] != 0:
			component.visibility_layer = 0
		else:
			component.visibility_layer = 1

	_is_all_touch = (switch_counter.size() == switch_count)



func add_segment():
	var last_segment = _segments[-1]

	if _joint and is_instance_valid(_joint):
		_joint.queue_free()
		_joint = null

	var new_segment = segment_scene.instantiate() as RigidBody2D
	_setup_segment(new_segment)
	if(ropesegmentParent!=null):
		ropesegmentParent.add_child(new_segment)

	var offset = last_segment.global_transform.y.normalized() * segment_distance
	new_segment.global_position = last_segment.global_position + offset
	new_segment.global_rotation = last_segment.global_rotation

	if is_instance_valid(new_segment):
		for seg in _segments:
			if is_instance_valid(seg) and seg is PhysicsBody2D:
				new_segment.add_collision_exception_with(seg)


	var joint = PinJoint2D.new()
	if(ropesegmentParent!=null):
		ropesegmentParent.add_child(joint)

	joint.disable_collision = true
	joint.global_position = last_segment.global_position + (offset / 2)
	joint.node_a = last_segment.get_path()
	joint.node_b = new_segment.get_path()
	joint.softness = 0.02
	joint.bias = 0.0



	_segments.append(new_segment)
	_joints[new_segment] = joint

	attach_plug(_segments[-1])
	wireCount +=1
	gamePanelController.wireLength(wireCount)

func remove_last_segment():
	if _segments.size() <= 2:
		return

	var segment_to_remove = _segments[-1]

	if _joints.has(segment_to_remove):
		_joints[segment_to_remove].queue_free()
		_joints.erase(segment_to_remove)

	_segments.remove_at(_segments.size() - 1)
	segment_to_remove.queue_free()
	wireCount -=1
	gamePanelController.wireLength(wireCount)

func reset_switch_counter() -> void:
	switch_counter.clear()
	_is_all_touch = false

func reset_rope():
	_is_already_cut = false
	_segments.clear()

func cut_rope_at(segment: RigidBody2D):
	if _is_already_cut:
		return

	if _joints.has(segment):
		_is_already_cut = true

		_joints[segment].queue_free()
		_joints.erase(segment)

		var index = _segments.find(segment)
		if index != -1:
			_segments = _segments.slice(0, index)

	UIManager.instance.enable_popup(PopupPanelController.PopupType.GAME_OVER)
	#var main = get_parent().get_parent()

	#if main and main.has_method("game_over"):
		#main.game_over()
	#else:
		#print("Rope could not find Main! check hierarchy.")


func called_game_win():
	UIManager.instance.update_win_segments(wireCount)
	UIManager.instance.enable_popup(PopupPanelController.PopupType.WIN)
	UIManager.instance.unlock_next_level(gamePanelController.current_level)
	#var main = get_parent().get_parent()

	#if main and main.has_method("game_win"):
		#main.game_win()
	#else:
		#print("Rope could not find Main! check hierarchy.")




func attach_plug(last_seg: RigidBody2D):
	if _joint and is_instance_valid(_joint):
		_joint.queue_free()

	var tip_offset = last_seg.global_transform.y.normalized() * segment_distance

	_plug.global_position = last_seg.global_position + tip_offset
	_plug.global_rotation = last_seg.global_rotation

	_joint = PinJoint2D.new()
	if(ropesegmentParent!=null):
		ropesegmentParent.add_child(_joint)

	_joint.global_position = _plug.global_position
	_joint.node_a = last_seg.get_path()
	_joint.node_b = _plug.get_path()

	_joint.disable_collision = true
	_joint.softness = 0.02
	_joint.bias = 0.15





func _process(_delta):
	if not _is_already_cut and _segments.size() > 0:
		var last_seg = _segments[-1]
		if !is_instance_valid(last_seg):
			return

		if !is_instance_valid(_plug):
			return
		var tip_offset = last_seg.global_transform.y.normalized() * segment_distance
		_plug.global_position = last_seg.global_position + tip_offset
		_plug.global_rotation = last_seg.global_rotation

	

#func _process(delta: float):
	#var gravity_direction = Vector2.DOWN.rotated(camera.rotation)
	#if _rope != null:
		#_rope.update_gravity(gravity_direction)
