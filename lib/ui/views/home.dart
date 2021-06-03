import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lambda/modules/network_util.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youth/core/contants/values.dart';
import 'package:youth/core/models/user.dart';
import 'package:youth/core/viewmodels/user_model.dart';
import 'package:youth/ui/components/dynamic_flexible_spacebar_title.dart';
import 'package:youth/ui/styles/_colors.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:youth/ui/views/login.dart';
import 'package:youth/ui/views/notifications.dart';
import 'package:youth/ui/views/pages/VolunteerWork/volunteer_work.dart';
import 'package:youth/ui/views/pages/eLearnHome.dart';
import 'package:youth/ui/views/pages/event/event_page.dart';
import 'package:youth/ui/views/pages/knowLedge.dart';
import 'package:youth/ui/views/pages/law.dart';

import 'package:youth/ui/views/pages/partTimeJob.dart';
import 'package:youth/ui/views/profile.dart';
import 'package:youth/ui/views/settings.dart';
import 'package:youth/ui/views/sidebar.dart';

import 'package:youth/ui/views/pages/national_council.dart';
import 'package:youth/ui/views/pages/YouthCouncil/youth_council_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  // final GlobalKey<FormState> _searchFormKey = GlobalKey<FormState>();
  User user;
  SharedPreferences _prefs;
  Map<String, dynamic> contact;
  NetworkUtil _http = new NetworkUtil();

  Future getContactList() async {
    var url = baseUrl + '/mobile/api/getContact';
    var response = await _http.get(url);
    contact = json.decode(response.toString());
    print(contact);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getContactList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width / 2;
    final userState = Provider.of<UserModel>(context);
    user = userState.getUser;

    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        elevation: 0,
        child: SidebarScreen(contact: contact),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 150,
              pinned: true,
              backgroundColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  color: bgColor,
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 10.0,
                        left: 7,
                        child: Text(
                          'Залуучуудыг дэмжих хөтөлбөр',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: textColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                title: DynamicFlexibleSpaceBarTitle(
                  child: Text(
                    'Залуу хүн',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: primaryColor,
                    ),
                  ),
                ),
                titlePadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
              ),
              leading: IconButton(
                onPressed: () {
                  _scaffoldKey.currentState.openDrawer();
                },
                icon: Icon(
                  Icons.menu,
                  color: primaryColor,
                ),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => NotificationsScreen(),
                        ),
                      );
                    },
                    child: Icon(
                      Ionicons.getIconData('ios-notifications-outline'),
                      size: 31,
                      color: primaryColor,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: GestureDetector(
                    onTap: () {
                      print('------user');
                      print(user);

                      if (user == null) {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      } else {
                        if (_prefs == null
                            ? false
                            : _prefs.getBool("is_auth") == false) {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              //builder: (context) => SettingsScreen(),
                              builder: (context) => ProfileScreen(),
                            ),
                          );
                        }
                      }
                    },
                    child: Icon(
                      Ionicons.getIconData('ios-contact'),
                      size: 31,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ];
        },
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          child: GridView.count(
            padding: EdgeInsets.only(top: 0, bottom: 10, left: 15, right: 15),
            crossAxisCount: 2,
            mainAxisSpacing: 13,
            crossAxisSpacing: 13,
            childAspectRatio: (itemWidth / 185),
            physics: new NeverScrollableScrollPhysics(),
            controller: new ScrollController(keepScrollOffset: false),
            shrinkWrap: true,
            children: [
              // HomeCategoryItem(
              //   primaryColor: Color(0xFF409EFF),
              //   primaryIcon: "assets/images/svg/menu-zxz.svg",
              //   primaryTitle: "Залуучууд хөгжлийн үндэсний зөвлөл",
              // ),
              // HomeCategoryItem(
              //   primaryColor: Color(0xFFfa983a),
              //   primaryIcon: "assets/images/svg/menu-zxz.svg",
              //   primaryTitle: "Залуучууд хөгжлийн зөвлөл",
              // ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          YouthCouncilPage(title: 'Залуучууд Хөгжлийн зөвлөл'),
                    ),
                  );
                },
                child: Container(
                  height: 90,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [shadow],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        child: Image.network(
                          baseUrl + "/assets/youth/splash/logo-zhz.jpg",
                          alignment: Alignment.topCenter,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Залуучууд Хөгжлийн Зөвлөл',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFa01e66),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NationalCouncilPage(
                          title: 'Залуучууд Хөгжлийн Үндэсний зөвлөл'),
                    ),
                  );
                },
                child: Container(
                  height: 90,
                  //padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [shadow],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 10),
                      Container(
                        width: 90,
                        height: 90,
                        child: Image.network(
                          baseUrl + "/assets/youth/splash/logo-uz-ok.jpg",
                          alignment: Alignment.topCenter,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Залуучууд Хөгжлийн Үндэсний зөвлөл',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF283890),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VolunteerWorks(
                        title: 'Сайн дурын ажил',
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 90,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [shadow],
                  ),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topCenter,
                        margin: EdgeInsets.only(top: 20),
                        child: SvgPicture.asset(
                          'assets/images/svg/menu-volunteer.svg',
                          width: 70,
                          height: 70,
                          color: Color(0xFF4323a7),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 4, bottom: 4, right: 3, left: 4),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Color(0xFF55438c),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Сайн дурын ажил',
                                  style: TextStyle(
                                    fontSize: 13.8,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                // Text(
                                //   '5 сайн дурын ажил байна',
                                //   style: TextStyle(
                                //       fontSize: 10.7, color: Colors.white),
                                // )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PartTimeJobPage(title: 'Цагийн ажил'),
                    ),
                  );
                },
                child: Container(
                  height: 90,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [shadow],
                  ),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        alignment: Alignment.topCenter,
                        child: SvgPicture.asset(
                          'assets/images/svg/menu-parttime.svg',
                          width: 70,
                          height: 70,
                          color: Color(0xFF128348),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 4, bottom: 4, right: 3, left: 4),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Color(0xFF02b557),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Цагийн ажил',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                // Text(
                                //   '120+ ажлын зар байна',
                                //   style: TextStyle(
                                //     fontSize: 10.7,
                                //     color: Colors.white,
                                //   ),
                                // )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ELearnHomePage(title: 'Цахим хичээл'),
                    ),
                  );
                },
                child: Container(
                  height: 90,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [shadow],
                  ),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        alignment: Alignment.topCenter,
                        child: SvgPicture.asset(
                          'assets/images/svg/menu-lesson.svg',
                          width: 70,
                          height: 70,
                          color: Color(0xFF5f58CC),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 4, bottom: 4, right: 3, left: 4),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Color(0xFF7068fc),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Цахим хичээл',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                // Text(
                                //   'Их сургуулийн тэтгэлэг',
                                //   style: TextStyle(
                                //     fontSize: 10.7,
                                //     color: Colors.white,
                                //   ),
                                // )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LawPage(title: 'Хууль'),
                    ),
                  );
                },
                child: Container(
                  height: 90,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [shadow],
                  ),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        alignment: Alignment.topCenter,
                        child: SvgPicture.asset(
                          'assets/images/svg/menu-legal.svg',
                          width: 70,
                          height: 70,
                          color: Color(0xFF992d34),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 4, bottom: 4, right: 3, left: 4),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Color(0xFFd63e49),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Хууль',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                // Text(
                                //   '10+ сургалтын зар байна',
                                //   style: TextStyle(
                                //     fontSize: 10.7,
                                //     color: Colors.white,
                                //   ),
                                // )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          KnowLedgePage(title: 'Мэдлэг, Мэдээлэл'),
                    ),
                  );
                },
                child: Container(
                  height: 90,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [shadow],
                  ),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        alignment: Alignment.topCenter,
                        child: SvgPicture.asset(
                          'assets/images/svg/menu-news.svg',
                          width: 70,
                          height: 70,
                          color: Color(0xFF576574),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 4, bottom: 4, right: 3, left: 4),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Color(0xFF7e8c9c),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Мэдээ',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                // Text(
                                //   'Хууль эрх зүйн мэдлэг',
                                //   style: TextStyle(
                                //     fontSize: 10.7,
                                //     color: Colors.white,
                                //   ),
                                // )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventPage(
                        title: 'Арга Хэмжээ',
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 90,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [shadow],
                  ),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        alignment: Alignment.topCenter,
                        child: SvgPicture.asset(
                          'assets/images/svg/menu-event.svg',
                          width: 70,
                          height: 70,
                          color: Color(0xFFcba822),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 4, bottom: 4, right: 3, left: 4),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Color(0xFFd9bc4c),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Эвэнт',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                // Text(
                                //   'Эрүүл мэнд, гэр бүл',
                                //   style: TextStyle(
                                //     fontSize: 10.7,
                                //     color: Colors.white,
                                //   ),
                                // )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class HomeCategoryItem extends StatefulWidget {
  Color primaryColor;
  String primaryIcon;
  String primaryTitle;

  HomeCategoryItem({
    this.primaryColor,
    this.primaryIcon,
    this.primaryTitle,
  });

  @override
  _HomeCategoryItemState createState() => _HomeCategoryItemState();
}

class _HomeCategoryItemState extends State<HomeCategoryItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: widget.primaryColor.withOpacity(0.4),
              blurRadius: 10,
              offset: Offset(0.0, 6))
        ],
        color: widget.primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      widget.primaryIcon,
                      height: 50,
                      color: Colors.white,
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        widget.primaryTitle,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
