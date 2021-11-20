// @dart=2.9


import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/cubit/states.dart';
import 'package:shop_app/models/categories/categories_model.dart';
import 'package:shop_app/models/change_fav_model/change_fav_model.dart';
import 'package:shop_app/models/favorites_model/favorites_model.dart';
import 'package:shop_app/models/home/home_model.dart';
import 'package:shop_app/models/login/login_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio.dart';

class ShopLayoutCubit extends Cubit<ShopLayoutStates> {
  ShopLayoutCubit() : super(ShopLayoutInitState());

  static ShopLayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen()
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(ShopLayoutChangeButtonNavState());
  }

 HomeModel homeModel;
  Map<int , bool> favorites = {};

  void getHomeData() {

    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {

      homeModel = HomeModel.fromJson(value.data);
      //print(homeModel.data.banners[0].image);

      homeModel.data.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorites
        });
      });

      //print(favorites.toString());

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
   });
  }

  CategoriesModel categoryModel;

  void getCategoryData() {

    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
      url: GET_CATEGORIES,
    ).then((value) {

      categoryModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesDataState());
    });
  }

  ChangeFavModel changeFav;

  void changeFavorites(int productId) {
    DioHelper.postData(
        url: FAVORITES,
        token: token,
        data: {
          'product_id': productId,
        }
    ).then((value)
    {
      //print('token: $token');

      favorites[productId] = !favorites[productId];
      
      emit(ShopChangeFavoriteDataState());

      changeFav = ChangeFavModel.fromJson(value.data);
      print('product: ${value.data}');

      if(!changeFav.status) {
        favorites[productId] = !favorites[productId];
      } else {
        getFavorites();
      }

      emit(ShopSuccessChangeFavoriteDataState(changeFav));

    }).catchError((error) {

      favorites[productId] = !favorites[productId];

      emit(ShopErrorChangeFavoriteDataState());
    });
  }

  FavoritesModel favoritesModel;

  void getFavorites() {
    DioHelper.getData(
        url: FAVORITES,
      token: token
    ).then((value) {

      emit(ShopLoadingFavoriteDataState());

      favoritesModel = FavoritesModel.fromJson(value.data);

      emit(ShopSuccessFavoriteDataState());

    }).catchError((error) {
      emit(ShopErrorFavoriteDataState());
    });
  }


  ShopLoginModel userData;

  void getSettings() {
    DioHelper.getData(
        url: PROFILE,
        token: token
    ).then((value) {

      emit(ShopLoadingSettingsDataState());

      userData = ShopLoginModel.fromJson(value.data);
      print(userData);
      emit(ShopSuccessSettingsDataState());

    }).catchError((error) {
      emit(ShopErrorSettingsDataState());
    });
  }

  void updateUser({
    @required String name,
    @required String email,
    @required String phone,
  }) {
    DioHelper.putData(
        url: UPDATE_PROFILE,
        token: token,
      data: {
          'name': name,
          'email': email,
          'phone': phone,
      }
    ).then((value) {

      emit(ShopLoadingUpdateUserState());

      userData = ShopLoginModel.fromJson(value.data);
      print(userData);
      emit(ShopSuccessUpdateUserState());

    }).catchError((error) {
      emit(ShopErrorUpdateUserState());
    });
  }
}
