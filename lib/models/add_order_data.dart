class AddOrderModel {
  late bool status;
  late String message;

  AddOrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}

class CancelOrderModel {
  late bool status;
  late String message;

  CancelOrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}

class GetOrderModel {
  late bool status;
  late GetOrdersData data;

  GetOrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = GetOrdersData.fromJson(json['data']);
  }
}

class GetOrdersData {
  late int totalOrders;
  List<GetOrderData> data = [];

  GetOrdersData.fromJson(Map<String, dynamic> json) {
    totalOrders = json['total'];
    data =
        List.from(json['data']).map((e) => GetOrderData.fromJson(e)).toList();
    data.sort((a, b) => b.status.compareTo(a.status));
  }
}

class GetOrderData {
  late int id;
  late dynamic total;
  late String date;
  late String status;

  GetOrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    total = json['total'];
    date = json['date'];
    status = json['status'];
  }
}

class OrderDetailsModel {
  late bool status;
  late OrderDetailsData data;

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = OrderDetailsData.fromJson(json['data']);
  }
}

class OrderDetailsData {
  late int id;
  late dynamic cost;
  late dynamic vat;
  late dynamic total;
  late String date;
  late String status;
  late String paymentMethod;

  OrderDetailsData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    cost = json["cost"];
    vat = json["vat"];
    total = json["total"];
    paymentMethod = json["payment_method"];
    date = json["date"];
    status = json["status"];
  }
}
