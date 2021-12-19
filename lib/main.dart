import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_app_layout.dart';
import 'package:shopapp/modules/login_screen.dart';
import 'package:shopapp/modules/on_bording_screen.dart';
import 'package:shopapp/shared/AppBloc/Appcubit&&%D9%8DSearchCubit/cubit.dart';
import 'package:shopapp/shared/AppBloc/register.screen/cubit.dart';
import 'package:shopapp/shared/AppBloc/shoplogin_bloc/blocobservar.dart';
import 'package:shopapp/shared/AppBloc/shoplogin_bloc/cubit.dart';
import 'package:shopapp/shared/constance/cons.dart';
import 'package:shopapp/shared/remote/catch.helper.dart';
import 'package:shopapp/shared/remote/dio.helper.dart';

import 'modules/home_product_data_screean.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  Diohelper.init();
  await cachHelper.init();

  bool OnBording = cachHelper.getData('ShowOnBoard');
  token = cachHelper.getData('token');
  Widget widget = ShopAppLayout();
  if (OnBording != null) {
    if (token != null) {
      print(token);
      widget = ShopAppLayout();
    } else {
      widget = ShopLoginScreen();
    }
    //بيرجع من الاول تانى لى
  } else {
    widget = OnBording_Screen();
  }
  runApp(MyApp(
    onbo: OnBording,
    Startapp: widget,
  ));
}

class MyApp extends StatelessWidget {
  late final Widget Startapp;

  late final bool onbo;

  MyApp({required this.Startapp, required this.onbo});

  // his widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:
      [
        BlocProvider(create:  (context) => ShopAppLogincubit()),
        BlocProvider(create:  (context) => ShopAppcubit()..gethomedata()..GetCategoryModel()..GetFavData()..GetCartData()),
        BlocProvider(create:  (context) => ShopAppRegistercubit()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          scaffoldBackgroundColor: Colors.white ,
        ),
        debugShowCheckedModeBanner: false,
        home: Startapp,
      ),
    );
  }
}
