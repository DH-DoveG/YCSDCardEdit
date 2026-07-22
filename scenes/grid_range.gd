extends VBoxContainer


func _ready() -> void:
	$Range/LineEdit.value_changed.connect(func(v):
		for node in $Grid.get_children():
			node.queue_free()
		$Grid.columns = v
		for i in range(v):
			for j in range(v):
				var bc = preload("res://scenes/block_controller.tscn").instantiate()
				$Grid.add_child(bc)
				bc.show()
	)
	$Range.number = 5


func get_data():
# { "size": 5, "grid": [0, 0, 0, 1, 2, ...] }
# size 确定尺寸（不能单独设置 x与y 因为这会让网格单元变形）
# 0: 空白
# 1: 白色
# 2: 红色
# 3: 暴击区
# 4: 黑色
#"unit_attack_gc"
	var grids = []
	for node in $Grid.get_children():
		grids.append(node.value)
	
	return {
		"size": $Range.number,
		"grid": grids
	}
