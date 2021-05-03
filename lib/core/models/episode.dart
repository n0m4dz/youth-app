class Episode {
  int id;
  int animeId;
  String title;
  String atitle;
  String image;
  String download;
  String createdAt;
  String updatedAt;
  int isFree;
  String number;
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
  String view;
  int liked;

  Episode(
      {this.id,
      this.animeId,
      this.title,
      this.atitle,
      this.image,
      this.download,
      this.createdAt,
      this.updatedAt,
      this.isFree,
      this.number,
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
      this.view,
      this.liked});

  Episode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    animeId = json['anime_id'];
    title = json['title'];
    atitle = json['atitle'];
    image = json['image'];
    download = json['download'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isFree = json['is_free'];
    number = json['number'].toString();
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
    view = json['view'];
    liked = json['liked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['anime_id'] = this.animeId;
    data['title'] = this.title;
    data['atitle'] = this.atitle;
    data['image'] = this.image;
    data['download'] = this.download;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_free'] = this.isFree;
    data['number'] = this.number;
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
    data['view'] = this.view;
    data['liked'] = this.liked;
    return data;
  }
}
