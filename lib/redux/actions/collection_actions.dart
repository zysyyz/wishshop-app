import 'dart:async';
import '../../exports.dart';

class GetCollectionListAction {
  final Completer<Result<Collection>> completer = new Completer();
  int page;

  GetCollectionListAction({this.page});
}
class ReceiveCollectionListAction {
  final List<Collection> collections;

  ReceiveCollectionListAction(this.collections);
}

class GetCollectionAction {
  final Completer completer = new Completer();
  final String collectionId;

  GetCollectionAction(this.collectionId);
}
class ReceiveCollectionAction {
  final Completer completer = new Completer();
  final Collection collection;

  ReceiveCollectionAction(this.collection);
}
