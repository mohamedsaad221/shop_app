import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout/cubit/states.dart';
import 'package:shop_app/models/categories/categories_model.dart';
import 'package:shop_app/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context , state) {},
      builder: (context , state) {
        var cubit = ShopLayoutCubit.get(context);

        return Scaffold(
          body: ListView.separated(
              itemBuilder: (context, index) => buildCatItem(cubit.categoryModel.data.data[index]),
              separatorBuilder: (context,index) => myDivider(),
              itemCount: cubit.categoryModel.data.data.length,
            physics: BouncingScrollPhysics(),
          ),
        );
      },
    );
  }

  Widget buildCatItem(DataModel model) => Row(
    children: [
      Image(
        image: NetworkImage(
            model.image
        ),
        width: 100.0,
        height: 100.0,
        fit: BoxFit.cover,
      ),
      SizedBox(
        width: 15.0,
      ),
      Text(
        model.name,
        style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w800
        ),
      ),
      Spacer(),
      Icon(
          Icons.arrow_forward_ios
      ),
    ],
  );
}
