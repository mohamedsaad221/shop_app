// @dart=2.9

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: ShopLayoutCubit.get(context).userData != null,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var model = ShopLayoutCubit.get(context);

            nameController.text = model.userData.data.name;
            emailController.text = model.userData.data.email;
            phoneController.text = model.userData.data.phone;

            return Form(
              key: formKey,
              child: Column(
                children: [
                  if(state is ShopLoadingUpdateUserState)
                  LinearProgressIndicator(),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                    controller: nameController,
                    type: TextInputType.text,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'name must not be empty';
                      }
                      return null;
                    },
                    labelText: 'name',
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
                        return 'email must not be empty';
                      }
                      return null;
                    },
                    labelText: 'email',
                    prefixIcon: Icons.email,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'phone must not be empty';
                      }
                      return null;
                    },
                    labelText: 'phone',
                    prefixIcon: Icons.phone,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultTextMaterialButton(
                      function: () {
                        if (formKey.currentState.validate()) {
                          ShopLayoutCubit.get(context).updateUser(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                          );
                        }
                      },
                      text: 'Update',
                      colorText: Colors.white),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultTextMaterialButton(
                      function: () {
                        signOut(context);
                        ShopLayoutCubit.get(context).currentIndex = 0;
                      },
                      text: 'Sign Out',
                      colorText: Colors.white),
                ],
              ),
            );
          },
        ),
      ),
      fallback: (context) => Center(child: CircularProgressIndicator()),
    );
  }
}
