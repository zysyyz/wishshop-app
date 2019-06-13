import 'package:redux/redux.dart' as redux;
import '../../exports.dart';
import '../actions/collection_actions.dart';
import '../states/collection_state.dart';

final collectionReducer = redux.combineReducers<CollectionState>([
  redux.TypedReducer<CollectionState, ReceiveCollectionListAction>(_receiveCollectionList),
  redux.TypedReducer<CollectionState, ReceiveCollectionAction>(_receiveCollection),
]);

CollectionState _receiveCollectionList(CollectionState state, ReceiveCollectionListAction action) {
  if (state.listByFilter == null) {
    state.listByFilter = new Map();
  }

  state.listByFilter.update(
    "all",
    (v) => action.collections ?? [],
    ifAbsent: () => action.collections ?? []
  );
  return state;
}

CollectionState _receiveCollection(CollectionState state, ReceiveCollectionAction action) {
  state.mapById = new Map();
  state.mapById.update(
    '${action.collection.id}',
    (v) => action.collection,
    ifAbsent: () => action.collection
  );
  return state;
}

