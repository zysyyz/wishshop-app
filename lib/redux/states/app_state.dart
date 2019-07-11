import './address_state.dart';
import './auth_state.dart';
import './category_state.dart';
import './collection_state.dart';
import './favorite_state.dart';
import './order_state.dart';
import './product_state.dart';
// import './user_state.dart';

class AppState {
  final AddressState addressState;
  final AuthState authState;
  final CategoryState categoryState;
  final CollectionState collectionState;
  final FavoriteState favoriteState;
  final OrderState orderState;
  final ProductState productState;
  // final UserState user;

  AppState({
    this.addressState,
    this.authState,
    this.categoryState,
    this.collectionState,
    this.favoriteState,
    this.orderState,
    this.productState,
    // this.user,
  });

  static AppState fromJson(dynamic json) {
    if (json == null) {
      return AppState(
        addressState: AddressState(),
        authState: AuthState(),
        categoryState: CategoryState(),
        collectionState: CollectionState(),
        favoriteState: FavoriteState(),
        orderState: OrderState(),
        productState: ProductState(),
        // user: UserState(),
      );
    }
    return AppState(
      addressState: AddressState.fromJson(json['addressState']),
      authState: AuthState.fromJson(json['authState']),
      categoryState: CategoryState.fromJson(json['categoryState']),
      collectionState: CollectionState.fromJson(json['collection']),
      favoriteState: FavoriteState.fromJson(json['favoriteState']),
      orderState: OrderState.fromJson(json['orderState']),
      productState: ProductState.fromJson(json['productState']),
      // user: UserState.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'addressState': addressState.toJson(),
      'authState': authState.toJson(),
      'categoryState': categoryState.toJson(),
      'collectionState': collectionState.toJson(),
      'favoriteState': favoriteState.toJson(),
      'productState': productState.toJson(),
      'orderState': orderState.toJson(),
      // 'user': user.toJson(),
    };
  }
}
