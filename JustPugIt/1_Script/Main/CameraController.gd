extends Camera2D
 
signal rotation_changed(new_rotation: float)
 
func rotate_board(delta: float) -> void:
	self.rotation -= 0.5 * delta
	emit_signal("rotation_changed", self.rotation)
 
func rotate_board_right(delta: float) -> void:
	self.rotation += 0.5 * delta
	emit_signal("rotation_changed", self.rotation)