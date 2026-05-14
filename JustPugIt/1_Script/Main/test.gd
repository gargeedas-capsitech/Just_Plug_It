extends Area2D
@export var rope_parent: Rope

# Called when the node enters the scene tree for the first time.
func _ready():
	rope_parent = get_tree().get_root().get_node("Main/Controller/RopeController") as Rope
	body_entered.connect(_on_body_entered)

func _on_body_entered(body:Node):
	if body.name.contains("Plug"):
		print("Game Win")
		
		if rope_parent != null and rope_parent._is_all_touch:
			rope_parent.called_game_win()
			for segment in rope_parent._segments:
				var i = 10.0 + sin(Time.get_ticks_msec() * 0.01) * 5.0
				var sprite = segment.get_node("Sprite2D")
				sprite.modulate = sprite.modulate.lerp(Color.WHITE,5.0)
				sprite.self_modulate = sprite.self_modulate.lerp(Color(13.751, 0.194, 13.785),5.0)
