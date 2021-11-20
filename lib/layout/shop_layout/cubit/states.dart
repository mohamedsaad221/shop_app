import 'package:shop_app/models/change_fav_model/change_fav_model.dart';

abstract class ShopLayoutStates {}

class ShopLayoutInitState extends ShopLayoutStates {}

class ShopLayoutChangeButtonNavState extends ShopLayoutStates {}

class ShopLoadingHomeDataState extends ShopLayoutStates {}

class ShopSuccessHomeDataState extends ShopLayoutStates {}

class ShopErrorHomeDataState extends ShopLayoutStates {}

class ShopSuccessCategoriesDataState extends ShopLayoutStates {}

class ShopErrorCategoriesDataState extends ShopLayoutStates {}

class ShopSuccessChangeFavoriteDataState extends ShopLayoutStates {
  final ChangeFavModel model;


  ShopSuccessChangeFavoriteDataState(this.model);}

class ShopChangeFavoriteDataState extends ShopLayoutStates {}

class ShopErrorChangeFavoriteDataState extends ShopLayoutStates {}


class ShopLoadingFavoriteDataState extends ShopLayoutStates {}

class ShopSuccessFavoriteDataState extends ShopLayoutStates {}

class ShopErrorFavoriteDataState extends ShopLayoutStates {}

class ShopLoadingSettingsDataState extends ShopLayoutStates {}

class ShopSuccessSettingsDataState extends ShopLayoutStates {}

class ShopErrorSettingsDataState extends ShopLayoutStates {}

class ShopLoadingUpdateUserState extends ShopLayoutStates {}

class ShopSuccessUpdateUserState extends ShopLayoutStates {}

class ShopErrorUpdateUserState extends ShopLayoutStates {}