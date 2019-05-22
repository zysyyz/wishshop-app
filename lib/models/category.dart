class Category {
  final int id;
  int parentId;
  String slug;
  int position;
  String name;
  String imageUrl;
  String description;
  String createdAt;
  String updatedAt;

  Category({
    this.id,
    this.parentId,
    this.slug,
    this.position,
    this.name,
    this.imageUrl,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id              : json['id'],
      parentId        : json['parent_id'],
      slug            : json['slug'],
      position        : json['position'],
      name            : json['name'],
      imageUrl        : json['image_url'] ?? 'https://via.placeholder.com/500',
      createdAt       : json['created_at'],
      updatedAt       : json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() =>
    {
      'id'            : id,
      'parent_id'     : parentId,
      'slug'          : slug,
      'position'      : position,
      'name'          : name,
      'image_url'     : imageUrl,
      'created_at'    : createdAt,
      'updated_at'    : updatedAt,
    };
}
