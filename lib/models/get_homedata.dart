class ProductDetailsModel {
  bool? status;
  ProductDetailsData ?data;

  ProductDetailsModel.fromJson(Map<dynamic, dynamic> json) {
    status = json['status'];
    data =  ProductDetailsData.fromJson(json['data'] );
  }

}

class ProductDetailsData {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String ?description;
  bool? inFavorites;
  bool ?inCart;
  List<String> ?images;



  ProductDetailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
    images = json['images'];

  }
}
