import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/cart_screen.dart';
import 'package:shopapp/modules/searchscreen.dart';
import 'package:shopapp/shared/AppBloc/Appcubit&&%D9%8DSearchCubit/cubit.dart';
import 'package:shopapp/shared/AppBloc/Appcubit&&%D9%8DSearchCubit/status.dart';
import 'package:shopapp/shared/constance/combonants.dart';


class ShopAppLayout extends StatelessWidget {
  const ShopAppLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppcubit, ShopStatus>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var cubit = ShopAppcubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 1.0,
            titleSpacing: 10,
            title: Row(
              children: const [
                Image(
                  image: AssetImage('assets/images/image4.png'),
                  width: 40,
                  height: 40,
                ),
                Text(
                  'Salla',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {
                  PushToNextScreen(context, const CartScreen());
                },
                icon: const Icon(Icons.shopping_cart_outlined,
                    color: Colors.black),
              ),
              IconButton(
                onPressed: () {
                  PushToNextScreen(context, SearchScreen());
                },
                icon: const Icon(Icons.search, color: Colors.black),
              ),
            ],
          ),
          bottomNavigationBar: CurvedNavigationBar(
            buttonBackgroundColor: Colors.white,
            height: 60.0,
            color: cubit.color!,
            backgroundColor: Colors.transparent,
            items: cubit.iconData,
            animationDuration: const Duration(milliseconds: 350),
            index: cubit.currentindex,
            onTap: (index) {
              cubit.OnChangeTabs(index);
            },
          ),
          body: cubit.Screens[cubit.currentindex],
        );
      },
    );
  }
}
