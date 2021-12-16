import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/shop_login_model.dart';
import 'package:shopapp/network/end_points/end_points.dart';
import 'package:shopapp/shared/AppBloc/shoplogin_bloc/status.dart';
import 'package:shopapp/shared/remote/dio.helper.dart';


class ShopAppLogincubit extends Cubit<ShopLoginStatus> {
  ShopAppLogincubit() : super(ShopLoginInitialStatus());
  ShopLoginModel? UserModel;

  static ShopAppLogincubit get(context) => BlocProvider.of(context);

  void UserLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLodingStatus());
    Diohelper.PostData(url: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      UserModel = ShopLoginModel.formjson(value.data);
      emit(ShopLoginSuccessStatus(UserModel!));
    }).catchError((error) {
      print('  الايرور هنا  .........');
      print(error);
      emit(ShopLoginErrorStatus(error.toString()));
    });
  }

  IconData iconData =Icons.visibility_outlined ;
  bool isoscureShow = true;

  void eyeisShow() {
    iconData = isoscureShow
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
    isoscureShow = !isoscureShow;
    emit(IseyeShow());
  }
}
