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
      storeId         : int.parse(json['storeId'].toString()),
      collectionId    : json['collectionId'],
      targetType      : json['targetType'],
      targetId        : json['targetId'],
      position        : json['position'],
      title           : json['title'],
      imageUrl        : json['imageUrl'],
      description     : json['description'],
      createdAt       : json['createdAt'],
      updatedAt       : json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() =>
    {
      'id'            : id,
      'storeId'      : storeId,
      'collectionId' : collectionId,
      'targetType'   : targetType,
      'targetId'     : targetId,
      'position'      : position,
      'title'         : title,
      'imageUrl'     : imageUrl,
      'description'   : description,
      'createdAt'    : createdAt,
      'updatedAt'    : updatedAt,
    };
}
