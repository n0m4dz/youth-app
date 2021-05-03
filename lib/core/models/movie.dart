class Movie {
  int id;
  String categoryId;
  String title;
  String description;
  String image;
  String link;
  String rate;
  String createdAt;
  String updatedAt;
  String vid1;
  String vid2;
  String vid3;
  String vid4;
  String vid5;
  String emb1;
  String emb2;
  String emb3;
  String emb4;
  String emb5;
  int isPublish;
  String keywords;
  String hour;
  String director;
  int relatedAnime;
  String body;
  String releaseDate;

  Movie(
      {this.id,
      this.categoryId,
      this.title,
      this.description,
      this.image,
      this.link,
      this.rate,
      this.createdAt,
      this.updatedAt,
      this.vid1,
      this.vid2,
      this.vid3,
      this.vid4,
      this.vid5,
      this.emb1,
      this.emb2,
      this.emb3,
      this.emb4,
      this.emb5,
      this.isPublish,
      this.keywords,
      this.hour,
      this.director,
      this.relatedAnime,
      this.body,
      this.releaseDate});

  Movie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    link = json['link'];
    rate = json['rate'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    vid1 = json['vid1'];
    vid2 = json['vid2'];
    vid3 = json['vid3'];
    vid4 = json['vid4'];
    vid5 = json['vid5'];
    emb1 = json['emb1'];
    emb2 = json['emb2'];
    emb3 = json['emb3'];
    emb4 = json['emb4'];
    emb5 = json['emb5'];
    isPublish = json['is_publish'];
    keywords = json['keywords'];
    hour = json['hour'];
    director = json['director'];
    relatedAnime = json['related_anime'];
    body = json['body'];
    releaseDate = json['release_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;
    data['link'] = this.link;
    data['rate'] = this.rate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['vid1'] = this.vid1;
    data['vid2'] = this.vid2;
    data['vid3'] = this.vid3;
    data['vid4'] = this.vid4;
    data['vid5'] = this.vid5;
    data['emb1'] = this.emb1;
    data['emb2'] = this.emb2;
    data['emb3'] = this.emb3;
    data['emb4'] = this.emb4;
    data['emb5'] = this.emb5;
    data['is_publish'] = this.isPublish;
    data['keywords'] = this.keywords;
    data['hour'] = this.hour;
    data['director'] = this.director;
    data['related_anime'] = this.relatedAnime;
    data['body'] = this.body;
    data['release_date'] = this.releaseDate;
    return data;
  }
}
