extends Camera2D
#
#@export var drag_sensitivity: float = 1.0    # 1.0 = 1:1 drag
#@export var use_smoothing: bool = true
#@export var smoothing_speed: float = 10.0    # higher = snappier
#@export var consume_input: bool = true       # set to false if you want UI to receive clicks first
#
#var _dragging: bool = false
#var _drag_mouse_start: Vector2
#var _drag_cam_start: Vector2
#var _target_position: Vector2
#
#func _ready() -> void:
	#_target_position = global_position
#
#func _unhandled_input(event: InputEvent) -> void:
	## use _input(event) if you want to always capture input (even UI)
	#if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		#if event.pressed:
			#_dragging = true
			#_drag_mouse_start = get_global_mouse_position()
			#_drag_cam_start = global_position
			#if consume_input:
				#get_viewport().set_input_as_handled()
		#else:
			#_dragging = false
#
	#elif event is InputEventMouseMotion and _dragging:
		## get_global_mouse_position is preferred for predictable panning
		#var mouse_pos = get_global_mouse_position()
		#var delta = mouse_pos - _drag_mouse_start
		#_target_position = _drag_cam_start - delta * drag_sensitivity
		## optional: immediately apply when not using smoothing
		#if not use_smoothing:
			#global_position = _clamp_to_limits(_target_position)
#
#func _process(delta: float) -> void:
	#if use_smoothing:
		#global_position = global_position.lerp(_clamp_to_limits(_target_position), clamp(smoothing_speed * delta, 0.0, 1.0))
	#else:
		## if not smoothing, ensure target is clamped/applied
		#global_position = _clamp_to_limits(_target_position)
#
#func _clamp_to_limits(pos: Vector2) -> Vector2:
	## Camera2D has limit_left/right/top/bottom properties
	#var x = pos.x
	#var y = pos.y
	#if has_meta("limit_left"):
		## not necessary — limits exist by default. Use them directly:
		#pass
	#x = clamp(x, limit_left + get_vp_half_width(), limit_right - get_vp_half_width())
	#y = clamp(y, limit_top + get_vp_half_height(), limit_bottom - get_vp_half_height())
	#return Vector2(x, y)
#
## helper to compute half viewport size in world units (accounting for zoom)
#func get_vp_half_width() -> float:
	#var vp_size = get_viewport_rect().size
	#return (vp_size.x * 0.5) * zoom.x
#
#func get_vp_half_height() -> float:
	#var vp_size = get_viewport_rect().size
	#return (vp_size.y * 0.5) * zoom.y
