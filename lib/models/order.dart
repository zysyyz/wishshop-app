import './order_line_item.dart';

class Order {
  final int id;
  int storeId;
  String number;
  String referenceNumber;
  List<OrderLineItem> items;
  num subtotal;
  num total;
  num numberOfItems;
  String createdAt;
  String updatedAt;

  Order({
    this.id,
    this.storeId,
    this.number,
    this.referenceNumber,
    this.items,
    this.subtotal,
    this.total,
    this.numberOfItems,
    this.createdAt,
    this.updatedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    List<OrderLineItem> items = [];

    if (json['items'] != null) {
      Iterable l = json['items'] as List;
      items = l.map((item) => OrderLineItem.fromJson(item)).toList();
    }

    return Order(
      id              : json['id'],
      storeId         : int.parse(json['store_id'].toString()),
      number          : json['number'],
      referenceNumber : json['reference_number'],
      items           : items,
      subtotal        : json['subtotal'],
      total           : json['total'],
      numberOfItems   : json['number_of_items'],
      createdAt       : json['created_at'],
      updatedAt       : json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() =>
    {
      'id'                : id,
      'store_id'          : storeId,
      'number'            : number,
      'reference_number'  : referenceNumber,
      'items'             : items,
      'subtotal'          : subtotal,
      'total'             : total,
      'number_of_items'   : numberOfItems,
      'created_at'        : createdAt,
      'updated_at'        : updatedAt,
    };
}
