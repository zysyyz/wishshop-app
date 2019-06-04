import 'dart:async';
import '../../models/models.dart';

class GetProductListAction {
  final Completer completer = new Completer();
  var categoryId;
  GetProductListAction({this.categoryId});
}
class ReceiveProductListAction {
  var categoryId;
  final List<Product> products;

  ReceiveProductListAction(this.products, {this.categoryId});
}

class GetProductAction {
  final Completer completer = new Completer();
  var productId;

  GetProductAction(this.productId);
}
class ReceiveProductAction {
  final Completer completer = new Completer();
  final Product product;

  ReceiveProductAction(this.product);
}
