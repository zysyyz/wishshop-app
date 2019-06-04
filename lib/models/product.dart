import './content.dart';

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
  String sku;
  num price;
  num originalPrice;
  List<Content> contents;
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
    this.sku,
    this.price,
    this.originalPrice,
    this.contents,
    this.createdAt,
    this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    List<Content> contents;
    if (json['contents'] != null) {
      Iterable l = json['contents'] as List;
      contents = l.map((item) => Content.fromJson(item)).toList();
    }

    return Product(
      id                : json['id'],
      storeId           : json['store_id'],
      brandId           : json['brand_id'],
      brandName         : json['brand_name'],
      slug              : json['slug'],
      name              : json['name'],
      imageUrl          : json['image_url'] ?? 'https://via.placeholder.com/500',
      summary           : json['summary'],
      description       : json['description'],
      sku               : json['sku'],
      price             : json['price'],
      originalPrice     : json['original_price'],
      contents          : contents,
      createdAt         : json['created_at'],
      updatedAt         : json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() =>
    {
      'id'              : id,
      'store_id'        : storeId,
      'brand_id'        : brandId,
      'brand_name'      : brandName,
      'slug'            : slug,
      'name'            : name,
      'image_url'       : imageUrl,
      'summary'         : summary,
      'description'     : description,
      'sku'             : sku,
      'price'           : price,
      'original_price'  : originalPrice,
      'contents'        : contents,
      'created_at'      : createdAt,
      'updated_at'      : updatedAt,
    };
}
