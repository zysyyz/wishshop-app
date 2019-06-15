import 'dart:async';
import '../../exports.dart';

class GetFavoriteListAction {
  final Completer<Result<Favorite>> completer = new Completer();
  int page;

  GetFavoriteListAction({this.page});
}
class ReceiveFavoriteListAction {
  Result<Favorite> result;

  ReceiveFavoriteListAction(this.result);
}

class CreateFavoriteAction {
  final Completer<bool> completer = new Completer();
  final String targetType;
  final int targetId;

  CreateFavoriteAction({
    this.targetType,
    this.targetId,
  });
}
class CreateFavoriteSuccessAction {
  final Favorite favorite;

  CreateFavoriteSuccessAction(this.favorite);
}

class DeleteFavoriteAction {
  final Completer<bool> completer = new Completer();
  final int favoriteId;
  final String targetType;
  final int targetId;

  DeleteFavoriteAction({
    this.favoriteId,
    this.targetType,
    this.targetId,
  });
}
class DeleteFavoriteSuccessAction {
  final int favoriteId;

  DeleteFavoriteSuccessAction(this.favoriteId);
}
