class SearchModel {
  late bool status;
  late Data data;

  SearchModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    data = Data.fromJson(json['data']);
  }
}
class Data {
  int? currentPage;
  late List<SearchProduct> data;
  String? firstPageUrl;
  int ?from;
  int ?lastPage;
  String? lastPageUrl;
  Null nextPageUrl;
  String? path;
  int ?perPage;
  Null prevPageUrl;
  int ?to;
  int ?total;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    data =  [];
    json['data'].forEach((element){data.add(SearchProduct.fromJson(element));});
    // List.generate(data!.length, (index) => FavoritesData.fromJson(json['data']));
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
  }
}

// class FavoritesData {
//   int? id;
//   Product? product;
//
//   FavoritesData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     product = Product.fromJson(json['product']);
//   }
// }

class SearchProduct {
  int? id;
  dynamic price;
  dynamic oldPrice;
  int ?discount;
  String? image;
  String ?name;
  String ?description;

  SearchProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }


}