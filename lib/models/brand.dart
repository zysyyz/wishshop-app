class Brand {
  final int id;
  String slug;
  String name;
  String logoUrl;
  String imageUrl;
  String description;
  String createdAt;
  String updatedAt;

  Brand({
    this.id,
    this.slug,
    this.name,
    this.logoUrl,
    this.imageUrl,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id              : json['id'],
      slug            : json['slug'],
      name            : json['name'],
      logoUrl         : json['logoUrl'],
      imageUrl        : json['imageUrl'],
      createdAt       : json['createdAt'],
      updatedAt       : json['updatedAt'],
    );
  }
}
