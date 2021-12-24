import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/profile_screen.dart';
import 'package:shopapp/shared/AppBloc/Appcubit&&%D9%8DSearchCubit/cubit.dart';
import 'package:shopapp/shared/AppBloc/Appcubit&&%D9%8DSearchCubit/status.dart';
import 'package:shopapp/shared/constance/combonants.dart';

import 'cart_screen.dart';
import 'contact_screen.dart';
import 'faqs_screen.dart';
import 'order_screen.dart';

class SettingScreen extends StatefulWidget {
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  var Formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool value = false;
    return BlocProvider.value(
      value: BlocProvider.of<ShopAppcubit>(context)..getShopprofaileData(),
      child: BlocConsumer<ShopAppcubit, ShopStatus>(
        listener: (BuildContext context, state) {
          if (state is ShopSuccessUpdateUserStatus) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Updated Succesfully"),
              backgroundColor: Colors.green,
              duration: Duration(milliseconds: 350),
            ));
          }
        },
        builder: (BuildContext context, Object? state) {
          var cubit = ShopAppcubit.get(context);
          return ShopAppcubit.get(context).UserModej == null
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          'Hi ${cubit.UserModej!.data!.name}',
                          style: const TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          '${cubit.UserModej!.data!.email}',
                          style: const TextStyle(
                              fontSize: 15.0, color: Colors.grey),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                          height: 50,
                          color: Colors.grey[300],
                          width: double.infinity,
                          padding: const EdgeInsets.all(15),
                          child: const Text(
                            'MY ACCOUNT',
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          )),
                      BulidProfileItem(
                          Icons.shopping_cart_outlined, 'Review Cart',
                          ontab: () {
                        PushToNextScreen(context, const CartScreen());
                      }),
                      BulidProfileItem(Icons.view_list, 'My Orders', ontab: () {
                        PushToNextScreen(context, MyOrdersScreen());
                      }),
                      BulidProfileItem(Icons.person_outline, 'Profile',
                          ontab: () {
                        PushToNextScreen(context, ProfileScreen());
                      }),
                      Container(
                          height: 50,
                          color: Colors.grey[300],
                          width: double.infinity,
                          padding: const EdgeInsets.all(15),
                          child: const Text(
                            'SETTING',
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          )),
                      ListTile(
                        onTap: () {},
                        leading: const Icon(
                          Icons.dark_mode_outlined,
                          color: Colors.green,
                        ),
                        title: const Text(
                          'Dark Mode',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Switch(
                          value: value,
                          onChanged: (newValue) {
                            setState(() {
                              value = newValue;
                            });
                          },
                        ),
                      ),
                      const Divider(
                        height: 1,
                        color: Colors.grey,
                      ),
                      BulidProfileItem(Icons.map_outlined, 'Country'),
                      BulidProfileItem(Icons.flag_outlined, 'Language'),
                      Container(
                          height: 50,
                          color: Colors.grey[300],
                          width: double.infinity,
                          padding: const EdgeInsets.all(15),
                          child: const Text(
                            'REACH OUT TO US',
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          )),
                      BulidProfileItem(Icons.info_outline_rounded, 'FAQs',
                          ontab: () {
                        cubit.getFAQsData();
                        PushToNextScreen(context, FAQsScreen());
                      }),
                      BulidProfileItem(
                          Icons.phone_in_talk_outlined, 'Contact Us',
                          ontab: () {
                        PushToNextScreen(context, const ContactScreen());
                      }),
                      BulidProfileItem(Icons.power_settings_new, 'Sign Out',
                          ontab: () {
                        cubit.SignOut(context);
                      }),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
