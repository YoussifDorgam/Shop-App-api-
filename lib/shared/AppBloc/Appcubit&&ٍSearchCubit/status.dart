

import 'package:shopapp/models/change_favourite_model.dart';
import 'package:shopapp/models/get_homedata.dart';
import 'package:shopapp/models/search_model.dart';
import 'package:shopapp/models/shop_login_model.dart';
import 'package:shopapp/models/shopappmodel.dart';

abstract class ShopStatus {}
class ShopInitialStatus extends ShopStatus {}
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
class ShopSuccessChangeFavouriteStatus extends ShopStatus
{

}
class ShopErrorChangeFavouriteStatus extends ShopStatus {
}
//////////////////////////////////////////
class ShopChangeFavorietsState extends ShopStatus {}
class ShopLodingGetFavouriteDataStatus extends ShopStatus {}
class ShopSuccessGetFavouriteDataStatus extends ShopStatus
{

}
class ShopErrorGetFavouriteDataStatus extends ShopStatus {
}
////////////////////////////////////////
class ShopLodingGetHomProductDataStatus extends ShopStatus {}
class ShopSuccessGetHomProductDataStatus extends ShopStatus
{
}
class ShopErrorGetHomProductDataStatus extends ShopStatus {}
////////////
class ChangeIndicatorState extends ShopStatus {}

