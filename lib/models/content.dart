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
      storeId         : int.parse(json['storeId'].toString()),
      productId       : json['productId'],
      position        : json['position'],
      type            : json['type'],
      content         : json['content'],
      meta            : json['meta'],
      createdAt       : json['createdAt'],
      updatedAt       : json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() =>
    {
      'id'            : id,
      'storeId'      : storeId,
      'productId'    : productId,
      'position'      : position,
      'type'          : type,
      'content'       : content,
      'meta'          : meta,
      'createdAt'    : createdAt,
      'updatedAt'    : updatedAt,
    };
}
