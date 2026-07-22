extends ColorRect


#signal sidebar_export_card


var sidebar_status = false
func _on_btn_pressed() -> void:
	sidebar_status = not sidebar_status
	var tween := get_tree().create_tween()
	if sidebar_status:
		tween.tween_property(self, "position:x", 0, 0.25)
	else:
		tween.tween_property(self, "position:x", -424, 0.25)


func update() -> void:
	var text = "调试信息：" + \
	"\n窗口尺寸：" + str(Config.window_size) + \
	"\n场景尺寸：" + str(size) + \
	"\n尺寸比例：" + str(Config.window_ratio)
	
	$Debug.append_text(text)


func _on_export_pressed() -> void:
	#sidebar_export_card.emit()
	#var node = get_parent().get_node("/CardManager/Mount").get_child(0).duplicate(DUPLICATE_SCRIPTS)
	#export_image(node)
	$ExportImage.popup_centered()
	pass # Replace with function body.


func _on_save_pressed() -> void:
	if get_parent().get_node("./CardManager/Mount").get_child(0).idata == null:
		ToastX.error("没有可保存的内容")
		return
	if not Config.current_open_file.is_empty():
		save_ycc(Config.current_open_file)
		return
	$SaveYCC.popup_centered()


func _on_open_pressed() -> void:
	$OpenYCC.popup_centered()
	pass # Replace with function body.



func export_image(node, path):
	var id = ToastX.show_loading("导出中")
	$ExportSubViewport.show()
	$ExportSubViewport/SubViewport.add_child(node)
	get_tree().create_timer(1).timeout.connect(func():
		node.position = Vector2.ZERO
		node.scale = Vector2i(1, 1)
		await RenderingServer.frame_post_draw
		#$ExportSubViewport/SubViewport.get_texture().get_image().save_png("user://Screenshot.png")
		var image = $ExportSubViewport/SubViewport.get_texture().get_image().save_png_to_buffer()#.save_png(path)
		var file = FileAccess.open(path, FileAccess.WRITE)
		ToastX.complete_loading(id)
		if file:
			file.store_buffer(image)
			print("FINISHED")
			ToastX.info("导出完成")
			return
		print("ERROR")
	)


func _on_export_image_file_selected(path: String) -> void:
	print("SIFS: ", path)
	var node = get_parent().get_node("./CardManager/Mount").get_child(0).duplicate(DUPLICATE_SCRIPTS)
	export_image(node, path)

#
#func _on_save_ycc_file_selected(path: String) -> void:
	##if OS.get_name() == "Android":
		##OS.request_permissions()
	#print("SaveYcc PATH: ", path)
	#var c = get_parent().get_node("./CardManager/Mount").get_child(0)
	##c.idata
	##var ep = "/storage/emulated/0/Android/data/com.dovehome.ycsdcardedit/"
	#var ep = "/storage/emulated/0/Documents/YcsdCardEdit/"
	#var e = DirAccess.make_dir_absolute(ep + "CardSet/")
	#var ee = DirAccess.open(ep + "test/")
	#print("ee: ", ee)
	#var writer := ZIPPacker.new()
	#var err = writer.open(ep + "test/" + "z.ycc")
	#if err != OK:
		#print("创建失败: ", err)
		#return
	#writer.start_file("hello.txt")
	#writer.write_file("Hello World".to_utf8_buffer())
	#writer.close_file()
	#writer.close()
	#pass # Replace with function body.


func _on_open_ycc_file_selected(path: String) -> void:
	var reader = ZIPReader.new()
	var err = reader.open(path)
	
	#if path.begins_with(Config.PATH):
	Config.current_open_file = path
	
	var config_buffer := reader.read_file("config.json")

	var j = JSON.new()
	var i = JSON.parse_string(config_buffer.get_string_from_utf8())
	j.parse(i)
	var config = j.data

	for image in config["image"]:
		var obj = Image.new()
		var img = reader.read_file("images".path_join(image["obj"]))
		obj.load_png_from_buffer(img)
		image["obj"] = obj
	
	#Config.current_ct_updated.emit(config)
	print("CONFIG: ", config)
	Config.ct_update(config)

#问题：导出的图片保存，序列化总是错误
var id = -1
func _on_save_ycc_confirmed() -> void:
	var filename = $SaveYCC/Control/LineEdit.text + ".ycc"
	save_ycc(filename)


func save_ycc(filename: String):
	#id = ToastX.show_loading("正在保存卡片文件")
	if not DirAccess.dir_exists_absolute(Config.PATH.path_join("CardSet")):
		DirAccess.make_dir_recursive_absolute(Config.PATH.path_join("CardSet"))

	var full_filename = Config.PATH.path_join("CardSet").path_join(filename)
	if FileAccess.file_exists(full_filename):
		pass

	var data = get_parent().get_node("./CardManager/Mount").get_child(0).idata
	# [  { "obj": IMAGE RESOURCE, "scale": Vector2, "offset": Vector2, "rotation": float }  ]
	var images = [] # [ { "buffer": [], "name": "" } ]
	for image in data["image"]:
		var n = str(images.size()) + ".png"
		images.append({
			"buffer": image["obj"].save_png_to_buffer(),
			"name": n
		})
		image["obj"] = n
	
	var writer := ZIPPacker.new()
	var err = writer.open(full_filename)
	if err != OK:
		ToastX.error("创建失败，错误码：" + str(err))
		return
	writer.start_file("config.json")
	writer.write_file(JSON.stringify(str(data), "\t").to_utf8_buffer())
	writer.close_file()
	for image in images:
		writer.start_file("images".path_join(image["name"]))
		writer.write_file(image["buffer"])
		writer.close_file()
	writer.close()
	
	#ToastX.complete_loading(id)
	ToastX.success("文件保存完成")
