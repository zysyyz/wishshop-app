import 'dart:async';
import '../../models/models.dart';

class GetCategoryListAction {
  final Completer completer = new Completer();
}
class GetCategoryListSuccessAction {
  final List<Category> categories;

  GetCategoryListSuccessAction(this.categories);
}
class GetCategoryListFailureAction {}

class GetCategoryAction {
  final Completer completer = new Completer();
  final int categoryId;

  GetCategoryAction(this.categoryId);
}
class GetCategorySuccessAction {
  final Category category;

  GetCategorySuccessAction(this.category);
}
class GetCategoryFailureAction {}
