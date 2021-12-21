class AddAddressModel {
  late bool status;
  String? message;
  AddAddressData ?data;

  AddAddressModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new AddAddressData.fromJson(json['data']) : null;
  }
}

class AddAddressData {
  String? name;
  String? city;
  String? region;
  String? details;
  String? notes;
  dynamic latitude;
  dynamic longitude;
  int? id;


  AddAddressData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    city = json['city'];
    region = json['region'];
    details = json['details'];
    notes = json['notes'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    id = json['id'];
  }
}