import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youth/core/contants/values.dart';
import 'package:youth/core/models/staff.dart';
import 'package:youth/core/viewmodels/staff_model.dart';
import 'package:youth/ui/components/default_sliver_app_bar.dart';
import 'package:youth/ui/components/loader.dart';
import 'package:youth/ui/styles/_colors.dart';
import '../../../../size_config.dart';
import '../../base_view.dart';

class StaffList extends StatefulWidget {
  final int aimagId;

  const StaffList({Key key, this.aimagId}) : super(key: key);
  @override
  _StaffListState createState() => _StaffListState();
}

class _StaffListState extends State<StaffList> {
  _launchCall(String phone) async {
    var url = "tel:$phone";

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Can't phone that number.";
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width / 2;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            DefaultSliverAppBar(
              title: "Зөвлөлийн гишүүд",
              size: size,
              color: Color(0xFF0084b5),
              svgData: "assets/images/svg/page-heading-legal.svg",
            ),
          ];
        },
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: BaseView<StaffModel>(
            onModelReady: (model) {
              model.getStaffList(widget.aimagId);
            },
            builder: (context, model, child) => model.loading
                ? Loader()
                : GridView.count(
                    padding: EdgeInsets.all(0),
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 12,
                    childAspectRatio: (itemWidth / 410),
                    physics: new NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: model.staffList.map(
                      (Staff item) {
                        return Container(
                          margin: EdgeInsets.only(top: 15),
                          padding: EdgeInsets.only(top: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [shadow],
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: primaryColor,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(60),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(60),
                                  child: item.image != null
                                      ? CachedNetworkImage(
                                          imageUrl: baseUrl + item.image,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                          ),
                                          placeholder: (context, url) =>
                                              Container(
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                              ),
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Image.network(
                                            baseUrl +
                                                "/assets/youth/images/noImage.jpg",
                                            width: 200,
                                            fit: BoxFit.fitWidth,
                                          ),
                                        )
                                      : Container(
                                          height: 90,
                                          child: Image.network(
                                            baseUrl +
                                                "/assets/youth/images/noImage.jpg",
                                            width: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        item.lastname + "\n" + item.firstname,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Color(0xFFfcb040),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      child: Text(
                                        item.appointment != null
                                            ? item.appointment
                                            : '',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Зөвлөлийн албан тушаал:',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Color(0xFFfcb040),
                                        fontWeight: FontWeight.w100,
                                      ),
                                    ),
                                    Text(
                                      item.positionName,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ).toList(),
                  ),
          ),
        ),
      ),
    );
  }
}

String replaceWhitespacesUsingRegex(String s, String replace) {
  if (s == null) {
    return null;
  }

  // This pattern means "at least one space, or more"
  // \\s : space
  // +   : one or more
  final pattern = RegExp('\\s+');
  return s.replaceAll(pattern, replace);
}
