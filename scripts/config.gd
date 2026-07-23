extends Node


const PATH = "/storage/emulated/0/Documents/YcsdCardEdit/"

var window_size := Vector2.ZERO
var window_ratio := 1.0
var scene_size := Vector2(648, 1152)
var export_base_size := Vector2(1080, 1512)
var real_size := Vector2(648, 1152)
# 缺少实际场景尺寸

var current_open_file := "":
	set(v):
		current_open_file = v
		current_open_file_updated.emit(v)

var current_ct = null

signal current_ct_updated
signal current_open_file_updated


func ct_update(config):
	print("CT UPDATE: ", config)
	#get_tree().current_scene.get_node("CardInfoPanel")._on_card_type_choose_item_selected(config["card_class"])
	#var id = ToastX.show_loading("正在读取文件")
	#get_tree().create_timer(1).timeout.connect(func():
		#ToastX.complete_loading(id)
		#ToastX.success("读取成功")
	get_tree().current_scene.set_data(config)
	#)
	#current_ct.set_data(config)


func _ready() -> void:
	window_size = DisplayServer.window_get_size()
	window_ratio = scene_size.y / window_size.y
