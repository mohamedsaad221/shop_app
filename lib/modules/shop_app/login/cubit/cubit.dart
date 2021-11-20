// @dart=2.9

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/cubit/states.dart';
import 'package:shop_app/models/change_fav_model/change_fav_model.dart';
import 'package:shop_app/models/login/login_model.dart';
import 'package:shop_app/modules/shop_app/login/cubit/states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio.dart';

class LoginShopCubit extends Cubit<LoginShopStates> {
  LoginShopCubit() : super(LoginShopInitial());

  static LoginShopCubit get(context) => BlocProvider.of(context);

  ShopLoginModel loginModel;

  void userLogin({
    @required String email,
    @required String password,
}) {

    emit(LoginShopLoadingState());

    DioHelper.postData(
        url: LOGIN,
        data: {
          'email': email,
          'password': password,
        }
    ).then((value) {
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      print(loginModel.data);
      print(loginModel.message);
      emit(LoginShopSuccessState(loginModel));
    }).catchError((error){
      print(error.toString());
      emit(LoginShopErrorState(error.toString()));
    });
  }

  bool isPassword = true;
  IconData suffix = Icons.remove_red_eye_outlined;


 void changePasswordVisibility() {
      isPassword = !isPassword;

      suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_rounded;

      emit(LoginShopPasswordVisibility());
  }

}
