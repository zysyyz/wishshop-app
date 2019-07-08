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
      imageUrl        : json['imageUrl'],
      createdAt       : json['createdAt'],
      updatedAt       : json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() =>
    {
      'id'            : id,
      'slug'          : slug,
      'name'          : name,
      'imageUrl'     : imageUrl,
      'createdAt'    : createdAt,
      'updatedAt'    : updatedAt,
    };
}
