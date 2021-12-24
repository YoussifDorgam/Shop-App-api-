class ChangeFavouriteModel {
  bool? status;
  String? message;

  ChangeFavouriteModel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
