import 'package:redux/redux.dart' as redux;
import '../../models/models.dart';
import '../actions/collection_actions.dart';
import '../states/collection_state.dart';

final collectionReducer = redux.combineReducers<CollectionState>([
  redux.TypedReducer<CollectionState, ReceiveCollectionListAction>(_receiveCollectionList),
  redux.TypedReducer<CollectionState, ReceiveCollectionAction>(_receiveCollection),
]);

CollectionState _receiveCollectionList(CollectionState state, ReceiveCollectionListAction action) {
  state.listByFilter = new Map();
  state.listByFilter.putIfAbsent("all", () => action.collections);
  return state;
}

CollectionState _receiveCollection(CollectionState state, ReceiveCollectionAction action) {
  state.mapById = new Map();
  state.mapById.putIfAbsent('${action.collection.id}', () => action.collection);
  state.mapById.putIfAbsent(action.collection.slug, () => action.collection);
  return state;
}

