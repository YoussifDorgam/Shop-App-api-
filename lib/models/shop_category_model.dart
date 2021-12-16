class CategoryModel {
  bool? status;
  CategoriesData? data;

  CategoryModel.formjson(Map<String, dynamic> json) {
    status = json['status'];
    data = CategoriesData.fromjson(json['data']);
  }
}

class CategoriesData {
  int? current_page;
  List<Data> data = [];

  CategoriesData.fromjson(Map<String, dynamic> json) {
    current_page = json['current_page'];
    json['data'].forEach((e) {
      data.add(Data.fromjson(e));
    });
  }
}

class Data {
  int? id;

  String? name;

  String? image;

  Data.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
