extends Control


#
#func rp():
	## 安卓媒体权限申请
	#if OS.get_name() == "Android":
		#var perms = []
		#if OS.get_api_level() >= 33:
			#perms.append("android.permission.READ_MEDIA_IMAGES")
		#else:
			#perms.append("android.permission.READ_EXTERNAL_STORAGE")
		##OS.request_permissions(perms, _perm_callback)
		#OS.request_permissions()
#
#func _perm_callback(granted: bool, permissions: PackedStringArray):
	#if granted:
		#print("存储权限已授予，可以打开相册")
	#else:
		#print("权限拒绝，无法读取相册图片")


func _ready() -> void:
	#if OS.get_name() == "Android":
		#OS.request_permissions()
	Config.real_size = size
	Config.current_ct = $CardManager/Mount/CTOther
	#Config.current_open_file_updated.connect(func(v):
	#	$CardManager/FileName.text = v
	#)
	
	$CardInfoPanel.position.y = size.y
	#$Sidebar.update()
	#$CardInfoPanel.update()
	
	$CardInfoPanel.card_type_changed.connect(func(index):
		match index:
			0:
				for item in $CardManager/Mount.get_children():
					item.queue_free()
				var node = preload("res://card_template/ct_unit.tscn").instantiate()
				$CardManager/Mount.add_child(node)
				#node.size = Vector2(540, 756)
				#node.position = Vector2(39, 76)
				node.position = Vector2(54, 97)
			1:
				for item in $CardManager/Mount.get_children():
					item.queue_free()
				var node = preload("res://card_template/ct_other.tscn").instantiate()
				$CardManager/Mount.add_child(node)
				#node.size = Vector2(540, 756)
				node.position = Vector2(54, 97)
	)
	$CardInfoPanel.card_used_changed.connect(func(data):
		#print("card used changed : ", data)
		$CardManager/Mount.get_child(0).set_data(data)
	)
	

#
#func _on_line_edit_2_editing_toggled(toggled_on: bool) -> void:
	#get_tree().create_timer(0.5).timeout.connect(func():
		#var h = DisplayServer.virtual_keyboard_get_height()
		#print("1>", $CardInfoPanel/Scroll/VBox/LineEdit2.global_position.y)
		#print("2>", h * window_ratio)
		#if $CardInfoPanel/Scroll/VBox/LineEdit2.global_position.y < h * window_ratio:
			#return
		#print(toggled_on, " :H: ", h)
		#if toggled_on:
			#position.y -= 1000 * window_ratio #h
		#else:
			#position.y += 1000 * window_ratio
	#, ConnectFlags.CONNECT_ONE_SHOT)
	#pass # Replace with function body.


func _process(delta: float) -> void:
	var h = DisplayServer.virtual_keyboard_get_height()
	position.y = h * Config.window_ratio * -1


func set_data(data):
	$Sidebar.set_data(data)
	$CardInfoPanel.set_data(data)
