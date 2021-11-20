// @dart=2.9

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/shop_layout.dart';
import 'package:shop_app/modules/shop_app/login/cubit/cubit.dart';
import 'package:shop_app/modules/shop_app/login/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/shared_pref.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class RegisterScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var phoneController = TextEditingController();

    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (BuildContext context) => RegisterShopCubit(),
        child: BlocConsumer<RegisterShopCubit, RegisterShopStates>(
          listener: (context, state) {
            if(state is RegisterShopSuccessState) {

              if(state.loginModel.status) {

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
                            'Register',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            'Register now to browse our hot offers',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(color: Colors.grey),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          defaultFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'name must be not empty';
                              }
                              return null;
                            },
                            labelText: 'Name',
                            prefixIcon: Icons.person,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          defaultFormField(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'email must be not empty';
                                }
                                return null;
                              },
                              labelText: 'Email Address',
                              prefixIcon: Icons.email,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          defaultFormField(
                              controller: passwordController,
                              type: TextInputType.phone,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'email must be not empty';
                                }
                                return null;
                              },
                              labelText: 'Password',
                              isPassword: RegisterShopCubit.get(context).isPassword,
                              prefixIcon: Icons.lock_outline,
                              suffixIcon: RegisterShopCubit.get(context).suffix,
                              suffixPressed: () => RegisterShopCubit.get(context).changePasswordVisibility()
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          defaultFormField(
                              controller: phoneController,
                              type: TextInputType.phone,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'phone must be not empty';
                                }
                                return null;
                              },
                              labelText: 'phone',
                              prefixIcon: Icons.phone,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          ConditionalBuilder(
                            condition: state is! RegisterShopLoadingState,
                            builder: (context) => defaultTextMaterialButton(
                                function: () {
                                  if(formKey.currentState.validate()){
                                    RegisterShopCubit.get(context).userRegister(
                                      name: nameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        phone: phoneController.text,
                                    );
                                  }
                                },
                                text: 'Register',
                                colorText: Colors.white),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
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
      ),
    );
  }
}
