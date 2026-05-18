extends Area2D
@export var rope_parent: Rope
var win: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	rope_parent = get_tree().get_root().get_node("Main/Controller/RopeController") as Rope
	body_entered.connect(_on_body_entered)

func _on_body_entered(body:Node):
	if body.name.contains("Plug"):
		print("Game Win")
		if rope_parent == null:
			print("Rope parent is null!")
			return
		if rope_parent != null and rope_parent._is_all_touch:
			for segment in rope_parent._segments:
				var i = 10.0 + sin(Time.get_ticks_msec() * 0.01) * 5.0
				if segment.has_node("Sprite2D"):
					var sprite = segment.get_node("Sprite2D")
					sprite.self_modulate = Color(0.0, 16.498, 18.892)  # HDR cyan from your picker
					sprite.modulate = Color.WHITE
					await get_tree().create_timer(0.04).timeout
				else:
					print("Segment ", segment.name, " does not have a Sprite2D child.")

			# await get_tree().create_timer(1).timeout
			if not win:
				rope_parent.called_game_win()
			UIManager.instance.InActivePlay()
			win = true
