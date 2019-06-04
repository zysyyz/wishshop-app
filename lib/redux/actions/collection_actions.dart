import 'dart:async';
import '../../models/models.dart';

class GetCollectionListAction {
  final Completer completer = new Completer();
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
