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
      storeId         : int.parse(json['store_id'].toString()),
      userId          : json['user_id'],
      targetType      : json['target_type'],
      targetId        : int.parse(json['target_id'].toString()),
      createdAt       : json['created_at'],
      updatedAt       : json['updated_at'],
      product         : json['product'] != null ? Product.fromJson(json['product']) : null,
    );
  }

  Map<String, dynamic> toJson() =>
    {
      'id'            : id,
      'store_id'      : storeId,
      'user_id'       : userId,
      'target_type'   : targetType,
      'target_id'     : targetId,
      'created_at'    : createdAt,
      'updated_at'    : updatedAt,
      'product'       : product != null ? product.toJson() : null,
    };
}
