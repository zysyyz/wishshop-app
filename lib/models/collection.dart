import 'package:wishshop_app/models/collection_item.dart';

class Collection {
  final int id;
  int storeId;
  String slug;
  String name;
  String imageUrl;
  String description;
  String viewBy;
  String status;
  String createdAt;
  String updatedAt;
  List<CollectionItem> items;

  Collection({
    this.id,
    this.storeId,
    this.slug,
    this.name,
    this.imageUrl,
    this.description,
    this.viewBy,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.items,
  });

  factory Collection.fromJson(Map<String, dynamic> json) {
    Iterable l = json['items'] as List;
      List<CollectionItem> items = l.map((item) => CollectionItem.fromJson(item)).toList();
    return Collection(
      id              : json['id'],
      storeId         : int.parse(json['store_id'].toString()),
      slug            : json['slug'],
      name            : json['name'],
      imageUrl        : json['image_url'],
      description     : json['description'],
      viewBy          : json['view_by'],
      status          : json['status'],
      createdAt       : json['created_at'],
      updatedAt       : json['updated_at'],
      items           : items,
    );
  }

  Map<String, dynamic> toJson() =>
    {
      'id'            : id,
      'store_id'      : storeId,
      'slug'          : slug,
      'name'          : name,
      'image_url'     : imageUrl,
      'description'   : description,
      'view_by'       : viewBy,
      'status'        : status,
      'created_at'    : createdAt,
      'updated_at'    : updatedAt,
      'items'         : items,
    };
}
