class ChangeCartModel {
  bool? status;
  String? message;

  ChangeCartModel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
