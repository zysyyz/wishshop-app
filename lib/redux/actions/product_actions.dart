import 'dart:async';
import '../../models/models.dart';

class GetProductListAction {
  final Completer<Result<Product>> completer = new Completer();
  var page;
  var categoryId;
  GetProductListAction({
    this.page,
    this.categoryId,
  });
}
class ReceiveProductListAction {
  var categoryId;
  Result<Product> result;

  ReceiveProductListAction({this.categoryId, this.result});
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
