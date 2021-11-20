import 'package:shop_app/models/login/login_model.dart';

abstract class RegisterShopStates {}

class RegisterShopInitial extends RegisterShopStates {}

class RegisterShopLoadingState extends RegisterShopStates {}

class RegisterShopSuccessState extends RegisterShopStates {
    final ShopLoginModel loginModel;

  RegisterShopSuccessState(this.loginModel);
}

class RegisterShopErrorState extends RegisterShopStates {
  final error;
  RegisterShopErrorState(this.error);
}

class RegisterShopPasswordVisibility extends RegisterShopStates {}