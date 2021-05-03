class User {
  int id;
  String sessionId;
  String type;
  String rank;
  String xp;
  String nickname;
  String lastname;
  String name;
  String email;
  String phone;
  String image;
  String rememberToken;
  int role;
  String image1;
  int gender;
  String age;
  String address;
  String account;
  String paydate;
  String payexpire;
  String fbid;
  String login;
  int coin;

  User(
      {this.id,
      this.sessionId,
      this.type,
      this.rank,
      this.xp,
      this.nickname,
      this.lastname,
      this.name,
      this.email,
      this.phone,
      this.image,
      this.rememberToken,
      this.role,
      this.image1,
      this.gender,
      this.age,
      this.address,
      this.account,
      this.paydate,
      this.payexpire,
      this.fbid,
      this.login,
      this.coin});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sessionId = json['session_id'];
    type = json['type'].toString();
    rank = json['rank'].toString();
    xp = json['xp'].toString();
    nickname = json['nickname'];
    lastname = json['lastname'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    rememberToken = json['remember_token'];
    role = json['role'];
    image1 = json['image1'];
    gender = json['gender'] == null ? 0 : int.tryParse(json['gender']);
    age = json['age'] == null ? '0' : json['age'].toString();
    address = json['address'].toString();
    account = json['account'].toString();
    paydate = json['paydate'].toString();
    payexpire = json['payexpire'].toString();
    fbid = json['fbid'].toString();
    login = json['login'].toString();
    coin = json['coin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['session_id'] = this.sessionId;
    data['type'] = this.type;
    data['rank'] = this.rank;
    data['xp'] = this.xp;
    data['nickname'] = this.nickname;
    data['lastname'] = this.lastname;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['remember_token'] = this.rememberToken;
    data['role'] = this.role;
    data['image1'] = this.image1;
    data['gender'] = this.gender;
    data['age'] = this.age;
    data['address'] = this.address;
    data['account'] = this.account;
    data['paydate'] = this.paydate;
    data['payexpire'] = this.payexpire;
    data['fbid'] = this.fbid;
    data['login'] = this.login;
    data['coin'] = this.coin;
    return data;
  }
}
