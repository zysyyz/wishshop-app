import './auth_state.dart';
import './category_state.dart';
import './collection_state.dart';
import './product_state.dart';
// import './user_state.dart';

class AppState {
  final AuthState auth;
  final CategoryState category;
  final CollectionState collection;
  final ProductState productState;
  // final UserState user;

  AppState({
    this.auth,
    this.category,
    this.collection,
    this.productState,
    // this.user,
  });

  static AppState fromJson(dynamic json) {
    if (json == null) {
      return AppState(
        auth: AuthState(),
        category: CategoryState(),
        collection: CollectionState(),
        productState: ProductState(),
        // user: UserState(),
      );
    }
    return AppState(
      auth: AuthState.fromJson(json['auth']),
      category: CategoryState.fromJson(json['category']),
      collection: CollectionState.fromJson(json['collection']),
      productState: ProductState.fromJson(json['productState']),
      // user: UserState.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'auth': auth.toJson(),
      'category': category.toJson(),
      'collection': collection.toJson(),
      'productState': productState.toJson(),
      // 'user': user.toJson(),
    };
  }
}
