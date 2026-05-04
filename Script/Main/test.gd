extends Area2D
@export var rope:Rope

# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body:Node):
	if body.name.contains("Plug"):
		print("Game Win")
		
		var rope:=get_parent() as Rope
		if rope != null and rope._is_all_touch:
			rope.called_game_win()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
