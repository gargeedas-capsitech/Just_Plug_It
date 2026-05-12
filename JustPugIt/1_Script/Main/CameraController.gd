extends Camera2D
func rotate_board(delta):
	self.rotation -= 0.5 * delta


func rotate_board_right(delta):
	self.rotation += 0.5 * delta
