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
import 'package:youth/ui/styles/_colors.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:youth/ui/views/login.dart';
import 'package:youth/ui/views/notifications.dart';
import 'package:youth/ui/views/pages/eLearnHome.dart';
import 'package:youth/ui/views/pages/event.dart';
import 'package:youth/ui/views/pages/knowLedge.dart';
import 'package:youth/ui/views/pages/law.dart';
import 'package:youth/ui/views/pages/national_council.dart';
import 'package:youth/ui/views/pages/partTimeJob.dart';
import 'package:youth/ui/views/pages/volunteerWork.dart';
import 'package:youth/ui/views/settings.dart';
import 'package:youth/ui/views/sidebar.dart';

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
                  color: Color(0xfff2f3fa),
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
                      fontWeight: FontWeight.w500,
                      color: primaryColor,
                    ),
                  ),
                ),

                /// here we use our custom widget
                // titlePadding: EdgeInsets.zero,
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
                              builder: (context) => SettingsScreen(),
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
            childAspectRatio: (itemWidth / 195),
            physics: new NeverScrollableScrollPhysics(),
            controller: new ScrollController(keepScrollOffset: false),
            shrinkWrap: true,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VolunteerWorkPage(
                        title: 'Сайн дурын ажил',
                        subTitle: '5 сайн дурын ажил байна.',
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 90,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
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
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Сайн дурын ажил',
                                  style: TextStyle(
                                    fontSize: 14.3,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '5 сайн дурын ажил байна',
                                  style: TextStyle(
                                      fontSize: 10.7, color: Colors.white),
                                )
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
                    borderRadius: BorderRadius.circular(10),
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
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Цагийн ажил',
                                  style: TextStyle(
                                    fontSize: 14.3,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '120+ ажлын зар байна',
                                  style: TextStyle(
                                    fontSize: 10.7,
                                    color: Colors.white,
                                  ),
                                )
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
                    borderRadius: BorderRadius.circular(10),
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
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Цахим хичээл',
                                  style: TextStyle(
                                    fontSize: 14.3,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Их сургуулийн тэтгэлэг',
                                  style: TextStyle(
                                    fontSize: 10.7,
                                    color: Colors.white,
                                  ),
                                )
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
                    borderRadius: BorderRadius.circular(10),
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
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Хууль',
                                  style: TextStyle(
                                    fontSize: 14.3,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '10+ сургалтын зар байна',
                                  style: TextStyle(
                                    fontSize: 10.7,
                                    color: Colors.white,
                                  ),
                                )
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
                    borderRadius: BorderRadius.circular(10),
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
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Мэдээ',
                                  style: TextStyle(
                                    fontSize: 14.3,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Хууль эрх зүйн мэдлэг',
                                  style: TextStyle(
                                    fontSize: 10.7,
                                    color: Colors.white,
                                  ),
                                )
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
                      builder: (context) => EventPage(title: 'Арга Хэмжээ'),
                    ),
                  );
                },
                child: Container(
                  height: 90,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
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
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Эвэнт',
                                  style: TextStyle(
                                    fontSize: 14.3,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Эрүүл мэнд, гэр бүл',
                                  style: TextStyle(
                                    fontSize: 10.7,
                                    color: Colors.white,
                                  ),
                                )
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
                      builder: (context) => NationalCouncilPage(
                          title: 'Залуучууд Хөгжлийн Үндэсний зөвлөл'),
                    ),
                  );
                },
                child: Container(
                  height: 90,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [shadow],
                  ),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        alignment: Alignment.topCenter,
                        // child: SvgPicture.asset(
                        //   'assets/images/svg/menu-event.svg',
                        //   width: 70,
                        //   height: 70,
                        //   color: Color(0xFF38ada9),
                        // ),
                        child: Image.asset(
                          'assets/images/zxvz.png',
                          width: 70,
                          height: 70,
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
                              color: Color(0xFF38ada9),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'ЗХҮЗ',
                                  style: TextStyle(
                                    fontSize: 14.3,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'салбар зөвлөл',
                                  style: TextStyle(
                                    fontSize: 10.7,
                                    color: Colors.white,
                                  ),
                                )
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
                onTap: () {},
                child: Container(
                  height: 90,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [shadow],
                  ),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        alignment: Alignment.topCenter,
                        // child: SvgPicture.asset(
                        //   'assets/images/logo_zxz.png',
                        //   width: 70,
                        //   height: 70,
                        //   color: Color(0xFFfa983a),
                        // ),
                        child: Image.asset(
                          'assets/images/logo_zxz.png',
                          width: 70,
                          height: 70,
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
                              color: Color(0xFFfa983a),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'ЗХЗ',
                                  style: TextStyle(
                                    fontSize: 14.3,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Залуучууд хөгжлийн зөвлөл',
                                  style: TextStyle(
                                    fontSize: 10.7,
                                    color: Colors.white,
                                  ),
                                )
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

class DynamicFlexibleSpaceBarTitle extends StatefulWidget {
  /// this widget changing bottom padding of title according scrollposition of flexible space

  /// child which will be displayed as title
  @required
  final Widget child;

  DynamicFlexibleSpaceBarTitle({this.child});

  @override
  State<StatefulWidget> createState() => _DynamicFlexibleSpaceBarTitleState();
}

class _DynamicFlexibleSpaceBarTitleState
    extends State<DynamicFlexibleSpaceBarTitle> {
  ScrollPosition _position;
  double _leftPadding = 30;

  /// default padding
  double _bottomPadding = 0;

  @override
  void dispose() {
    _removeListener();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _removeListener();
    _addListener();
    super.didChangeDependencies();
  }

  void _addListener() {
    _position = Scrollable.of(context)?.position;
    _position?.addListener(_positionListener);
    _positionListener();
  }

  void _removeListener() => _position?.removeListener(_positionListener);

  void _positionListener() {
    /// when scroll position changes widget will be rebuilt
    final FlexibleSpaceBarSettings settings =
        context.dependOnInheritedWidgetOfExactType();
    setState(() {
      _leftPadding = getPadding(settings.minExtent.toInt(),
          settings.maxExtent.toInt(), settings.currentExtent.toInt());
      _bottomPadding = getPaddingBottom(settings.minExtent.toInt(),
          settings.maxExtent.toInt(), settings.currentExtent.toInt());
    });
  }

  double getPadding(int minExtent, int maxExtent, int currentExtent) {
    double onePaddingExtent = (maxExtent - minExtent) / 31;

    /// onePaddingExtent stands for 1 logical pixel of padding, 17 = count of numbers in range from 0 to 16
    /// when currentExtent changes the padding smoothly change
    if (currentExtent >= minExtent &&
        currentExtent <= minExtent + (1 * onePaddingExtent))
      return 29;
    else if (currentExtent > minExtent + (1 * onePaddingExtent) &&
        currentExtent <= minExtent + (2 * onePaddingExtent))
      return 28;
    else if (currentExtent > minExtent + (2 * onePaddingExtent) &&
        currentExtent <= minExtent + (3 * onePaddingExtent))
      return 27;
    else if (currentExtent > minExtent + (3 * onePaddingExtent) &&
        currentExtent <= minExtent + (4 * onePaddingExtent))
      return 26;
    else if (currentExtent > minExtent + (4 * onePaddingExtent) &&
        currentExtent <= minExtent + (5 * onePaddingExtent))
      return 25;
    else if (currentExtent > minExtent + (5 * onePaddingExtent) &&
        currentExtent <= minExtent + (6 * onePaddingExtent))
      return 24;
    else if (currentExtent > minExtent + (6 * onePaddingExtent) &&
        currentExtent <= minExtent + (7 * onePaddingExtent))
      return 23;
    else if (currentExtent > minExtent + (7 * onePaddingExtent) &&
        currentExtent <= minExtent + (8 * onePaddingExtent))
      return 22;
    else if (currentExtent > minExtent + (8 * onePaddingExtent) &&
        currentExtent <= minExtent + (9 * onePaddingExtent))
      return 21;
    else if (currentExtent > minExtent + (9 * onePaddingExtent) &&
        currentExtent <= minExtent + (10 * onePaddingExtent))
      return 20;
    else if (currentExtent > minExtent + (10 * onePaddingExtent) &&
        currentExtent <= minExtent + (11 * onePaddingExtent))
      return 19;
    else if (currentExtent > minExtent + (11 * onePaddingExtent) &&
        currentExtent <= minExtent + (12 * onePaddingExtent))
      return 18;
    else if (currentExtent > minExtent + (12 * onePaddingExtent) &&
        currentExtent <= minExtent + (13 * onePaddingExtent))
      return 17;
    else if (currentExtent > minExtent + (13 * onePaddingExtent) &&
        currentExtent <= minExtent + (14 * onePaddingExtent))
      return 16;
    else if (currentExtent > minExtent + (14 * onePaddingExtent) &&
        currentExtent <= minExtent + (15 * onePaddingExtent))
      return 15;
    else if (currentExtent > minExtent + (15 * onePaddingExtent) &&
        currentExtent <= minExtent + (16 * onePaddingExtent))
      return 14;
    else if (currentExtent > minExtent + (16 * onePaddingExtent) &&
        currentExtent <= minExtent + (17 * onePaddingExtent))
      return 13;
    else if (currentExtent > minExtent + (17 * onePaddingExtent) &&
        currentExtent <= minExtent + (18 * onePaddingExtent))
      return 12;
    else if (currentExtent > minExtent + (18 * onePaddingExtent) &&
        currentExtent <= minExtent + (19 * onePaddingExtent))
      return 11;
    else if (currentExtent > minExtent + (19 * onePaddingExtent) &&
        currentExtent <= minExtent + (20 * onePaddingExtent))
      return 10;
    else if (currentExtent > minExtent + (20 * onePaddingExtent) &&
        currentExtent <= minExtent + (21 * onePaddingExtent))
      return 9;
    else if (currentExtent > minExtent + (21 * onePaddingExtent) &&
        currentExtent <= minExtent + (22 * onePaddingExtent))
      return 8;
    else if (currentExtent > minExtent + (22 * onePaddingExtent) &&
        currentExtent <= minExtent + (23 * onePaddingExtent))
      return 7;
    else if (currentExtent > minExtent + (23 * onePaddingExtent) &&
        currentExtent <= minExtent + (24 * onePaddingExtent))
      return 6;
    else if (currentExtent > minExtent + (24 * onePaddingExtent) &&
        currentExtent <= minExtent + (25 * onePaddingExtent))
      return 5;
    else if (currentExtent > minExtent + (25 * onePaddingExtent) &&
        currentExtent <= minExtent + (26 * onePaddingExtent))
      return 4;
    else if (currentExtent > minExtent + (26 * onePaddingExtent) &&
        currentExtent <= minExtent + (27 * onePaddingExtent))
      return 3;
    else if (currentExtent > minExtent + (27 * onePaddingExtent) &&
        currentExtent <= minExtent + (28 * onePaddingExtent))
      return 2;
    else if (currentExtent > minExtent + (28 * onePaddingExtent) &&
        currentExtent <= minExtent + (29 * onePaddingExtent))
      return 1;
    else if (currentExtent > minExtent + (29 * onePaddingExtent) &&
        currentExtent <= minExtent + (30 * onePaddingExtent))
      return 0;
    else
      return 0;
  }

  double getPaddingBottom(int minExtent, int maxExtent, int currentExtent) {
    double onePaddingExtent = (maxExtent - minExtent) / 20;

    /// onePaddingExtent stands for 1 logical pixel of padding, 17 = count of numbers in range from 0 to 16
    /// when currentExtent changes the padding smoothly change
    if (currentExtent >= minExtent &&
        currentExtent <= minExtent + (1 * onePaddingExtent))
      return 4;
    else if (currentExtent > minExtent + (1 * onePaddingExtent) &&
        currentExtent <= minExtent + (2 * onePaddingExtent))
      return 5;
    else if (currentExtent > minExtent + (2 * onePaddingExtent) &&
        currentExtent <= minExtent + (3 * onePaddingExtent))
      return 6;
    else if (currentExtent > minExtent + (3 * onePaddingExtent) &&
        currentExtent <= minExtent + (4 * onePaddingExtent))
      return 7;
    else if (currentExtent > minExtent + (4 * onePaddingExtent) &&
        currentExtent <= minExtent + (5 * onePaddingExtent))
      return 8;
    else if (currentExtent > minExtent + (5 * onePaddingExtent) &&
        currentExtent <= minExtent + (6 * onePaddingExtent))
      return 9;
    else if (currentExtent > minExtent + (6 * onePaddingExtent) &&
        currentExtent <= minExtent + (7 * onePaddingExtent))
      return 10;
    else if (currentExtent > minExtent + (7 * onePaddingExtent) &&
        currentExtent <= minExtent + (8 * onePaddingExtent))
      return 11;
    else if (currentExtent > minExtent + (8 * onePaddingExtent) &&
        currentExtent <= minExtent + (9 * onePaddingExtent))
      return 12;
    else if (currentExtent > minExtent + (9 * onePaddingExtent) &&
        currentExtent <= minExtent + (10 * onePaddingExtent))
      return 13;
    else if (currentExtent > minExtent + (10 * onePaddingExtent) &&
        currentExtent <= minExtent + (11 * onePaddingExtent))
      return 14;
    else if (currentExtent > minExtent + (11 * onePaddingExtent) &&
        currentExtent <= minExtent + (12 * onePaddingExtent))
      return 15;
    else if (currentExtent > minExtent + (12 * onePaddingExtent) &&
        currentExtent <= minExtent + (13 * onePaddingExtent))
      return 16;
    else if (currentExtent > minExtent + (13 * onePaddingExtent) &&
        currentExtent <= minExtent + (14 * onePaddingExtent))
      return 17;
    else if (currentExtent > minExtent + (14 * onePaddingExtent) &&
        currentExtent <= minExtent + (15 * onePaddingExtent))
      return 18;
    else if (currentExtent > minExtent + (15 * onePaddingExtent) &&
        currentExtent <= minExtent + (16 * onePaddingExtent))
      return 19;
    else if (currentExtent > minExtent + (16 * onePaddingExtent) &&
        currentExtent <= minExtent + (17 * onePaddingExtent))
      return 20;
    else
      return 20;
  }

  @override
  Widget build(BuildContext context) => Padding(
      padding: EdgeInsets.only(left: _leftPadding, bottom: _bottomPadding),
      child: widget.child);
}
