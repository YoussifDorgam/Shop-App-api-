import 'package:flutter/material.dart';
import 'package:shopapp/shared/AppBloc/Appcubit&&%D9%8DSearchCubit/cubit.dart';
import 'package:shopapp/shared/AppBloc/Appcubit&&%D9%8DSearchCubit/status.dart';

dynamic token = '';
bool isEdit = false;
String editText = 'Edit';

void editPressed({
  required context,
  required email,
  required name,
  required phone,
}) {
  isEdit = !isEdit;
  if (isEdit) {
    editText = 'Save';
    ShopAppcubit.get(context).emit(EditPressedState());
  } else {
    editText = 'Edit';
    ShopAppcubit.get(context)
        .getShopUpdateprofaileData(email: email, name: name, phone: phone);
  }
}

Widget myDivider() => Container(
      color: Colors.grey[300],
      height: 1,
      width: double.infinity,
    );
