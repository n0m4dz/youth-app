class Anime {
  int id;
  String categoryId;
  String actorsId;
  String title;
  String shortdescription;
  String description;
  String image;
  String image1;
  String rate;
  int author;
  int likes;
  int views;
  int isCompleted;
  String createdAt;
  String keywords;
  String animethisseason;
  int year;
  String trailer;
  String related;
  int bannerId;

  Anime(
      {this.id,
      this.categoryId,
      this.actorsId,
      this.title,
      this.shortdescription,
      this.description,
      this.image,
      this.image1,
      this.rate,
      this.author,
      this.likes,
      this.views,
      this.isCompleted,
      this.createdAt,
      this.keywords,
      this.animethisseason,
      this.year,
      this.trailer,
      this.related,
      this.bannerId});

  Anime.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    actorsId = json['actors_id'];
    title = json['title'];
    shortdescription = json['shortdescription'];
    description = json['description'];
    image = json['image'];
    image1 = json['image1'];
    rate = json['rate'].toString();
    author = json['author'];
    likes = json['likes'];
    views = json['views'];
    isCompleted = json['is_completed'];
    createdAt = json['created_at'];
    keywords = json['keywords'];
    animethisseason = json['animethisseason'];
    year = json['year'];
    trailer = json['trailer'];
    related = json['related'].toString();
    bannerId = json['banner_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['actors_id'] = this.actorsId;
    data['title'] = this.title;
    data['shortdescription'] = this.shortdescription;
    data['description'] = this.description;
    data['image'] = this.image;
    data['image1'] = this.image1;
    data['rate'] = this.rate;
    data['author'] = this.author;
    data['likes'] = this.likes;
    data['views'] = this.views;
    data['is_completed'] = this.isCompleted;
    data['created_at'] = this.createdAt;
    data['keywords'] = this.keywords;
    data['animethisseason'] = this.animethisseason;
    data['year'] = this.year;
    data['trailer'] = this.trailer;
    data['related'] = this.related;
    data['banner_id'] = this.bannerId;
    return data;
  }
}
