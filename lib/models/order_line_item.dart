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
      storeId             : int.parse(json['store_id'].toString()),
      label               : json['label'],
      price               : json['price'],
      originalPrice       : json['original_price'],
      quantity            : json['quantity'],
      subtotal            : json['subtotal'],
      total               : json['total'],
      createdAt           : json['created_at'],
      updatedAt           : json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() =>
    {
      'id'                : id,
      'store_id'          : storeId,
      'price'             : price,
      'original_price'    : originalPrice,
      'quantity'          : quantity,
      'subtotal'          : subtotal,
      'total'             : total,
      'created_at'        : createdAt,
      'updated_at'        : updatedAt,
    };
}
