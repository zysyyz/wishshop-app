import './content.dart';
import './modifier.dart';

class Product {
  final int id;
  int storeId;
  int brandId;
  String brandName;
  String slug;
  int position;
  String name;
  String imageUrl;
  String summary;
  String description;
  List<String> tags;
  String sku;
  num price;
  num originalPrice;
  List<Content> contents;
  List<Modifier> modifiers;
  int favoriteId;
  String favoritedAt;
  String createdAt;
  String updatedAt;

  Product({
    this.id,
    this.storeId,
    this.brandId,
    this.brandName,
    this.slug,
    this.name,
    this.imageUrl,
    this.summary,
    this.description,
    this.tags,
    this.sku,
    this.price,
    this.originalPrice,
    this.contents,
    this.modifiers,
    this.favoriteId,
    this.favoritedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    List<String> tags = [];
    List<Content> contents = [];
    List<Modifier> modifiers = [];

    if (json['tags'] != null) {
      Iterable l = json['tags'] as List;
      tags = l.map((item) => item.toString()).toList();
    }
    if (json['contents'] != null) {
      Iterable l = json['contents'] as List;
      contents = l.map((item) => Content.fromJson(item)).toList();
    }
    if (json['modifiers'] != null) {
      Iterable l = json['modifiers'] as List;
      modifiers = l.map((item) => Modifier.fromJson(item)).toList();
    }

    return Product(
      id                : json['id'],
      storeId           : int.parse(json['storeId'].toString()),
      brandId           : json['brandId'],
      brandName         : json['brandName'],
      slug              : json['slug'],
      name              : json['name'],
      imageUrl          : json['imageUrl'],
      summary           : json['summary'],
      description       : json['description'],
      tags              : tags,
      sku               : json['sku'],
      price             : json['price'],
      originalPrice     : json['originalPrice'],
      contents          : contents,
      modifiers         : modifiers,
      favoriteId        : json['favoriteId'],
      favoritedAt       : json['favoritedAt'],
      createdAt         : json['createdAt'],
      updatedAt         : json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() =>
    {
      'id'              : id,
      'storeId'        : storeId,
      'brandId'        : brandId,
      'brandName'      : brandName,
      'slug'            : slug,
      'name'            : name,
      'imageUrl'       : imageUrl,
      'summary'         : summary,
      'description'     : description,
      'tags'            : tags,
      'sku'             : sku,
      'price'           : price,
      'originalPrice'  : originalPrice,
      'contents'        : contents,
      'modifiers'       : modifiers,
      'favoriteId'     : favoriteId,
      'favoritedAt'    : favoritedAt,
      'createdAt'      : createdAt,
      'updatedAt'      : updatedAt,
    };
}
