class ModifierOption {
  final int id;
  int storeId;
  int productId;
  int modifierId;
  String code;
  String imageUrl;
  String optionName;
  String optionValue;
  num changeInPrice;
  String createdAt;
  String updatedAt;

  ModifierOption({
    this.id,
    this.storeId,
    this.productId,
    this.modifierId,
    this.code,
    this.imageUrl,
    this.optionName,
    this.optionValue,
    this.changeInPrice,
    this.createdAt,
    this.updatedAt,
  });

  factory ModifierOption.fromJson(Map<String, dynamic> json) {
    return ModifierOption(
      id              : json['id'],
      storeId         : int.parse(json['store_id'].toString()),
      productId       : json['product_id'],
      modifierId      : json['modifier_id'],
      code            : json['code'],
      imageUrl        : json['image_url'],
      optionName      : json['option_name'],
      optionValue     : json['option_value'],
      changeInPrice   : json['change_in_price'],
      createdAt       : json['created_at'],
      updatedAt       : json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() =>
    {
      'id'              : id,
      'store_id'        : storeId,
      'product_id'      : productId,
      'modifier_id'     : modifierId,
      'code'            : code,
      'image_url'       : imageUrl,
      'option_name'     : optionName,
      'option_value'    : optionValue,
      'change_in_price' : changeInPrice,
      'created_at'      : createdAt,
      'updated_at'      : updatedAt,
    };
}
