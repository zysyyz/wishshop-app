class Category {
  final int id;
  int storeId;
  int parentId;
  int level;
  int position;
  String slug;
  String name;
  String imageUrl;
  String description;
  String createdAt;
  String updatedAt;

  Category({
    this.id,
    this.storeId,
    this.parentId,
    this.level,
    this.position,
    this.slug,
    this.name,
    this.imageUrl,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id              : json['id'],
      storeId         : int.parse(json['storeId'].toString()),
      parentId        : json['parentId'],
      level           : json['level'],
      position        : json['position'],
      slug            : json['slug'],
      name            : json['name'],
      imageUrl        : json['imageUrl'],
      createdAt       : json['createdAt'],
      updatedAt       : json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() =>
    {
      'id'            : id,
      'storeId'      : storeId,
      'parentId'     : parentId,
      'level'         : level,
      'position'      : position,
      'slug'          : slug,
      'name'          : name,
      'imageUrl'     : imageUrl,
      'createdAt'    : createdAt,
      'updatedAt'    : updatedAt,
    };
}
