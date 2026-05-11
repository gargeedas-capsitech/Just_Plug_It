class_name ScrollGridController
extends ScrollContainer

# =====================================================
# SCROLL MODE
# =====================================================
enum GridScrollMode
{
	VERTICAL,
	HORIZONTAL
}

@export var grid_scroll_mode : GridScrollMode = GridScrollMode.VERTICAL

# =====================================================
# GRID SETTINGS
# =====================================================

@export var vertical_columns : int = 4
@export var horizontal_rows : int = 2

@export var horizontal_spacing : int = 10
@export var vertical_spacing : int = 10

@export var child_size : Vector2 = Vector2(120, 120)

@export var grid_container : GridContainer

# =====================================================
# READY
# =====================================================
func _ready():

	if grid_container == null:
		push_error("GridContainer reference missing.")
		return

	grid_container.add_theme_constant_override(
		"h_separation",
		horizontal_spacing
	)

	grid_container.add_theme_constant_override(
		"v_separation",
		vertical_spacing
	)

	refresh_layout()


# =====================================================
# PUBLIC API
# =====================================================
func refresh_layout():

	var total_children := grid_container.get_child_count()

	match grid_scroll_mode:

		# =========================================
		# VERTICAL MODE
		# =========================================
		GridScrollMode.VERTICAL:

			horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
			vertical_scroll_mode = ScrollContainer.SCROLL_MODE_AUTO

			grid_container.columns = max(vertical_columns, 1)


		# =========================================
		# HORIZONTAL MODE
		# =========================================
		GridScrollMode.HORIZONTAL:

			horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_AUTO
			vertical_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED

			grid_container.columns = max(
				ceili(
					float(total_children) /
					float(max(horizontal_rows, 1))
				),
				1
			)

	_refresh_children()


# =====================================================
# REFRESH CHILD SIZE
# =====================================================
func _refresh_children():

	for child in grid_container.get_children():

		if child is Control:

			child.custom_minimum_size = child_size


# =====================================================
# RUNTIME MODE CHANGE
# =====================================================
func set_vertical_mode(columns : int = 4):

	grid_scroll_mode = GridScrollMode.VERTICAL
	vertical_columns = columns

	refresh_layout()


func set_horizontal_mode(rows : int = 2):

	grid_scroll_mode = GridScrollMode.HORIZONTAL
	horizontal_rows = rows

	refresh_layout()