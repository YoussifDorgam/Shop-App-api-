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
    return BlocProvider.value(
      value: BlocProvider.of<ShopAppcubit>(context)..getShopprofaileData(),
      child: BlocConsumer<ShopAppcubit, ShopStatus>(
        listener: (BuildContext context, state) {
          if (state is ShopSuccessProfileStatus) {
            emailConerolar.text =
                ShopAppcubit.get(context).UserModej!.data!.email!;
            Namecontolar.text =
                ShopAppcubit.get(context).UserModej!.data!.name!;
            PhoneConerolar.text =
                ShopAppcubit.get(context).UserModej!.data!.phone!;
          }

          if (state is signOut) {
            Namecontolar.clear();
            emailConerolar.clear();
            PhoneConerolar.clear();
          }

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
          return SingleChildScrollView(
            child: state is ShopLodingProfileStatus
                ? const Center(child: LinearProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: Formkey,
                      child: Column(
                        children: [
                          if (state is ShopLodingUpdateUserStatus)
                            const Padding(
                              padding: EdgeInsets.all(28.0),
                              child: LinearProgressIndicator(
                                color: Colors.purple,
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
                            },
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          bottom(
                              width: double.infinity,
                              color: Colors.deepOrange,
                              onpressed: () {
                                ShopAppcubit.get(context)
                                    .getShopUpdateprofaileData(
                                        name: Namecontolar.text,
                                        email: emailConerolar.text,
                                        phone: PhoneConerolar.text);
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
          );
        },
      ),
    );
  }
}
