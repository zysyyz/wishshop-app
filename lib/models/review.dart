class Review {
  final int id;
  String slug;
  String name;
  String logoUrl;
  String imageUrl;
  String description;
  String createdAt;
  String updatedAt;

  Review({
    this.id,
    this.slug,
    this.name,
    this.logoUrl,
    this.imageUrl,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id              : json['id'],
      slug            : json['slug'],
      name            : json['name'],
      logoUrl         : json['logo_url'] ?? 'https://via.placeholder.com/500',
      imageUrl        : json['image_url'] ?? 'https://via.placeholder.com/500',
      createdAt       : json['created_at'],
      updatedAt       : json['updated_at'],
    );
  }
}
