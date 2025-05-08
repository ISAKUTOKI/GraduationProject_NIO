class_name InteractStats
extends Node


#region InteractType 互动类型
enum InteractType { TALK, BOX_TALK, USE, PICK_UP }
#endregion

#region AVATAR_MAP 头像路径
const AVATAR_MAP = {
	"Nio_normal_null": preload("res://assets/images/hd_pic/Nio_normal_hd_pic.png"),
	"Nio_normal_embarrass": preload("res://assets/images/hd_pic/Nio_normal_hd_pic_embarrass.png"),
	"Nio_normal_lookdown": preload("res://assets/images/hd_pic/Nio_normal_hd_pic_lookdown.png"),
	"Nio_normal_sick": preload("res://assets/images/hd_pic/Nio_normal_hd_pic_sick.png"),
	"Nio_normal_sigh": preload("res://assets/images/hd_pic/Nio_normal_hd_pic_sigh.png"),
	"Nio_normal_wodden": preload("res://assets/images/hd_pic/Nio_normal_hd_pic_wodden.png")
}
#endregion
