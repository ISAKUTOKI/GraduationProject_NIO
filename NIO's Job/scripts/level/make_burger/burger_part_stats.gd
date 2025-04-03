class_name BurgerPartStats
extends Resource

@export var type: PartType

enum PartType { 汉堡上, 汉堡下, 肉饼, 芝士, 芥末酱, 番茄酱, 生菜, 洋葱, 番茄, 黄瓜 }

const UnusedPartSprite := {
	PartType.汉堡上: "res://assets/images/level_make_burger/bread_up.png",
	PartType.汉堡下: "res://assets/images/level_make_burger/bread_low.png",
	PartType.肉饼: "res://assets/images/level_make_burger/meat.png",
	PartType.芝士: "res://assets/images/level_make_burger/cheese.png",
	PartType.芥末酱: "res://assets/images/level_make_burger/mustard.png",
	PartType.番茄酱: "res://assets/images/level_make_burger/ketchup.png",
	PartType.生菜: "res://assets/images/level_make_burger/lettuce.png",
	PartType.洋葱: "res://assets/images/level_make_burger/onion.png",
	PartType.番茄: "res://assets/images/level_make_burger/tomato.png",
	PartType.黄瓜: "res://assets/images/level_make_burger/cucumber.png"
}

const UsedPartSprite := {
	PartType.汉堡上: "res://assets/images/level_make_burger/burger_bread_up.png",
	PartType.汉堡下: "res://assets/images/level_make_burger/burger_bread_low.png",
	PartType.肉饼: "res://assets/images/level_make_burger/burger_meat.png",
	PartType.芝士: "res://assets/images/level_make_burger/burger_cheese.png",
	PartType.芥末酱: "res://assets/images/level_make_burger/burger_mustard.png",
	PartType.番茄酱: "res://assets/images/level_make_burger/burger_ketchup.png",
	PartType.生菜: "res://assets/images/level_make_burger/burger_lettuce.png",
	PartType.洋葱: "res://assets/images/level_make_burger/bueger_onion.png",
	PartType.番茄: "res://assets/images/level_make_burger/burger_tomato.png",
	PartType.黄瓜: "res://assets/images/level_make_burger/burger_cucumber.png"
}

const CreateOffset := {
	PartType.汉堡上: Vector2(0, 8),
	PartType.汉堡下: Vector2(0, 4),
	PartType.肉饼: Vector2(0, 4),
	PartType.芝士: Vector2(0, 3),
	PartType.芥末酱: Vector2(0, 2),
	PartType.番茄酱: Vector2(0, 2),
	PartType.生菜: Vector2(0, 3),
	PartType.洋葱: Vector2(0, 3),
	PartType.番茄: Vector2(0, 3),
	PartType.黄瓜: Vector2(0, 1)
}
