import 'package:shopapp/models/change_favourite_model.dart';
import 'package:shopapp/models/post_addresses.dart';
import 'package:shopapp/models/search_model.dart';
import 'package:shopapp/models/shop_login_model.dart';
import 'package:shopapp/models/shopappmodel.dart';
import 'package:shopapp/models/updateaddress_model.dart';

abstract class ShopStatus {}
class ShopInitialStatus extends ShopStatus {}
class EditPressedState extends ShopStatus{}
class ShopLodingStatus extends ShopStatus {}
class ShopSuccessStatus extends ShopStatus
{
}
class ShopErrorStatus extends ShopStatus {
}
////////////////////////////////////

class ChangeTabs extends ShopStatus {}
/////////////////////////////////////
class ShopCategoriesSuccessStatus extends ShopStatus
{
}
class ShopCategoriesErrorStatus extends ShopStatus {
}

////////////////////////////////
class ShopLodingProfileStatus extends ShopStatus {}
class ShopSuccessProfileStatus extends ShopStatus
{
  final ShopLoginModel shopHomeModel ;
  ShopSuccessProfileStatus(this.shopHomeModel);
}
class ShopErrorProfileStatus extends ShopStatus {
}
///////////////////////////////////////
class ShopLodingUpdateUserStatus extends ShopStatus {}
class ShopSuccessUpdateUserStatus extends ShopStatus
{
  ShopLoginModel user ;
  ShopSuccessUpdateUserStatus(this.user);

}
class ShopErrorUpdateUserStatus extends ShopStatus {
}
class signOut extends ShopStatus {
}
//////////////////////////////////



abstract class SearchStatus {}
class ShopSearchInitialStatus extends SearchStatus {}

class ShopLodingSearchStatus extends SearchStatus {}
class ShopSuccessSearchStatus extends SearchStatus
{
  final SearchModel searchModel ;
  ShopSuccessSearchStatus(this.searchModel);
}
class ShopErrorSearchStatus extends SearchStatus {
}
/////////////////////////////////////////
class ShopChangeFavorietsState extends ShopStatus {}
class ShopSuccessChangeFavouriteStatus extends ShopStatus{}
class ShopErrorChangeFavouriteStatus extends ShopStatus{}
//////////////////////////////////////////
class ShopLodingGetFavouriteDataStatus extends ShopStatus {}
class ShopSuccessGetFavouriteDataStatus extends ShopStatus {}
class ShopErrorGetFavouriteDataStatus extends ShopStatus {}
////////////////////////////////////////
class ShopLodingGetHomProductDataStatus extends ShopStatus {}
class ShopSuccessGetHomProductDataStatus extends ShopStatus {}
class ShopErrorGetHomProductDataStatus extends ShopStatus {}
////////////
class ChangeIndicatorState extends ShopStatus {}
////////////////////////////////////////
class ShopChangeCartsState extends ShopStatus {}
class ShopSuccessChangeCartsStatus extends ShopStatus{}
class ShopErrorChangeCartsStatus extends ShopStatus{}
////////////////////////////////////////
class ShopLodingGetCartsDataStatus extends ShopStatus {}
class ShopSuccessGetCartsDataStatus extends ShopStatus {}
class ShopErrorGetCartsDataStatus extends ShopStatus {}
////////////////////////////////////////
class plusquantity extends ShopStatus {}
class minusquantity extends ShopStatus {}
/////////////////////////
class LoadingGetCountCarts extends ShopStatus {}
class SuccessGetCountCarts extends ShopStatus {}
class ErrorGetCountCarts extends ShopStatus {}
////////////////////////
class ShopLodingPostAddreesesStatus extends ShopStatus {}
class ShopSuccessPostAddreesesStatus extends ShopStatus{
  AddAddressModel addAddressModel;
  ShopSuccessPostAddreesesStatus(this.addAddressModel);
}
class ShopErrorPostAddreesesStatus extends ShopStatus{}
/////////////////////
class ShopLodingGetAddreesesStatus extends ShopStatus {}
class ShopSuccessGetAddreesesStatus extends ShopStatus{}
class ShopErrorGetAddreesesStatus extends ShopStatus{}
///////////////////////
class ShopLodingUpdateAddreesesStatus extends ShopStatus {}
class ShopSuccessUpdateAddreesesStatus extends ShopStatus{
  UpdateAddressModel  updateAddressModel;
  ShopSuccessUpdateAddreesesStatus(this.updateAddressModel);
}
class ShopErrorUpdateAddreesesStatus extends ShopStatus{}
//////////////////////////////////////////
class ShopLodingDeleteAddreesesStatus extends ShopStatus {}
class ShopSuccessDeleteAddreesesStatus extends ShopStatus{}
class ShopErrorDeleteAddreesesStatus extends ShopStatus{}
///////////////////////
class FAQsLoadingState extends ShopStatus {}
class FAQsSuccessState extends ShopStatus{}
class FAQsErrorState extends ShopStatus{}
/////////////////////////////////
class CategoryDetailsLoadingState extends ShopStatus {}
class CategoryDetailsSuccessState extends ShopStatus{}
class CategoryDetailsErrorState extends ShopStatus{}
///////////////////////////////////
