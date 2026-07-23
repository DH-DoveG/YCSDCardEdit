@tool
extends Control


@export var title := "" :
	set(v):
		title = v
		$Title.text = v
@export var rr_type := 0 :
	set(v):
		rr_type = v
		match rr_type:
			0:
				$RR2.hide()
				$RR3.hide()
			1:
				$RR2.show()
				$RR3.hide()
			2:
				$RR2.hide()
				$RR3.show()


func get_data():
	var images = []
	if $"ImageStatck/1".texture == null:
		return images
	var img = $"ImageStatck/1".texture.get_image()
	#var img_scale = Vector2($Scroll/SizeChangeOption/Scale/X.value, $Scroll/SizeChangeOption/Scale/Y.value)
	#var img_offset = Vector2($Scroll/SizeChangeOption/Offset/X.value, $Scroll/SizeChangeOption/Offset/Y.value)
	#var img_rotation = $Scroll/SizeChangeOption/Rotation.value
	
	images.append({
		"obj": img,
		"scale": { "x": $Scroll/SizeChangeOption/Scale/X.value, "y": $Scroll/SizeChangeOption/Scale/Y.value },
		"offset": { "x": $Scroll/SizeChangeOption/Offset/X.value, "y": $Scroll/SizeChangeOption/Offset/Y.value },
		"rotation": $Scroll/SizeChangeOption/Rotation.value
	})
	
	return images


func set_data(data):
	for image in data:
		$"ImageStatck/1".texture = ImageTexture.create_from_image(image["obj"])
		#$"ImageStatck/1".scale = Vector2(image["scale"]["x"], image["scale"]["y"])
		$Scroll/SizeChangeOption/Scale/X.value = image["scale"]["x"]
		$Scroll/SizeChangeOption/Scale/Y.value = image["scale"]["y"]
		$Scroll/SizeChangeOption/Rotation.value = image["rotation"]


func _ready() -> void:
	$Scroll/SizeChangeOption/Offset/X.get_line_edit().add_theme_font_size_override(&"font_size", 24)
	$Scroll/SizeChangeOption/Offset/Y.get_line_edit().add_theme_font_size_override(&"font_size", 24)
	$Scroll/SizeChangeOption/Scale/X.get_line_edit().add_theme_font_size_override(&"font_size", 24)
	$Scroll/SizeChangeOption/Scale/Y.get_line_edit().add_theme_font_size_override(&"font_size", 24)
	$Scroll/SizeChangeOption/Rotation.get_line_edit().add_theme_font_size_override(&"font_size", 24)
	pass


func _on_file_dialog_file_selected(path: String) -> void:
	print("open_file_path: ", path)
	var t = path_to_image(path)
	print("T: ", t)
	#$Button.texture_normal = t
	#print("t: ", t)
	#print(FileAccess.get_file_as_string(path))
	#FileAccess.get_file_as_bytes(path)
	$"ImageStatck/1".texture = t
	$Scroll/ImageChooseOption.texture = t
	pass # Replace with function body.


static func byte_to_image(data: PackedByteArray, suffix: String) -> Texture2D:
	var res = Image.new()
	match suffix:
		"png":
			res.load_png_from_buffer(data)
		"jpg", "jpeg":
			res.load_jpg_from_buffer(data)
	res.generate_mipmaps()
	return ImageTexture.create_from_image(res)


static func path_to_image(path: String) -> Texture2D:
	# 内部
	if path.begins_with("res://"):
		return load(path)
	# 外部
	var bytes := FileAccess.get_file_as_bytes(path)
	if bytes.is_empty():
		return null
	return byte_to_image(bytes, path.get_extension())


static func load_outside_folder(path: String, suffix: PackedStringArray = ["*"]) -> PackedStringArray:
	var dir := DirAccess.open(path)
	var psa := []
	if dir:
		dir.list_dir_begin()
		var file_name := dir.get_next()
		while file_name != "":
			# 遇到目录就进入目录进行递归遍历
			if dir.current_is_dir():
				psa.append(path + file_name + "/")
				psa.append_array(load_outside_folder(path + file_name + "/"))
			# 遇到文件
			# 检查文件后缀
			else:
				if suffix.has("*") or file_name.get_extension() in suffix:
					psa.append(path + file_name)
			file_name = dir.get_next()
		dir.list_dir_end()
	else:
		push_error("尝试访问路径时出错。")
	return psa


func _on_image_choose_pressed() -> void:
	$Scroll/RRTypeOption.hide()
	$Scroll/SizeChangeOption.hide()
	$Scroll/ImageChooseOption.show()


func _on_rr_type_pressed() -> void:
	$Scroll/ImageChooseOption.hide()
	$Scroll/SizeChangeOption.hide()
	$Scroll/RRTypeOption.show()


func _on_size_change_pressed() -> void:
	$Scroll/ImageChooseOption.hide()
	$Scroll/RRTypeOption.hide()
	$Scroll/SizeChangeOption.show()


#func _on_image_choose_option_pressed() -> void:
	#$FileDialog.popup_centered()
	#pass
	#$GetGalleryImage.get_gallery()
	#var images = await $GetGalleryImage.gallery_image_result
	#for image in images:
		#$"ImageStatck/1".texture = ImageTexture.create_from_image(image)
	#get_tree().change_scene_to_file("res://get_gallery_image.tscn")


func _on_rrto_none_pressed() -> void:
	$RR2.hide()
	$RR3.hide()


func _on_rrto_square_pressed() -> void:
	$RR2.hide()
	$RR3.show()


func _on_rrto_card_pressed() -> void:
	$RR2.show()
	$RR3.hide()


func _on_offset_x_changed(value: float) -> void:
	$"ImageStatck/1".offset_transform_position.x = value


func _on_offset_y_changed(value: float) -> void:
	$"ImageStatck/1".offset_transform_position.y = value


func _on_scale_x_changed(value: float) -> void:
	$"ImageStatck/1".offset_transform_scale.x = value


func _on_scale_y_changed(value: float) -> void:
	$"ImageStatck/1".offset_transform_scale.y = value


func _on_rotation_changed(value: float) -> void:
	$"ImageStatck/1".offset_transform_rotation = deg_to_rad(value)


func _on_jpg_pressed() -> void:
	$GetGalleryImage.set_option_jpg()
	$GetGalleryImage.get_gallery()
	$GetGalleryImage.gallery_image_result.connect(func(images, _format):
		$"ImageStatck/1".texture = ImageTexture.create_from_image(images[0])
		#$Scroll/ImageChooseOption.texture = ImageTexture.create_from_image(images[0])
	)


func _on_png_pressed() -> void:
	$GetGalleryImage.set_option_png()
	$GetGalleryImage.get_gallery()
	$GetGalleryImage.gallery_image_result.connect(func(images, _format):
		$"ImageStatck/1".texture = ImageTexture.create_from_image(images[0])
	)
