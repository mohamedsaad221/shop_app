import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colors.dart';

ThemeData themeDataLight = ThemeData(
    primarySwatch: defaultColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
        backwardsCompatibility: false,
        color: Colors.white,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 25.0,
            fontWeight: FontWeight.bold
        ),
        iconTheme: IconThemeData(
            color: Colors.black
        )
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: defaultColor,
        elevation: 20.0
    ),
    textTheme: TextTheme(
        bodyText1: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
            color: Colors.black
        )
    )
);
ThemeData themeDataDark = ThemeData(
    appBarTheme: AppBarTheme(
        backwardsCompatibility: false,
        color: HexColor('333739'),
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor('333739'),
        ),
        titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.bold
        ),
        iconTheme: IconThemeData(
            color: Colors.white
        )
    ),
    scaffoldBackgroundColor: HexColor('333739'),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.deepOrange,
        backgroundColor: HexColor('333739'),
        unselectedItemColor: Colors.white,
        elevation: 20.0
    ),
    textTheme: TextTheme(
        bodyText1: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
            color: Colors.white
        )
    )
);