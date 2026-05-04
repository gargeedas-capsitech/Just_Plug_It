extends Resource
class_name PlayerData

@export var player_type: PlayerType
@export var player: PackedScene
@export var position: Vector2 = Vector2.ZERO
@export var rotation: float = 0.0

enum PlayerType{
	StarPoint,
	EndPoint
}
