class getfavoyritedata {
  bool? status;
  bool? message;
  Data? data;

  getfavoyritedata.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = (json['data'] != null ? Data.fromJson(json['data']) : null);
  }

}

class Data {
  int? currentPage;
  List<FavouriteData> data = [];
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
    json['data'].forEach((element)
    {
      data.add(FavouriteData.fromJson(element));
    });
  }

}

class FavouriteData {
  late int id;
  Product? product;
  FavouriteData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
    (json['product'] != null ?  Product.fromJson(json['product']) : null)!;
  }

}

class Product {
  late int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;



  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }

}
