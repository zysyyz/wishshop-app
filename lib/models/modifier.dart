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
      storeId         : int.parse(json['storeId'].toString()),
      productId       : json['productId'],
      title           : json['title'],
      optionType      : json['optionType'],
      optionFormat    : json['optionFormat'],
      optionUnit      : json['optionUnit'],
      chooseType      : json['chooseType'],
      chooseAtLeast   : json['chooseAtLeast'],
      chooseUpTo      : json['chooseUpTo'],
      options         : options,
      createdAt       : json['createdAt'],
      updatedAt       : json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() =>
    {
      'id'              : id,
      'storeId'        : storeId,
      'productId'      : productId,
      'title'           : title,
      'optionType'     : optionType,
      'optionFormat'   : optionFormat,
      'optionUnit'     : optionUnit,
      'chooseType'     : chooseType,
      'chooseAtLeast' : chooseAtLeast,
      'chooseUpTo'    : chooseUpTo,
      'options'         : options,
      'createdAt'      : createdAt,
      'updatedAt'      : updatedAt,
    };
}
