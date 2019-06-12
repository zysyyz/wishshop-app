class Content {
  final int id;
  int storeId;
  int productId;
  int position;
  String type;
  String content;
  Map<String, dynamic> meta;
  String createdAt;
  String updatedAt;

  Content({
    this.id,
    this.storeId,
    this.productId,
    this.position,
    this.type,
    this.content,
    this.meta,
    this.createdAt,
    this.updatedAt,
  });

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      id              : json['id'],
      storeId         : json['store_id'],
      productId       : json['product_id'],
      position        : json['position'],
      type            : json['type'],
      content         : json['content'],
      meta            : json['meta'],
      createdAt       : json['created_at'],
      updatedAt       : json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() =>
    {
      'id'            : id,
      'store_id'      : storeId,
      'product_id'    : productId,
      'position'      : position,
      'type'          : type,
      'content'       : content,
      'meta'          : meta,
      'created_at'    : createdAt,
      'updated_at'    : updatedAt,
    };
}
