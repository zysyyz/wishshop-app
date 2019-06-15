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
      storeId         : int.parse(json['store_id'].toString()),
      parentId        : json['parent_id'],
      level           : json['level'],
      position        : json['position'],
      slug            : json['slug'],
      name            : json['name'],
      imageUrl        : json['image_url'] ?? 'https://via.placeholder.com/500',
      createdAt       : json['created_at'],
      updatedAt       : json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() =>
    {
      'id'            : id,
      'store_id'      : storeId,
      'parent_id'     : parentId,
      'level'         : level,
      'position'      : position,
      'slug'          : slug,
      'name'          : name,
      'image_url'     : imageUrl,
      'created_at'    : createdAt,
      'updated_at'    : updatedAt,
    };
}
