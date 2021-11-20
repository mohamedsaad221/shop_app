// @dart=2.9

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/shop_layout/shop_layout.dart';
import 'package:shop_app/modules/shop_app/login/cubit/cubit.dart';
import 'package:shop_app/modules/shop_app/login/cubit/states.dart';
import 'package:shop_app/modules/shop_app/login/register/register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/shared_pref.dart';


// ignore: must_be_immutable
class LoginShopScreen extends StatelessWidget {
  var mailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginShopCubit(),
      child: BlocConsumer<LoginShopCubit, LoginShopStates>(
        listener: (context, state) {
          if(state is LoginShopSuccessState) {

            if(state.loginModel.status) {
              print(state.loginModel.message);
              print(state.loginModel.data.token);

              CacheHelper.saveData(key: 'token', value: state.loginModel.data.token).then((value) {

                token = state.loginModel.data.token;

                navigateAndFinish(context, ShopLayout());
              });
              
            } else {
              print(state.loginModel.message);

              showToast(text: state.loginModel.message, state: ShowToastColor.ERROR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'login now to browse our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: mailController,
                          type: TextInputType.emailAddress,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'email must be not empty';
                            }
                            return null;
                          },
                          labelText: 'Email Address',
                          prefixIcon: Icons.mail_outline,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                            controller: passwordController,
                            type: TextInputType.emailAddress,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'password must be not empty';
                              }
                              return null;
                            },
                            labelText: 'Password',
                            isPassword: LoginShopCubit.get(context).isPassword,
                            onSubmit: (value) {
                              if(formKey.currentState.validate()){
                                LoginShopCubit.get(context).userLogin(
                                    email: mailController.text,
                                    password: passwordController.text);
                              }
                            },
                            prefixIcon: Icons.lock_outline,
                            suffixIcon: LoginShopCubit.get(context).suffix,
                          suffixPressed: () => LoginShopCubit.get(context).changePasswordVisibility()
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoginShopErrorState,
                          builder: (context) => defaultTextMaterialButton(
                              function: () {
                                if(formKey.currentState.validate()){
                                  LoginShopCubit.get(context).userLogin(
                                      email: mailController.text,
                                      password: passwordController.text);
                                }
                              },
                              text: 'login',
                              colorText: Colors.white),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                            ),
                            defaultTextButton(
                                function: () {
                                  navigateTo(context, RegisterScreen());
                                },
                                text: 'Register'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
