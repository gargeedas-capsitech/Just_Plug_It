extends RigidBody2D

var ropecut: bool = false
var rope_parent: Rope

func _ready():
	var detector: Area2D = get_node("Area2D")
	rope_parent = get_tree().get_root().get_node("Main/Controller/RopeController") as Rope
	detector.body_entered.connect(_on_body_entered)
	detector.body_exited.connect(_on_body_exited)
	

func _on_body_entered(body):
	if body.name.contains("Obstracle"):		
		if not ropecut:
			rope_parent.cut_rope_at(self)
			ropecut = true
			UIManager.instance.InActivePlay()
	elif body.name.contains("Switch"):
		
		rope_parent.visibility_update(body, true)
	elif body.name.contains("staticCutter"):
		var component = body.get_node_or_null("cutter") as Sprite2D
		
		if component:
			component.visible = true
			if not ropecut:
				rope_parent.cut_rope_at(self)
				UIManager.instance.InActivePlay()


func _on_body_exited(body):
	if body.name.contains("Switch"):
		rope_parent.visibility_update(body, false)


func cut_rope():
	await get_tree().create_timer(1.0).timeout
	rope_parent.cut_rope_at(self)


func _process(delta):
	pass
