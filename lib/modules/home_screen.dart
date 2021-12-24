import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/shop_category_model.dart';
import 'package:shopapp/models/shopappmodel.dart';
import 'package:shopapp/modules/produc_category_data_screen.dart';
import 'package:shopapp/shared/AppBloc/Appcubit&&%D9%8DSearchCubit/cubit.dart';
import 'package:shopapp/shared/AppBloc/Appcubit&&%D9%8DSearchCubit/status.dart';
import 'package:shopapp/shared/constance/combonants.dart';

import 'home_product_data_screean.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppcubit, ShopStatus>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var cubit = ShopAppcubit.get(context);
        return ConditionalBuilder(
            condition:
                cubit.shopHomeModel != null && cubit.categoryModel != null,
            builder: (context) =>
                HomeData(cubit.shopHomeModel, cubit.categoryModel, context),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()));
      },
    );
  }
}

Widget HomeData(ShopHomeModel? model, CategoryModel? categoryModel, context) => SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: model!.data!.banners
                  .map((e) => Image.network(
                        '${e.image}',
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                viewportFraction: 1.0,
                enableInfiniteScroll: true,
                autoPlayInterval: const Duration(seconds: 4),
                autoPlayAnimationDuration: const Duration(seconds: 3),
                scrollDirection: Axis.horizontal,
                autoPlayCurve: Curves.fastLinearToSlowEaseIn,
              )),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Categories',
              style: TextStyle(
                fontSize: 28.0,
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          SizedBox(
            height: 100.0,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) =>
                  BuildCategoriesItm(categoryModel!.data!.data[index], context),
              separatorBuilder: (context, index) => const SizedBox(
                width: 10,
              ),
              itemCount: categoryModel!.data!.data.length,
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Products',
              style: TextStyle(
                fontSize: 28.0,
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              childAspectRatio: 1 / 1.65,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              children: List.generate(
                  model.data!.products.length,
                  (index) => InkWell(
                      onTap: () {
                        PushToNextScreen(context,
                            ProductDetails(model.data!.products[index].id));
                      },
                      child: HomeProductsItems(
                          model.data!.products[index], context))),
            ),
          ),
        ],
      ),
    );

Widget BuildCategoriesItm(Data data, context) => InkWell(
      onTap: () {
        ShopAppcubit.get(context).getCategoriesDetailData(data.id);
        PushToNextScreen(context, CategoryProductsScreen(data.name));
      },
      child: Padding(
        padding: const EdgeInsetsDirectional.only(start: 20.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Image(
                  image: NetworkImage('${data.image}'),
                  fit: BoxFit.cover,
                  width: 100.0,
                  height: 100.0,
                ),
              ),
              Container(
                width: 100.0,
                color: Colors.black.withOpacity(
                  .8,
                ),
                child: Text(
                  '${data.name}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

Widget HomeProductsItems(ProductsData model, context) => Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image(
                image: NetworkImage('${model.image}'),
                width: double.infinity,
                height: 200.0,
              ),
              if (model.discount != 0)
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
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 14.0, color: Colors.black, height: 1.0),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      '${model.price}\$',
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.deepOrange,
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.old_price}',
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                          height: 1.0,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        ShopAppcubit.get(context).changeFavorites(model.id);
                        print(model.id);
                      },
                      child: Icon(
                        ShopAppcubit.get(context).favorite[model.id] == true
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: 25,
                        color:
                            ShopAppcubit.get(context).favorite[model.id] == true
                                ? Colors.deepOrange
                                : Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
