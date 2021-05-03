class Faq {
  int id;
  String title;
  String content;
  String createdAt;

  Faq({this.id, this.title, this.content, this.createdAt});

  Faq.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['created_at'] = this.createdAt;
    return data;
  }
}
