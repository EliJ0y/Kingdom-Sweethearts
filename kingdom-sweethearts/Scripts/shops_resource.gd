extends Resource

class_name ShopsResource

enum ItemType {WritingMaterials, 
			   Postcards, 
			   BakedGoods}

@export var description: String
@export var price: String
@export var texture: Texture2D
@export var item_type: ItemType
