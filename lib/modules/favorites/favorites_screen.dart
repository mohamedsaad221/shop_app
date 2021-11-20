// @dart=2.9

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout/cubit/states.dart';
import 'package:shop_app/models/favorites_model/favorites_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
        listener: (context , state) {},
        builder: (context , state) {
          var cubit = ShopLayoutCubit.get(context);

          return Scaffold(
            body: ConditionalBuilder(
              condition: state is! ShopLoadingFavoriteDataState,
              builder: (context) => ListView.separated(
                itemBuilder: (context, index) => builtProductItem(ShopLayoutCubit.get(context).favoritesModel.data.data[index].product, context),
                separatorBuilder: (context,index) => myDivider(),
                itemCount: ShopLayoutCubit.get(context).favoritesModel.data.data.length,
                physics: BouncingScrollPhysics(),
              ),
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
          );
        },
      )
    );
  }

  Widget builtProductItem(Product model , context, ) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.name),
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
              if (model.discount != 0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  color: Colors.red,
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(fontSize: 10.0, color: Colors.white),
                  ),
                ),
            ],
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(height: 1.5),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      model.price.toString(),
                      style: TextStyle(color: defaultColor),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    if (model.discount != 0)
                      Text(
                        model.oldPrice.toString(),
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopLayoutCubit.get(context).changeFavorites(model.id);
                      },
                      icon: CircleAvatar(
                        radius: 15.0,
                        backgroundColor: ShopLayoutCubit.get(context).favorites[model.id] ? defaultColor : Colors.grey ,
                        child: Icon(
                          Icons.favorite_border,
                          size: 15.0,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
