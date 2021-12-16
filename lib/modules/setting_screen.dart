import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/shared/AppBloc/Appcubit&&%D9%8DSearchCubit/cubit.dart';
import 'package:shopapp/shared/AppBloc/Appcubit&&%D9%8DSearchCubit/status.dart';
import 'package:shopapp/shared/constance/combonants.dart';


class SettingScreen extends StatelessWidget {
  var Namecontolar = TextEditingController();
  var emailConerolar = TextEditingController();
  var PhoneConerolar = TextEditingController();
  var Formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppcubit, ShopStatus>(
      listener: (BuildContext context, state)
      {
        if (state is signOut)
        {
          Namecontolar.clear();
          emailConerolar.clear();
          PhoneConerolar.clear();
        }
      },
      builder: (BuildContext context, Object? state) {
        var cubit = ShopAppcubit.get(context);
        Namecontolar.text = cubit.UserModej!.data!.name!;
        emailConerolar.text = cubit.UserModej!.data!.email!;
        PhoneConerolar.text = cubit.UserModej!.data!.phone!;
        return ConditionalBuilder(
          condition: cubit.UserModej != null,
          builder: (context ) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: Formkey,
                child: Column(
                  children: [
                    const Text(
                      'Your Profile',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defulteditTextx(
                      Controlar: Namecontolar,
                      keyboardType: TextInputType.text,
                      Lable: 'Name',
                      prefix: Icons.person,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please inter Your Name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defulteditTextx(
                      Controlar: emailConerolar,
                      keyboardType: TextInputType.text,
                      Lable: 'Email Address',
                      prefix: Icons.email,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please inter Your Email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defulteditTextx(
                      Controlar: PhoneConerolar,
                      keyboardType: TextInputType.phone,
                      Lable: 'Phone',
                      prefix: Icons.phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please inter Your Phone';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    bottom(
                        width: double.infinity,
                        color: Colors.deepOrange,
                        onpressed: () {
                          if (Formkey.currentState!.validate())
                          {
                            ShopAppcubit.get(context).getShopUpdateprofaileData(
                                name: Namecontolar.text,
                                email: emailConerolar.text,
                                phone: PhoneConerolar.text);
                          }
                        },
                        text: 'Update'),
                    const SizedBox(
                      height: 20.0,
                    ),
                    bottom(
                        width: double.infinity,
                        color: Colors.deepOrange,
                        onpressed: () {
                          cubit.SignOut(context);
                        },
                        text: 'LOGOUT'),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
