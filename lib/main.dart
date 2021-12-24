import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/login_screen.dart';
import 'package:shopapp/modules/on_bording_screen.dart';
import 'package:shopapp/shared/AppBloc/Appcubit&&%D9%8DSearchCubit/cubit.dart';
import 'package:shopapp/shared/AppBloc/register.screen/cubit.dart';
import 'package:shopapp/shared/AppBloc/shoplogin_bloc/blocobservar.dart';
import 'package:shopapp/shared/AppBloc/shoplogin_bloc/cubit.dart';
import 'package:shopapp/shared/constance/cons.dart';
import 'package:shopapp/shared/remote/catch.helper.dart';
import 'package:shopapp/shared/remote/dio.helper.dart';

import 'layout/shop_app_layout.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  Diohelper.init();
  await cachHelper.init();
  dynamic onBoardingFinish = false;
  onBoardingFinish = cachHelper.getData('ShowOnBoard');
  token = cachHelper.getData('token');
  print(token);
  late Widget start;
  if (onBoardingFinish != null) {
    if (token == null) {
      start = ShopLoginScreen();
    } else {
      start = const ShopAppLayout();
    }
  } else {
    start = OnBording_Screen();
  }

  runApp(MyApp(start));
}
// BlocOverrides.runZoned(
// () {
// // Use cubits...
// },
// blocObserver: MyBlocObserver(),
// );

class MyApp extends StatelessWidget {
  Widget startApp;

  MyApp(this.startApp);

  // his widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ShopAppLogincubit()),
        BlocProvider(
            create: (context) => ShopAppcubit()
              ..gethomedata()
              ..getAddresses()
              ..GetCategoryModel()
              ..getOrders()),
        BlocProvider(create: (context) => ShopAppRegistercubit()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          scaffoldBackgroundColor: Colors.white,
        ),
        debugShowCheckedModeBanner: false,
        home: startApp,
      ),
    );
  }
}
