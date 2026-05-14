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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
