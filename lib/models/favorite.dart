import './product.dart';

class Favorite {
  final int id;
  int storeId;
  int userId;
  String targetType;
  int targetId;
  String createdAt;
  String updatedAt;
  Product product;

  Favorite({
    this.id,
    this.storeId,
    this.userId,
    this.targetType,
    this.targetId,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      id              : json['id'],
      storeId         : int.parse(json['storeId'].toString()),
      userId          : json['userId'],
      targetType      : json['targetType'],
      targetId        : int.parse(json['targetId'].toString()),
      createdAt       : json['createdAt'],
      updatedAt       : json['updatedAt'],
      product         : json['product'] != null ? Product.fromJson(json['product']) : null,
    );
  }

  Map<String, dynamic> toJson() =>
    {
      'id'            : id,
      'storeId'      : storeId,
      'userId'       : userId,
      'targetType'   : targetType,
      'targetId'     : targetId,
      'createdAt'    : createdAt,
      'updatedAt'    : updatedAt,
      'product'       : product != null ? product.toJson() : null,
    };
}
