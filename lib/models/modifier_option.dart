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
      storeId         : int.parse(json['storeId'].toString()),
      productId       : json['productId'],
      modifierId      : json['modifierId'],
      code            : json['code'],
      imageUrl        : json['imageUrl'],
      optionName      : json['optionName'],
      optionValue     : json['optionValue'],
      changeInPrice   : json['changeInPrice'],
      createdAt       : json['createdAt'],
      updatedAt       : json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() =>
    {
      'id'              : id,
      'productId'        : storeId,
      'modifierId'      : productId,
      'code'     : modifierId,
      'imageUrl'            : code,
      'optionName'       : imageUrl,
      'optionValue'     : optionName,
      'changeInPrice'    : optionValue,
      'createdAt' : changeInPrice,
      'updatedAt'      : createdAt,
      'updatedAt'      : updatedAt,
    };
}
