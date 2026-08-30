extends Resource

class_name ShopsResource

enum ItemType {WritingMaterials, 
			   Postcards, 
			   BakedGoods,
			   Flowers}

@export var description: String
@export var price: String
@export var texture: Texture2D
@export var item_type: ItemType
