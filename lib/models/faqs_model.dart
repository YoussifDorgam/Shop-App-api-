class FAQsModel {
  bool? status;
  FAQsPageData? data;


  FAQsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? FAQsPageData.fromJson(json['data']) : null;
  }
}

class FAQsPageData {
  int? currentPage;
  List<FAQsData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String ?lastPageUrl;
  String ?path;
  int? perPage;
  int? to;
  int? total;


  FAQsPageData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(new FAQsData.fromJson(v));
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

class FAQsData {
  int? id;
  String? question;
  String ?answer;


  FAQsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
  }
}