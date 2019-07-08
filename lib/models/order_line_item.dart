class OrderLineItem {
  final int id;
  int storeId;
  String label;
  num price;
  num originalPrice;
  num quantity;
  num subtotal;
  num total;
  String createdAt;
  String updatedAt;

  OrderLineItem({
    this.id,
    this.storeId,
    this.label,
    this.price,
    this.originalPrice,
    this.quantity,
    this.subtotal,
    this.total,
    this.createdAt,
    this.updatedAt,
  });

  factory OrderLineItem.fromJson(Map<String, dynamic> json) {
    return OrderLineItem(
      id                  : json['id'],
      storeId             : int.parse(json['storeId'].toString()),
      label               : json['label'],
      price               : json['price'],
      originalPrice       : json['originalPrice'],
      quantity            : json['quantity'],
      subtotal            : json['subtotal'],
      total               : json['total'],
      createdAt           : json['createdAt'],
      updatedAt           : json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() =>
    {
      'id'                : id,
      'storeId'          : storeId,
      'price'             : price,
      'originalPrice'    : originalPrice,
      'quantity'          : quantity,
      'subtotal'          : subtotal,
      'total'             : total,
      'createdAt'        : createdAt,
      'updatedAt'        : updatedAt,
    };
}
