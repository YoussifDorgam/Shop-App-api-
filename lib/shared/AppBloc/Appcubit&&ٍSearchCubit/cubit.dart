import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/add_order_data.dart';
import 'package:shopapp/models/categoriesdetailsdatal.dart';
import 'package:shopapp/models/change_cart_items.dart';
import 'package:shopapp/models/change_favourite_model.dart';
import 'package:shopapp/models/faqs_model.dart';
import 'package:shopapp/models/get_addresses_model.dart';
import 'package:shopapp/models/get_cart_data.dart';
import 'package:shopapp/models/get_favourite_data.dart';
import 'package:shopapp/models/get_homedata.dart';
import 'package:shopapp/models/post_addresses.dart';
import 'package:shopapp/models/shop_category_model.dart';
import 'package:shopapp/models/shop_login_model.dart';
import 'package:shopapp/models/shopappmodel.dart';
import 'package:shopapp/models/updateaddress_model.dart';
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
      Icons.category,
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
  Map<int, bool> favorite = {};
  Map<int, bool> InCart = {};

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
      shopHomeModel!.data!.products.forEach((element) {
        InCart.addAll({
          element.id: element.Incart,
        });
      });
      print("Cart data ${InCart.toString()}");
      print("Favourite data ${favorite.toString()}");
      print(shopHomeModel!.data!.banners[0]);
      print(value.toString());
    }).catchError((error) {
      print('errorrrrrrrr');
      print(error.toString());
      emit(ShopErrorStatus());
    });
  }

  // getProductData
  ProductDetailsModel? productDetailsModel;

  void getProductData(String id) {
    productDetailsModel = null;
    emit(ShopLodingGetHomProductDataStatus());
    Diohelper.getdata(url: 'products/$id', Token: token).then((value) {
      productDetailsModel = ProductDetailsModel.fromJson(value.data);
      print('Product Detail ' + productDetailsModel!.status.toString());
      emit(ShopSuccessGetHomProductDataStatus());
    }).catchError((error) {
      emit(ShopErrorGetHomProductDataStatus());
      print(error.toString());
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
      print(error.toString());
      print(error);
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
      print(error.toString());
      print(error);
      error.toString();
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
      getShopprofaileData();
      UserModej = ShopLoginModel.formjson(value.data);
      emit(ShopSuccessUpdateUserStatus(UserModej!));
      print(UserModej.toString());
      print(UserModej!.data!.name);
    }).catchError((error) {
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

  void changeFavorites(int productId) {
    if (favorite[productId] == true) {
      favorite[productId] = false;
    } else {
      favorite[productId] = true;
    }
    emit(ShopChangeFavorietsState());
    Diohelper.PostData(
      url: FAVOURITE,
      data: {
        'product_id': productId,
      },
      Token: token,
    ).then((value) {
      changeFavouriteModel = ChangeFavouriteModel.fromjson(value.data);
      print(value.data);
      GetFavData();
      emit(ShopSuccessChangeFavouriteStatus());
    }).catchError((error) {
      if (favorite[productId] == true) {
        favorite[productId] = false;
        FavIcon = Icons.favorite;
      } else {
        favorite[productId] = true;
        FavIcon = Icons.favorite_border;
      }

      emit(ShopErrorChangeFavouriteStatus());
    });
  }

  // get favourite data
  getfavoyritedata? getFavouriteData;

  void GetFavData() {
    emit(ShopLodingGetFavouriteDataStatus());
    Diohelper.getdata(url: FAVOURITE, Token: token).then((value) {
      getFavouriteData = getfavoyritedata.fromJson(value.data);
      print(value.toString());
      emit(ShopSuccessGetFavouriteDataStatus());
    }).catchError((error) {
      print('//////////////////');
      print(error.toString());
      emit(ShopErrorGetFavouriteDataStatus());
    });
  }

  // changeVal
  int value = 0;

  void changeVal(val) {
    value = val;
    emit(ChangeIndicatorState());
  }

  // changeCart
  ChangeCartModel? changeCartModel;

  void changeCart(int productId) {
    if (InCart[productId] == true) {
      InCart[productId] = false;
    } else {
      InCart[productId] = true;
    }
    emit(ShopChangeCartsState());
    Diohelper.PostData(
      url: CARTS,
      data: {
        'product_id': productId,
      },
      Token: token,
    ).then((value) {
      changeCartModel = ChangeCartModel.fromjson(value.data);
      GetCartData();
      print(value.data);
      emit(ShopSuccessChangeCartsStatus());
    }).catchError((error) {
      if (InCart[productId] == true) {
        InCart[productId] = false;
      } else {
        InCart[productId] = true;
      }
      emit(ShopErrorChangeCartsStatus());
    });
  }

  // get cart data
  GetCartModel? getCartModel;

  void GetCartData() {
    emit(ShopLodingGetCartsDataStatus());
    Diohelper.getdata(url: CARTS, Token: token).then((value) {
      getCartModel = GetCartModel.fromJson(value.data);
      print(value.toString());
      emit(ShopSuccessGetCartsDataStatus());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetCartsDataStatus());
    });
  }

  // plusQuantity
  int quantity = 1;

  void plusQuantity(GetCartModel model, index) {
    emit(plusquantity());
    quantity = model.data.cartItems[index].quantity;
    quantity++;
    emit(plusquantity());
  }

  //minusQuantity
  void minusQuantity(GetCartModel model, index) {
    quantity = model.data.cartItems[index].quantity;
    if (quantity > 1) quantity--;
    emit(minusquantity());
  }

  // updateCartData
  void updateCartData({required String id, int? quantity}) {
    emit(LoadingGetCountCarts());
    Diohelper.PutData(
            url: "${UPATECARTS + id}",
            data: {
              'quantity': quantity,
            },
            Token: token)
        .then((value) {
      GetCartData();
      print('done    هحااااااااااااااااااااااااااى');
      emit(SuccessGetCountCarts());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorGetCountCarts());
    });
  }

  /// POST Adresses
  AddAddressModel? addAddressModel;

  void PostAddressesData({
    required String name,
    required String city,
    required String region,
    required String details,
    required String notes,
    double latitude = 30.0616863,
    double longitude = 31.3260088,
  }) {
    emit(ShopLodingPostAddreesesStatus());
    Diohelper.PostData(
      url: Ad_ADDRESSES,
      data: {
        'name': name,
        'city': city,
        'region': region,
        'details': details,
        'notes': notes,
        'latitude': latitude,
        'longitude': longitude,
      },
      Token: token,
    ).then((value) {
      addAddressModel = AddAddressModel.fromJson(value.data);
      if (addAddressModel!.status) {
        getAddresses();
      } else {
        showToast(addAddressModel!.message);
      }
      emit(ShopSuccessPostAddreesesStatus(addAddressModel!));
    }).catchError((error) {
      emit(ShopErrorPostAddreesesStatus());
    });
  }

  // get Adresses data
  AddressModel? addressModel;

  void getAddresses() {
    emit(ShopLodingGetAddreesesStatus());
    Diohelper.getdata(
      url: ADDRESSES,
      Token: token,
    ).then((value) {
      addressModel = AddressModel.fromJson(value.data);
      print('Get Addresses ' + addressModel!.status.toString());
      emit(ShopSuccessGetAddreesesStatus());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetAddreesesStatus());
    });
  }

  // UpdateAddressModel
  UpdateAddressModel? updateAddressModel;

  void updateAddress({
    required int? addressId,
    required String name,
    required String city,
    required String region,
    required String details,
    required String notes,
    double latitude = 30.0616863,
    double longitude = 31.3260088,
  }) {
    emit(ShopLodingUpdateAddreesesStatus());
    Diohelper.PutData(url: 'addresses/$addressId', Token: token, data: {
      'name': name,
      'city': city,
      'region': region,
      'details': details,
      'notes': notes,
      'latitude': latitude,
      'longitude': longitude,
    }).then((value) {
      updateAddressModel = UpdateAddressModel.fromJson(value.data);
      getAddresses();
      print('Update Address ' + updateAddressModel!.status.toString());
      if (updateAddressModel!.status) {
        getAddresses();
      }
      emit(ShopSuccessUpdateAddreesesStatus(updateAddressModel!));
    }).catchError((error) {
      emit(ShopErrorUpdateAddreesesStatus());
      print(error.toString());
    });
  }

  // deleteAddress
  UpdateAddressModel? deleteAddressModel;

  void deleteAddress({required addressId}) {
    emit(ShopLodingDeleteAddreesesStatus());
    Diohelper.deleteData(
      url: 'addresses/$addressId',
      token: token,
    ).then((value) {
      deleteAddressModel = UpdateAddressModel.fromJson(value.data);
      print('delete Address ' + deleteAddressModel!.status.toString());
      if (deleteAddressModel!.status) getAddresses();
      emit(ShopSuccessDeleteAddreesesStatus());
    }).catchError((error) {
      emit(ShopErrorDeleteAddreesesStatus());
      print(error.toString());
    });
  }

  // FAQs Data
  late FAQsModel faqsModel;

  void getFAQsData() {
    emit(FAQsLoadingState());
    Diohelper.getdata(
      url: 'faqs',
    ).then((value) {
      faqsModel = FAQsModel.fromJson(value.data);
      print('Get FAQs ' + faqsModel.status.toString());
      emit(FAQsSuccessState());
    }).catchError((error) {
      emit(FAQsErrorState());
      print(error.toString());
    });
  }

  // getCategoriesDetailData

  CategoryDetailModel? categoriesDetailModel;

  void getCategoriesDetailData(int? categoryID) {
    emit(CategoryDetailsLoadingState());
    Diohelper.getdata(url: CATEGORIES_DETAIL, query: {
      'category_id': '$categoryID',
    }).then((value) {
      categoriesDetailModel = CategoryDetailModel.fromJson(value.data);
      print('categories Detail ' + categoriesDetailModel!.status.toString());
      emit(CategoryDetailsSuccessState());
    }).catchError((error) {
      emit(CategoryDetailsErrorState());
      print(error.toString());
    });
  }

  /// Add Order
  AddOrderModel? addOrderModel;

  void AddOrder({required int AddressId, context}) {
    emit(ShopLodingAddOrderStatus());
    Diohelper.PostData(
      url: Orders,
      data: {
        'address_id': AddressId,
        'payment_method': 1,
        'use_points': false,
      },
      Token: token,
    ).then((value) {
      addOrderModel = AddOrderModel.fromJson(value.data);
      if (addOrderModel!.status) {
        GetCartData();
        getOrders();
        emit(ShopSuccessAddOrderStatus(addOrderModel!));
      } else {
        GetCartData();
        getOrders();
      }
    }).catchError((error) {
      emit(ShopErrorAddOrderStatus());
    });
  }

  // get Order
  GetOrderModel? orderModel;

  void getOrders() {
    emit(GetOrdersLoadingState());
    Diohelper.getdata(url: Orders, Token: token).then((orders) {
      orderModel = GetOrderModel.fromJson(orders.data);
      ordersDetails.clear();
      ordersIds.clear();
      orderModel!.data.data.forEach((element) {
        ordersIds.add(element.id);
      });
      emit(GetOrdersSuccessState(orderModel!));
      getOrdersDetails();
    }).catchError((error) {
      emit(GetOrdersErrorState(error));
      print('Get Orders Error ${error.toString()}');
    });
  }

  // getOrdersDetails
  List<int> ordersIds = [];
  OrderDetailsModel? orderItemDetails;
  List<OrderDetailsModel> ordersDetails = [];

  void getOrdersDetails() async {
    emit(OrderDetailsLoadingState());
    if (ordersIds.isNotEmpty) {
      for (var id in ordersIds) {
        await Diohelper.getdata(url: "$Orders/$id", Token: token)
            .then((orderDetails) {
          orderItemDetails = OrderDetailsModel.fromJson(orderDetails.data);
          ordersDetails.add(orderItemDetails!);
          emit(OrderDetailsSuccessState(orderItemDetails!));
        }).catchError((error) {
          emit(OrderDetailsErrorState(error));
          print('Get Orders Details Error ${error.toString()}');
          return;
        });
      }
    }
  }

  // cancelOrder
  CancelOrderModel? cancelOrderModel;

  void cancelOrder({required int id}) {
    emit(CancelOrderLoadingState());
    Diohelper.getdata(url: "orders/$id/cancel", Token: token).then((value) {
      cancelOrderModel = CancelOrderModel.fromJson(value.data);
      getOrders();
      emit(CancelOrderSuccessState(cancelOrderModel!));
    }).catchError((error) {
      print(error.toString());
      emit(CancelOrderErrorState(error));
    });
  }
}
