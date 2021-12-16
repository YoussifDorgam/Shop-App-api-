import 'package:shopapp/models/shop_login_model.dart';

abstract class ShopLoginStatus {}
class ShopLoginInitialStatus extends ShopLoginStatus {}
class ShopLoginLodingStatus extends ShopLoginStatus {}
class ShopLoginSuccessStatus extends ShopLoginStatus
{
 final ShopLoginModel loginModel ;
  ShopLoginSuccessStatus(this.loginModel);
}
class ShopLoginErrorStatus extends ShopLoginStatus {
  final String error ;
  ShopLoginErrorStatus(this.error);
}

class IseyeShow extends ShopLoginStatus {}