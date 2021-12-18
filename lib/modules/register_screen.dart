import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/layout/shop_app_layout.dart';
import 'package:shopapp/modules/login_screen.dart';
import 'package:shopapp/shared/AppBloc/Appcubit&&%D9%8DSearchCubit/cubit.dart';
import 'package:shopapp/shared/AppBloc/register.screen/cubit.dart';
import 'package:shopapp/shared/AppBloc/register.screen/status.dart';
import 'package:shopapp/shared/constance/combonants.dart';
import 'package:shopapp/shared/constance/cons.dart';
import 'package:shopapp/shared/remote/catch.helper.dart';
class RefisterScreen extends StatelessWidget {
  var PasswordConerolar = TextEditingController();
  var NamedConerolar = TextEditingController();
  var EmailConerolar = TextEditingController();
  var PhoneConerolar = TextEditingController();
  var Formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppRegistercubit, ShopRegisterStatus>(
      listener: (BuildContext context, state) {
        if (state is ShopRegisterSuccessStatus) {
          if (state.userRegisterModel.status == true) {
            print(state.userRegisterModel.status);
            print(state.userRegisterModel.message);
            print(state.userRegisterModel.data!.token);
            Fluttertoast.showToast(
                msg: state.userRegisterModel.message.toString(),
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
            cachHelper.Savedataa(
                    key: 'token', value: state.userRegisterModel.data!.token)
                .then((value) {
              token = state.userRegisterModel.data!.token!;
              print(value.toString());
              NavegatandFinish(context, ShopAppLayout());
              NamedConerolar.clear();
              PhoneConerolar.clear();
              EmailConerolar.clear();
              PasswordConerolar.clear();
              // confirmPassword.clear();
              // navigateAndKill(context, ShopLayout());
              ShopAppcubit.get(context).currentindex = 0;
              ShopAppcubit.get(context).gethomedata();
              ShopAppcubit.get(context).getShopprofaileData();
              ShopAppcubit.get(context).GetFavData();
              // ShopCubit.get(context).getCartData();
              // ShopCubit.get(context).getAddresses();
            }).catchError((error) {
              print(error.toString());
            });
          } else {
            Fluttertoast.showToast(
                msg: state.userRegisterModel.message.toString(),
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
        var cubit = ShopAppRegistercubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back_ios ,color:Colors.black,)),
            elevation: 1.0,
            backgroundColor: Colors.white,
          ),
          body: Form(
            key: Formkey,
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 30.0,
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      const Text(
                        'Register naw you browse our hot offers',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      defulteditTextx(
                        Controlar: NamedConerolar,
                        keyboardType: TextInputType.text,
                        Lable: 'Full Name',
                        prefix: Icons.person,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'PLease Inter your Name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      defulteditTextx(
                        Controlar: EmailConerolar,
                        keyboardType: TextInputType.text,
                        Lable: 'Email',
                        prefix: Icons.email,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'PLease Inter your Email';
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
                            return 'PLease Inter your Phone';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      defulteditTextx(
                        Controlar: PasswordConerolar,
                        keyboardType: TextInputType.text,
                        Lable: 'Password',
                        prefix: Icons.lock,
                        sufix: cubit.iconData,
                        obscureText: cubit.isoscureShow,
                        suffixPressed: ()
                        {
                          cubit.eyeisShow();
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'PLease Inter your Password';
                          }
                          return null;
                        },
                        onfiled: (value) {
                          print(value);
                        },
                        onSubmit: (value) {
                          if (Formkey.currentState!.validate()) {
                            cubit.UserRegister(
                              email: EmailConerolar.text,
                              password: PasswordConerolar.text,
                              name: NamedConerolar.text,
                              phone: PhoneConerolar.text,
                            );
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
                            if (Formkey.currentState!.validate()) {
                              cubit.UserRegister(
                                email: EmailConerolar.text,
                                password: PasswordConerolar.text,
                                name: NamedConerolar.text,
                                phone: PhoneConerolar.text,
                              );
                            }
                          },
                          text: 'REGISTER'),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Have an account yet ?',
                            style: TextStyle(color: Colors.grey),
                          ),
                          TextButton(
                            onPressed: () {
                              Navegato(context, ShopLoginScreen());
                            },
                            child: const Text('Login'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
