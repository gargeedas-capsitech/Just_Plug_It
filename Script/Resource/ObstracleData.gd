extends Resource
class_name ObstracleData


@export var obstracle_type: ObstracleType
@export var Obstracle: PackedScene
@export var Position: Vector2

enum ObstracleType {
	RotateCutter ,
	StaticCutter ,
	SwitchObstacle,
	Circle
}
