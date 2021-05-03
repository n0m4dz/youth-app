class Video {
  int id;
  int categoryId;
  int subCategoryId;
  String title;
  String description;
  String image;
  String link;
  String download;
  String embed;
  int author;
  String deletedAt;
  String createdAt;
  String updatedAt;
  String vid1;
  String vid2;
  String vid3;
  String vid4;
  String emb1;
  String emb2;
  String emb3;
  String emb4;
  int isPublish;
  String keywords;

  Video(
      {this.id,
      this.categoryId,
      this.subCategoryId,
      this.title,
      this.description,
      this.image,
      this.link,
      this.download,
      this.embed,
      this.author,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.vid1,
      this.vid2,
      this.vid3,
      this.vid4,
      this.emb1,
      this.emb2,
      this.emb3,
      this.emb4,
      this.isPublish,
      this.keywords});

  Video.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    link = json['link'];
    download = json['download'];
    embed = json['embed'];
    author = json['author'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    vid1 = json['vid1'];
    vid2 = json['vid2'];
    vid3 = json['vid3'];
    vid4 = json['vid4'];
    emb1 = json['emb1'];
    emb2 = json['emb2'];
    emb3 = json['emb3'];
    emb4 = json['emb4'];
    isPublish = json['is_publish'];
    keywords = json['keywords'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;
    data['link'] = this.link;
    data['download'] = this.download;
    data['embed'] = this.embed;
    data['author'] = this.author;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['vid1'] = this.vid1;
    data['vid2'] = this.vid2;
    data['vid3'] = this.vid3;
    data['vid4'] = this.vid4;
    data['emb1'] = this.emb1;
    data['emb2'] = this.emb2;
    data['emb3'] = this.emb3;
    data['emb4'] = this.emb4;
    data['is_publish'] = this.isPublish;
    data['keywords'] = this.keywords;
    return data;
  }
}
