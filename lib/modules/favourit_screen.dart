import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/get_favourite_data.dart';
import 'package:shopapp/shared/AppBloc/Appcubit&&%D9%8DSearchCubit/cubit.dart';
import 'package:shopapp/shared/AppBloc/Appcubit&&%D9%8DSearchCubit/status.dart';
import 'package:shopapp/shared/constance/combonants.dart';
import 'package:shopapp/shared/constance/cons.dart';

import 'home_product_data_screean.dart';

class FavouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<ShopAppcubit>(context)..GetFavData(),
      child: BlocConsumer<ShopAppcubit, ShopStatus>(
        listener: (BuildContext context, state) {},
        builder: (context, state) {
          var cubit = ShopAppcubit.get(context);
          return  ShopAppcubit.get(context).getFavouriteData == null ? const Center(child: CircularProgressIndicator())
              : cubit.getFavouriteData!.data!.data.isEmpty ?  const Center(child: Text('Wishlist is Embty 🙁',
            style: TextStyle(
                fontSize: 20 ,
                color: Colors.grey ,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal
            ),
          )) : ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildFavoriteItem(
                  cubit.getFavouriteData!.data!.data[index], context),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: cubit.getFavouriteData!.data!.data.length);
        },
      ),
    );
  }
}

Widget buildFavoriteItem(FavouriteData model, context) => InkWell(
  onTap: (){
    PushToNextScreen(context, ProductDetails(model.product!.id));
  },
  child:   Padding(

        padding: const EdgeInsets.all(20.0),

        child: SizedBox(

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

                            ShopAppcubit.get(context).changeFavorites(model.product!.id);

                          },

                          icon: const Icon(Icons.delete_forever  ,

                            color: Colors.red,

                            size: 30,

                          ),

                        ),

                      ],

                    ),

                  ],

                ),

              ),

            ],

          ),

        ),

      ),
);
