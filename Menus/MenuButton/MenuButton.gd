extends TextureButton



func _on_ExtrasButton2_mouse_entered():
	grab_focus()


func _on_ExtrasButton2_pressed():
	UISelect.playing = true
