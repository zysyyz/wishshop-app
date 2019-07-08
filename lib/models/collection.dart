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
      storeId         : int.parse(json['storeId'].toString()),
      slug            : json['slug'],
      name            : json['name'],
      imageUrl        : json['imageUrl'],
      description     : json['description'],
      viewBy          : json['viewBy'],
      status          : json['status'],
      createdAt       : json['createdAt'],
      updatedAt       : json['updatedAt'],
      items           : items,
    );
  }

  Map<String, dynamic> toJson() =>
    {
      'id'            : id,
      'storeId'      : storeId,
      'slug'          : slug,
      'name'          : name,
      'imageUrl'     : imageUrl,
      'description'   : description,
      'viewBy'       : viewBy,
      'status'        : status,
      'createdAt'    : createdAt,
      'updatedAt'    : updatedAt,
      'items'         : items,
    };
}
