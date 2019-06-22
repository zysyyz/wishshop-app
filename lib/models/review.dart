import './product.dart';
import './user.dart';

class Review {
  final int id;
  String content;
  num rate;
  List<String> tags;
  String createdAt;
  String updatedAt;
  Product product;
  User user;

  Review({
    this.id,
    this.content,
    this.rate,
    this.tags,
    this.createdAt,
    this.updatedAt,
    this.product,
    this.user,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    List<String> tags = [];
    if (json['tags'] != null) {
      Iterable l = json['tags'] as List;
      tags = l.map((item) => item.toString()).toList();
    }

    return Review(
      id              : json['id'],
      content         : json['content'],
      rate            : json['rate'],
      tags            : tags,
      createdAt       : json['created_at'],
      updatedAt       : json['updated_at'],
      product         : json['product'] != null ? Product.fromJson(json['product']) : null,
      user            : json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }
}
