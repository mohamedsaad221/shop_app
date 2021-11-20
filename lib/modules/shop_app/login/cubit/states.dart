import 'package:shop_app/models/login/login_model.dart';

abstract class LoginShopStates {}

class LoginShopInitial extends LoginShopStates {}

class LoginShopLoadingState extends LoginShopStates {}

class LoginShopSuccessState extends LoginShopStates {
    final ShopLoginModel loginModel;

  LoginShopSuccessState(this.loginModel);
}

class LoginShopErrorState extends LoginShopStates {
  final error;
  LoginShopErrorState(this.error);
}

class LoginShopPasswordVisibility extends LoginShopStates {}