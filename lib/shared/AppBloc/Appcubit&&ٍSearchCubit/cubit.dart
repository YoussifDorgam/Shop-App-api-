import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/change_favourite_model.dart';
import 'package:shopapp/models/get_favourite_data.dart';
import 'package:shopapp/models/get_homedata.dart';
import 'package:shopapp/models/shop_category_model.dart';
import 'package:shopapp/models/shop_login_model.dart';
import 'package:shopapp/models/shopappmodel.dart';
import 'package:shopapp/modules/category_screen.dart';
import 'package:shopapp/modules/favourit_screen.dart';
import 'package:shopapp/modules/home_screen.dart';
import 'package:shopapp/modules/login_screen.dart';
import 'package:shopapp/modules/setting_screen.dart';
import 'package:shopapp/network/end_points/end_points.dart';
import 'package:shopapp/shared/AppBloc/Appcubit&&%D9%8DSearchCubit/status.dart';
import 'package:shopapp/shared/constance/combonants.dart';
import 'package:shopapp/shared/constance/cons.dart';
import 'package:shopapp/shared/remote/catch.helper.dart';
import 'package:shopapp/shared/remote/dio.helper.dart';

class ShopAppcubit extends Cubit<ShopStatus> {
  ShopAppcubit() : super(ShopInitialStatus());

  static ShopAppcubit get(context) => BlocProvider.of(context);

  //change Bottom nav bar
  int currentindex = 0;
  Color? color = Colors.grey[300];

  void OnChangeTabs(int index) {
    currentindex = index;
    emit(ChangeTabs());
  }

  bool? Icontogel;

  // Bottom nav bar Icons theme
  final iconData = [
    const Icon(
      Icons.home,
      size: 30.0,
      color: Colors.black,
    ),
    const Icon(
      Icons.grid_on_sharp,
      size: 30.0,
      color: Colors.black,
    ),
    const Icon(
      Icons.favorite,
      size: 30.0,
      color: Colors.black,
    ),
    const Icon(
      Icons.settings,
      size: 30.0,
      color: Colors.black,
    ),
  ];

  // App Screens
  List<Widget> Screens = [
    HomeScreen(),
    CategoryScreen(),
    FavouriteScreen(),
    SettingScreen(),
  ];

  // method get home Data
  ShopHomeModel? shopHomeModel;
  IconData? FavIcon;
  Map<dynamic, dynamic> favorite = {};
  void gethomedata() {
    emit(ShopLodingStatus());
    Diohelper.getdata(url: HOME, Token: token).then((value) {
      emit(ShopSuccessStatus());
      shopHomeModel = ShopHomeModel.fromjsom(value.data);
      shopHomeModel!.data!.products.forEach((element) {
        favorite.addAll({
          element.id: element.infavorites,
        });
      });
      print(favorite.toString());
      print(shopHomeModel!.data!.banners[0]);
      print(value.toString());
    }).catchError((error) {
      print('errorrrrrrrr');
      print(error.toString());
      emit(ShopErrorStatus());
    });
  }

  // method get home Category Data
  CategoryModel? categoryModel;

  void GetCategoryModel() {
    Diohelper.getdata(url: CATEGORIES).then((value) {
      categoryModel = CategoryModel.formjson(value.data);
      print(value.toString());
      emit(ShopCategoriesSuccessStatus());
    }).catchError((error) {
      print('//////////////////////////////////////');
      print(error.toString());
      emit(ShopCategoriesErrorStatus());
    });
  }

  // method get User profile
  ShopLoginModel? UserModej;

  void getShopprofaileData() {
    emit(ShopLodingProfileStatus());
    Diohelper.getdata(url: SETTING, Token: token).then((value) {
      UserModej = ShopLoginModel.formjson(value.data);
      emit(ShopSuccessProfileStatus(UserModej!));
      print(UserModej.toString());
      print(UserModej!.data!.name);
    }).catchError((error) {
      print('errorrrrrrrr');
      print(error.toString());
      emit(ShopErrorProfileStatus());
    });
  }

