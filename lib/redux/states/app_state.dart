import './address_state.dart';
import './auth_state.dart';
import './category_state.dart';
import './collection_state.dart';
import './favorite_state.dart';
import './order_state.dart';
import './product_state.dart';
// import './user_state.dart';

class AppState {
  final AddressState address;
  final AuthState auth;
  final CategoryState category;
  final CollectionState collectionState;
  final FavoriteState favoriteState;
  final OrderState orderState;
  final ProductState productState;
  // final UserState user;

  AppState({
    this.address,
    this.auth,
    this.category,
    this.collectionState,
    this.favoriteState,
    this.orderState,
    this.productState,
    // this.user,
  });

  static AppState fromJson(dynamic json) {
    if (json == null) {
      return AppState(
        address: AddressState(),
        auth: AuthState(),
        category: CategoryState(),
        collectionState: CollectionState(),
        favoriteState: FavoriteState(),
        orderState: OrderState(),
        productState: ProductState(),
        // user: UserState(),
      );
    }
    return AppState(
      address: AddressState.fromJson(json['addressState']),
      auth: AuthState.fromJson(json['auth']),
      category: CategoryState.fromJson(json['category']),
      collectionState: CollectionState.fromJson(json['collection']),
      favoriteState: FavoriteState.fromJson(json['favoriteState']),
      orderState: OrderState.fromJson(json['orderState']),
      productState: ProductState.fromJson(json['productState']),
      // user: UserState.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'auth': auth.toJson(),
      'category': category.toJson(),
      'collectionState': collectionState.toJson(),
      'productState': productState.toJson(),
      'orderState': orderState.toJson(),
      'address': address.toJson(),
      // 'user': user.toJson(),
    };
  }
}
