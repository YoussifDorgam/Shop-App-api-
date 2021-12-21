class AddressModel {
  bool? status;
  AddressPage? data;


  AddressModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? AddressPage.fromJson(json['data']): null;
  }

}

class AddressPage {
  int? currentPage;
  List<AddressData>? data;
  String ?firstPageUrl;
  int? from;
  int? lastPage;
  String ?lastPageUrl;
  String? path;
  int ?perPage;
  int? to;
  int ?total;


  AddressPage.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data =[];
      json['data'].forEach((v) {
        data?.add(new AddressData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

}

class AddressData {
  int? id;
  String? name;
  String? city;
  String? region;
  String? details;
  String? notes;
  double? latitude;
  double ?longitude;


  AddressData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    city = json['city'];
    region = json['region'];
    details = json['details'];
    notes = json['notes'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }
}