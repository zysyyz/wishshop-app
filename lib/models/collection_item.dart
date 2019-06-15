class CollectionItem {
  final int id;
  int storeId;
  int collectionId;
  String targetType;
  String targetId;
  int position;
  String title;
  String imageUrl;
  String description;
  String createdAt;
  String updatedAt;

  CollectionItem({
    this.id,
    this.storeId,
    this.collectionId,
    this.targetType,
    this.targetId,
    this.position,
    this.title,
    this.imageUrl,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory CollectionItem.fromJson(Map<String, dynamic> json) {
    return CollectionItem(
      id              : json['id'],
      storeId         : int.parse(json['store_id'].toString()),
      collectionId    : json['collection_id'],
      targetType      : json['target_type'],
      targetId        : json['target_id'],
      position        : json['position'],
      title           : json['title'],
      imageUrl        : json['image_url'] ?? 'https://via.placeholder.com/500',
      description     : json['description'],
      createdAt       : json['created_at'],
      updatedAt       : json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() =>
    {
      'id'            : id,
      'store_id'      : storeId,
      'collection_id' : collectionId,
      'target_type'   : targetType,
      'target_id'     : targetId,
      'position'      : position,
      'title'         : title,
      'image_url'     : imageUrl,
      'description'   : description,
      'created_at'    : createdAt,
      'updated_at'    : updatedAt,
    };
}
