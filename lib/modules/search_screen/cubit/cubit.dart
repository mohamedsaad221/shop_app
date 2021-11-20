// @dart=2.9

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/change_fav_model/change_fav_model.dart';
import 'package:shop_app/models/favorites_model/favorites_model.dart';
import 'package:shop_app/models/search_model/serach_model.dart';
import 'package:shop_app/modules/search_screen/cubit/states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);



  SearchModel searchModel;

  void getSearch(String text) {
    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {'text': text},
    ).then((value)  {
      emit(SearchLoadingState());

      searchModel = SearchModel.fromJson(value.data);
      print(searchModel.data.data.length);

      emit(SearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }

  ChangeFavModel changeFav;
  Map<int, bool> favorites = {};

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

      emit(ShopSearchChangeFavoriteDataState());

      changeFav = ChangeFavModel.fromJson(value.data);
      print('product: ${value.data}');

      if(!changeFav.status) {
        favorites[productId] = !favorites[productId];
      } else {
        getFavorites();
      }

      emit(ShopSearchSuccessChangeFavoriteDataState(changeFav));

    }).catchError((error) {

      favorites[productId] = !favorites[productId];

      emit(ShopSearchErrorChangeFavoriteDataState());
    });
  }

  FavoritesModel favoritesModel;

  void getFavorites() {
    DioHelper.getData(
        url: FAVORITES,
        token: token
    ).then((value) {

      emit(ShopSearchLoadingFavoriteDataState());

      favoritesModel = FavoritesModel.fromJson(value.data);

      emit(ShopSearchSuccessFavoriteDataState());

    }).catchError((error) {
      emit(ShopSearchErrorFavoriteDataState());
    });
  }
}
