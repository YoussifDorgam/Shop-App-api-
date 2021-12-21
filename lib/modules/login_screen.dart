import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/layout/shop_app_layout.dart';
import 'package:shopapp/modules/register_screen.dart';
import 'package:shopapp/shared/AppBloc/Appcubit&&%D9%8DSearchCubit/cubit.dart';
import 'package:shopapp/shared/AppBloc/shoplogin_bloc/cubit.dart';
import 'package:shopapp/shared/AppBloc/shoplogin_bloc/status.dart';
import 'package:shopapp/shared/constance/combonants.dart';
import 'package:shopapp/shared/constance/cons.dart';
import 'package:shopapp/shared/remote/catch.helper.dart';

class ShopLoginScreen extends StatelessWidget {
  var EmailControlar = TextEditingController();
  var PasswordConerolar = TextEditingController();
  var Formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppLogincubit, ShopLoginStatus>(
      listener: (BuildContext context, state) {
        if (state is ShopLoginSuccessStatus) {
          if (state.loginModel.status == true) {
            Fluttertoast.showToast(
                msg: state.loginModel.message.toString(),
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
            cachHelper.Savedataa(
                    key: 'token', value: state.loginModel.data?.token)
                .then((value) {
              token = state.loginModel.data!.token! ;
              NavegatandFinish(context, ShopAppLayout());
              EmailControlar.clear();
              PasswordConerolar.clear();
              ShopAppcubit.get(context).currentindex = 0;
              ShopAppcubit.get(context).gethomedata();
              ShopAppcubit.get(context).getShopprofaileData();
              ShopAppcubit.get(context).getShopprofaileData();
              ShopAppcubit.get(context).GetFavData();
              ShopAppcubit.get(context).GetCartData();
              ShopAppcubit.get(context).getAddresses();
            }).catchError((error) {
            });
          } else {
            Fluttertoast.showToast(
                msg: state.loginModel.message.toString(),
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }
      },
      builder: (BuildContext context, Object? state) {
        var cubit = ShopAppLogincubit.get(context);
        return Scaffold(
          appBar: AppBar(
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
            backgroundColor: Colors.white,
            elevation: 1.0,
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Image(
                    image: AssetImage('assets/images/image4.png'),
                    width: 150,
                    height: 150,
                  ),
                  Center(
                    child: Form(
                      key: Formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          const Text(
                            'Login naw you browse our hot offers',
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 40.0,
                          ),
                          defulteditTextx(
                            Controlar: EmailControlar,
                            keyboardType: TextInputType.text,
                            Lable: 'Email Address',
                            prefix: Icons.email,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email is to Short';
                              }
                              return null;
                            },
                            onfiled: (value) {
                              print(value);
                            },
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          defulteditTextx(
                            Controlar: PasswordConerolar,
                            keyboardType: TextInputType.text,
                            Lable: 'Password',
                            prefix: Icons.lock,
                            sufix: cubit.iconData,
                            obscureText: cubit.isoscureShow,
                            suffixPressed: () {
                              cubit.eyeisShow();
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password is to Short';
                              }
                              return null;
                            },
                            onfiled: (value) {
                              print(value);
                            },
                            onSubmit: (value) {
                              if (Formkey.currentState!.validate()) {
                                cubit.UserLogin(
                                    email: EmailControlar.text,
                                    password: PasswordConerolar.text);
                              }
                            },
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          ConditionalBuilder(
                            condition: state is! ShopLoginLodingStatus,
                            builder: (BuildContext context) => bottom(
                                width: double.infinity,
                                color: Colors.deepOrange,
                                onpressed: () {
                                  if (Formkey.currentState!.validate()) {
                                    cubit.UserLogin(
                                        email: EmailControlar.text,
                                        password: PasswordConerolar.text);
                                  }
                                },
                                text: 'Login'),
                            fallback: (BuildContext context) => const Center(
                                child: CircularProgressIndicator()),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Don\'t Have an account yet ?',
                                style: TextStyle(color: Colors.grey),
                              ),
                              TextButton(
                                onPressed: () {
                                  PushToNextScreen(context, RefisterScreen());
                                },
                                child: const Text('Register'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