  // method put&Update User Data
  void getShopUpdateprofaileData({
    required String? name,
    required String? email,
    required String? phone,
  }) {
    emit(ShopLodingUpdateUserStatus());
    Diohelper.PutData(
      url: update_profile,
      Token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      UserModej = ShopLoginModel.formjson(value.data);
      emit(ShopSuccessUpdateUserStatus(UserModej!));
      print(UserModej.toString());
      print(UserModej!.data!.name);
    }).catchError((error) {
      print('errorrrrrrrr');
      print(error.toString());
      emit(ShopErrorUpdateUserStatus());
    });
  }

  // method Sign Out
  void SignOut(context) {
    cachHelper.removeData('token').then((value) {
      NavegatandFinish(context, ShopLoginScreen());
      ShopAppcubit.get(context).currentindex = 0;
      emit(signOut());
    });
  }

  // method change favourite model
  ChangeFavouriteModel? changeFavouriteModel;
  // void ChangeFavourite(int product) {
  //
  //   favorite[product] = !favorite[product];
  //   emit(ShopSuccessChangeFavouriteStatus());
  //   Diohelper.PostData(url: FAVOURITE,
  //       Token: token,
  //       data: {
  //     'product_id': product,
  //   }).then((value)
  //   {
  //     if(changeFavouriteModel!.status == false)
  //       {
  //         favorite[product] = !favorite[product];
  //       }
  //     changeFavouriteModel = ChangeFavouriteModel.fromjson(value.data);
  //     emit(ShopSuccessChangeFavouriteStatus());
  //     print(value.data);
  //   }).catchError((error)
  //   {
  //     favorite[product] = !favorite[product];
  //     emit(ShopErrorChangeFavouriteStatus());
  //     print('edszkchxjkclzckkvczc');
  //     print(error.toString());
  //   });
  // }

  // method get fav data & product
  void changeFavorites(int productId)
  {
    if(favorite[productId] == true) {
      favorite[productId] = false;
      FavIcon = Icons.favorite;
    }
    else {
      favorite[productId] = true;
      FavIcon = Icons.favorite_border;
    }
    emit(ShopChangeFavorietsState());
    Diohelper.PostData(url: FAVOURITE,
      data:
      {
        'product_id' : productId,
      },
      Token: token,
    ).then((value) {
      changeFavouriteModel = ChangeFavouriteModel.fromjson(value.data);
      print(value.data);
      GetFavData();
      if(!changeFavouriteModel!.status!){
        if(favorite[productId] == true) {
          favorite[productId] = false;
          FavIcon = Icons.favorite;
        }
        else {
          favorite[productId] = true;
          FavIcon = Icons.favorite_border;
        }
      }
      emit(ShopSuccessChangeFavouriteStatus());
    }
    ).catchError((error){
      if(favorite[productId] == true) {
        favorite[productId] = false;
        FavIcon = Icons.favorite;
      }
      else {
        favorite[productId] = true;
        FavIcon = Icons.favorite_border;
      }

      emit(ShopErrorChangeFavouriteStatus());
    });

  }
  // get favourite data
  getfavoyritedata? getFavouriteData ;
  void GetFavData() {
    emit(ShopLodingGetFavouriteDataStatus());
    Diohelper.getdata(url: FAVOURITE , Token: token).then((value) {
      getFavouriteData = getfavoyritedata.fromJson(value.data);
      print(value.toString());
      emit(ShopSuccessGetFavouriteDataStatus());
    }).catchError((error) {
      print('//////////////////');
      print(error.toString());
      emit(ShopErrorGetFavouriteDataStatus());
    });
  }

 // ProductDetailsModel? homeProductmodel ;
  // void gethomepro_data( )
  // {
  //   emit(ShopLodingGetHomProductDataStatus());
  //   Diohelper.getdata(url: 'products' , Token: token)
  //       .then((value)
  //   {
  //     homeProductmodel = ProductDetailsModel.fromJson(value.data);
  //     print('.....................${homeProductmodel!.status.toString}');
  //     emit(ShopSuccessGetHomProductDataStatus( ));
  //   }).catchError((error){
  //     print('Error in this case is ${error.toString()}');
  //     emit(ShopErrorGetHomProductDataStatus());
  //   });
  // }


  ProductDetailsModel? productDetailsModel;

  void getProductData( ) {
    emit(ShopLodingGetHomProductDataStatus());
    Diohelper.getdata(
        url: 'products/',
        Token: token
    ).then((value){
      productDetailsModel = ProductDetailsModel.fromJson(value.data);
      print('Product Detail '+productDetailsModel!.status.toString());
      emit(ShopSuccessGetHomProductDataStatus());
    }).catchError((error){
      emit(ShopErrorGetHomProductDataStatus());
      print(error.toString());
    });
  }


}
