class Store {
  final int id;
  String slug;
  String name;
  String imageUrl;
  String description;
  String createdAt;
  String updatedAt;

  Store({
    this.id,
    this.slug,
    this.name,
    this.imageUrl,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id              : json['id'],
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
      'slug'          : slug,
      'name'          : name,
      'image_url'     : imageUrl,
      'created_at'    : createdAt,
      'updated_at'    : updatedAt,
    };
}
