import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lambda/modules/agent/agent_util.dart';
import 'package:youth/core/constants/values.dart';
import 'package:youth/core/models/user.dart';
import 'package:youth/ui/components/bottom_modal.dart';
import 'package:lambda/modules/network_util.dart';
import 'package:lambda/modules/responseModel.dart';
import 'package:provider/provider.dart';
import 'package:youth/core/viewmodels/user_model.dart';
import 'package:youth/ui/components/header-back.dart';
import 'package:youth/ui/styles/_colors.dart';
import 'package:youth/ui/views/settings.dart';

import '../../locator.dart';
import 'notifications.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AgentUtil agentUtil = new AgentUtil();
  NetworkUtil _http = locator<NetworkUtil>();
  ResponseModel _response = ResponseModel.fromError();
  final GlobalKey<FormState> _profileFormKey = GlobalKey<FormState>();
  Map<String, dynamic> item;

  User user;
  bool loading = false;
  bool success = false;
  File image;
  String avatarPath;
  String nickname;
  String phone;
  String age;
  int gender;
  bool isNetworkImage = true;

  Future<void> get updateProfile async {
    setState(() {
      loading = true;
    });
    final form = this._profileFormKey.currentState;
    form.save();

    FormData formData = new FormData.fromMap({
      "avatar": user.avatar,
      "nickname": nickname,
      "phone": phone,
      "gender": gender,
      "age": age,
      "file": image.path != null
          ? await MultipartFile.fromFile(image.path,
              filename: "${user.id}-avatar.jpg")
          : null,
    });

    _response =
        await _http.post('/api/mobile/update/profile/${user.id}', formData);

    final userState = Provider.of<UserModel>(context);
    user = new User.fromJson(_response.data);
    print(_response);
    userState.setUser(user);

    await Future.delayed(Duration(milliseconds: 1500));
    setState(() {
      loading = false;
      success = true;
    });

    await Future.delayed(Duration(milliseconds: 1500));

    setState(() {
      success = false;
    });
  }

  Future getImage(String type) async {
    // image = await ImagePicker.pickImage(
    //     source: type == 'camera' ? ImageSource.camera : ImageSource.gallery);

    setState(() {
      isNetworkImage = false;
      this.getAvatarThumb();
      avatarPath = image.path;
    });
  }

  Future getItemList() async {
    var url = baseUrl + '/api/mobile/profile/1608230016';
    var response = await _http.get(url);

    item = response.data;
    print(response.data);

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getItemList();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      setState(() {
        gender = user.gender as int;
        //avatarPath = user.image;
      });
    });
  }

  Widget getAvatarThumb() {
    if (isNetworkImage) {
      var urlPattern =
          r"(https?|http)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
      var match =
          new RegExp(urlPattern, caseSensitive: false).firstMatch(avatarPath);

      if (match == null) {
        return CircleAvatar(
          radius: 70,
          backgroundImage: NetworkImage(baseUrl + avatarPath),
        );
      }

      return CircleAvatar(
        radius: 70,
        backgroundImage: NetworkImage(avatarPath),
      );
    } else {
      return CircleAvatar(
        radius: 70,
        backgroundImage: AssetImage(avatarPath),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userState = Provider.of<UserModel>(context);
    user = userState.getUser;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: HeaderBack(
          title: 'Миний булан',
          reversed: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 30),
          child: Column(
            children: [
              ProfilePicture(
                  profilePicture: item['profile_image'] != null
                      ? baseUrl + item['profile_image']
                      : baseUrl + "/assets/youth/images/noImage.jpg"),
              SizedBox(height: 20),
              ProfileMenu(
                fieldType: " Ургийн овог:",
                text: item['surname'] != null ? item['surname'] : '',
              ),
              ProfileMenu(
                fieldType: "Овог:",
                text: item['last_name'] != null ? item['last_name'] : '',
              ),
              ProfileMenu(
                fieldType: "Нэр:",
                text: item['first_name'] != null ? item['first_name'] : '',
              ),
              ProfileMenu(
                fieldType: "Нэвтрэх нэр:",
                text: item['phone'] != null ? item['phone'] : '',
              ),
              ProfileMenu(
                fieldType: "Регистр:",
                text: item['register'] != null ? item['register'] : '',
              ),
              ProfileMenu(
                fieldType: "Утас:",
                text: item['phone'] != null ? item['phone'] : '',
              ),

              // Container(
              //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              //   decoration: BoxDecoration(
              //     boxShadow: [shadow],
              //   ),
              //   child: FlatButton(
              //     padding: EdgeInsets.all(20),
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(15)),
              //     color: Color(0xFFF5F6F9),
              //     onPressed: () async {
              //       await agentUtil.logout();
              //       Navigator.pushReplacementNamed(context, '/main');
              //     },
              //     child: Row(
              //       children: [
              //         SvgPicture.asset(
              //           "assets/images/svg/Log out.svg",
              //           width: 15,
              //           color: primaryColor,
              //         ),
              //         SizedBox(width: 20),
              //         Expanded(
              //           child: Text(
              //             "Гарах",
              //             style: Theme.of(context).textTheme.bodyText1,
              //           ),
              //         ),
              //         Icon(
              //           Icons.arrow_forward_ios,
              //           size: 15,
              //         )
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  void showPickImageModal(context) {
    showBottomModal(
      context: context,
      builder: (builder) {
        return Container(
          height: 200,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              padding: EdgeInsets.only(top: 33),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 110,
                    width: 120,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xFF0074f2),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8)),
                    child: FlatButton(
                      onPressed: () => getImage('camera'),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Feather.getIconData('camera'),
                            size: 30,
                            color: Color(0xFF0074f2),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Камер',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF0074f2),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 36,
                  ),
                  Container(
                    height: 110,
                    width: 120,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xFF0074f2),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8)),
                    child: FlatButton(
                      onPressed: () => getImage('gallery'),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Feather.getIconData('image'),
                            size: 30,
                            color: Color(0xFF0074f2),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Зургийн галлерей',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF0074f2),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key key,
    @required this.fieldType,
    @required this.text,
  }) : super(key: key);

  final String fieldType, text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        boxShadow: [shadow],
      ),
      child: FlatButton(
        padding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Color(0xFFF5F6F9),
        onPressed: () {},
        child: Row(
          children: [
            Text(
              fieldType,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(width: 20),
            Text(
              text,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    Key key,
    this.profilePicture,
  }) : super(key: key);

  final String profilePicture;

  @override
  Widget build(BuildContext context) {
    print(profilePicture);
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        overflow: Overflow.visible,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(profilePicture),
          ),
          // Positioned(
          //   bottom: 0,
          //   right: -12,
          //   child: SizedBox(
          //     width: 46,
          //     height: 46,
          //     child: FlatButton(
          //       padding: EdgeInsets.zero,
          //       shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(50),
          //           side: BorderSide(color: Colors.white)),
          //       color: Color(0xFFF5F6F9),
          //       onPressed: () {},
          //       child: SvgPicture.asset("assets/images/svg/Camera Icon.svg"),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
