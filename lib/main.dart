// @dart=2.9

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/layout/shop_layout/cubit/cubit.dart';
import 'package:shop_app/modules/shop_app/login/login_shop_screen.dart';
import 'package:shop_app/modules/shop_app/onboarding/onboarding_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/shared_pref.dart';
import 'package:shop_app/shared/network/remote/dio.dart';
import 'package:shop_app/shared/styles/styles.dart';

import 'layout/shop_layout/shop_layout.dart';
import 'shared/styles/colors.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();

  await CacheHelper.init();

  Widget widget;

  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  print(token);

  if(onBoarding != null) {
    if(token != null) widget = ShopLayout();
    else widget = LoginShopScreen();
  } else {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {

  final Widget startWidget;

  MyApp(this.startWidget);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLayoutCubit()..getHomeData()..getCategoryData()..getFavorites()..getSettings(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeDataLight,
        darkTheme: themeDataLight,
        home: startWidget ,
      ),
    );
  }
}