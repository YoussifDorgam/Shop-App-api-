import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/get_favourite_data.dart';
import 'package:shopapp/shared/AppBloc/Appcubit&&%D9%8DSearchCubit/cubit.dart';
import 'package:shopapp/shared/AppBloc/Appcubit&&%D9%8DSearchCubit/status.dart';
import 'package:shopapp/shared/constance/cons.dart';

class FavouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppcubit, ShopStatus>(
      listener: (BuildContext context, state) {},
      builder: (context, state) {
        var cubit = ShopAppcubit.get(context);
        return ConditionalBuilder(
          condition: state is !ShopLodingGetFavouriteDataStatus   ,
          builder: (BuildContext context) => ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildFavoriteItem(
                  cubit.getFavouriteData!.data!.data[index], context),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: cubit.getFavouriteData!.data!.data.length),
          fallback: (BuildContext context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

Widget buildFavoriteItem(FavouriteData model, context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image(
                  image: NetworkImage(
                    '${model.product!.image}',
                  ),
                  width: 120.0,
                  height: 120.0,
                ),
                if (model.product!.discount != 0)
                  Container(
                    color: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(color: Colors.white, fontSize: 10.0),
                    ),
                  )
              ],
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.product!.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 14.0, color: Colors.black, height: 1.0),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.product!.price}',
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.deepOrange,
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      if (model.product!.discount != 0)
                        Text(
                          '${model.product!.oldPrice}',
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey,
                            height: 1.0,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          print(model.id);
                          ShopAppcubit.get(context)
                              .changeFavorites(model.product!.id);
                        },
                        icon: Icon(
                          ShopAppcubit.get(context)
                                      .favorite[model.product!.id] ==
                                  true
                              ? ShopAppcubit().FavIcon = Icons.favorite
                              : ShopAppcubit().FavIcon = Icons.favorite_border,
                          size: 18,
                        ),
                      ),

                      // IconButton(
                      //   onPressed: () {
                      //     print(model.id);
                      //     ShopAppcubit.get(context).changeFavorites(model.id!);
                      //   },
                      //   icon: Icon(
                      //     ShopAppcubit.get(context).favorite[model.id] == true
                      //         ? ShopAppcubit().FavIcon = Icons.favorite_border
                      //         : ShopAppcubit().FavIcon = Icons. favorite ,
                      //     size: 18,
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
