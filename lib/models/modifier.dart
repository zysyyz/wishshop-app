import './modifier_option.dart';

class Modifier {
  final int id;
  int storeId;
  int productId;
  String title;
  String optionType;
  String optionFormat;
  String optionUnit;
  String chooseType;
  int chooseAtLeast;
  int chooseUpTo;
  List<ModifierOption> options;
  String createdAt;
  String updatedAt;

  Modifier({
    this.id,
    this.storeId,
    this.productId,
    this.title,
    this.optionType,
    this.optionFormat,
    this.optionUnit,
    this.chooseType,
    this.chooseAtLeast,
    this.chooseUpTo,
    this.options,
    this.createdAt,
    this.updatedAt,
  });

  factory Modifier.fromJson(Map<String, dynamic> json) {
    List<ModifierOption> options = [];
    if (json['options'] != null) {
      Iterable l = json['options'] as List;
      options = l.map((item) => ModifierOption.fromJson(item)).toList();
    }
    return Modifier(
      id              : json['id'],
      storeId         : int.parse(json['store_id'].toString()),
      productId       : json['product_id'],
      title           : json['title'],
      optionType      : json['option_type'],
      optionFormat    : json['option_format'],
      optionUnit      : json['option_unit'],
      chooseType      : json['choose_type'],
      chooseAtLeast   : json['choose_at_least'],
      chooseUpTo      : json['choose_up_to'],
      options         : options,
      createdAt       : json['created_at'],
      updatedAt       : json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() =>
    {
      'id'              : id,
      'store_id'        : storeId,
      'product_id'      : productId,
      'title'           : title,
      'option_type'     : optionType,
      'option_format'   : optionFormat,
      'option_unit'     : optionUnit,
      'choose_type'     : chooseType,
      'choose_at_least' : chooseAtLeast,
      'choose_up_to'    : chooseUpTo,
      'options'         : options,
      'created_at'      : createdAt,
      'updated_at'      : updatedAt,
    };
}
