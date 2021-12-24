class ShopLoginModel {
  bool? status;
  String? message;
  Userdata? data;

  ShopLoginModel.formjson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Userdata.formjson(json['data']) : null;
  }
}

class Userdata {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  String? token;

  Userdata.formjson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    token = json['token'];
  }
}
