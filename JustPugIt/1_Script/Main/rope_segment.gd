extends RigidBody2D

var ropecut: bool = false

func _ready():
	var detector: Area2D = get_node("Area2D")

	detector.body_entered.connect(_on_body_entered)
	# detector.body_exited.connect(_on_body_exited)
	

func _on_body_entered(body):
	if body.name.contains("Obstracle"):
		var rope_parent = get_parent()
		
		if not ropecut:
			rope_parent.cut_rope_at(self)
			ropecut = true

	# elif body.name.contains("Switch"):
	# 	get_parent().visibility_update(body, true)

	elif body.name.contains("staticCutter"):
		var component = body.get_node_or_null("cutter") as Sprite2D
		
		if component:
			print("rope " + component.name)
			component.visible = true
			cut_rope()


# func _on_body_exited(body):
# 	if body.name.contains("Switch"):
# 		get_parent().visibility_update(body, false)


func cut_rope():
	await get_tree().create_timer(1.0).timeout
	var rope_parent = get_parent()
	rope_parent.cut_rope_at(self)


func _process(delta):
	pass
