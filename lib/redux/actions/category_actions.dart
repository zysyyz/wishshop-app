import 'dart:async';
import '../../models/models.dart';

class GetCategoryListAction {
  final Completer completer = new Completer();
}
class ReceiveCategoryListAction {
  final List<Category> categories;

  ReceiveCategoryListAction(this.categories);
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
