import 'package:shop_app/models/change_fav_model/change_fav_model.dart';

abstract class SearchStates {}

class ShopSearchSuccessChangeFavoriteDataState extends SearchStates {
  final ChangeFavModel model;


  ShopSearchSuccessChangeFavoriteDataState(this.model);}

class ShopSearchChangeFavoriteDataState extends SearchStates {}

class ShopSearchErrorChangeFavoriteDataState extends SearchStates {}


class ShopSearchLoadingFavoriteDataState extends SearchStates {}

class ShopSearchSuccessFavoriteDataState extends SearchStates {}

class ShopSearchErrorFavoriteDataState extends SearchStates {}

class SearchInitialState extends SearchStates {}

class SearchLoadingState extends SearchStates {}

class SearchSuccessState extends SearchStates {}

class SearchErrorState extends SearchStates {}