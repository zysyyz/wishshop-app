import 'dart:async';
import '../../models/models.dart';

class GetCategoryListAction {
  final Completer<Result<Category>> completer = new Completer();
}
class ReceiveCategoryListAction {
  final Result<Category> result;

  ReceiveCategoryListAction(this.result);
}

class GetCategoryAction {
  final Completer completer = new Completer();
  final int categoryId;

  GetCategoryAction(this.categoryId);
}
class ReceiveCategoryAction {
  final Completer completer = new Completer();
  final Category category;

  ReceiveCategoryAction(this.category);
}
