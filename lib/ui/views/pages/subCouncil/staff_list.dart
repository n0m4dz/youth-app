import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youth/core/contants/values.dart';
import 'package:youth/core/models/staff.dart';
import 'package:youth/core/viewmodels/staff_model.dart';
import 'package:youth/ui/components/loader.dart';
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
      backgroundColor: Colors.grey[200],
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: getProportionateScreenHeight(200),
              floating: false,
              pinned: true,
              backgroundColor: Color(0xFF409EFF),
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.zero,
                centerTitle: true,
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Container(),
                    ),
                    Flexible(
                      flex: 1,
                      child: Text(
                        "Зөвлөлийн гишүүд".toUpperCase(),
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(20),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                background: Stack(
                  children: [
                    Positioned(
                      right: getProportionateScreenWidth(-50),
                      bottom: 0,
                      child: SvgPicture.asset(
                        "assets/images/svg/page-heading-legal.svg",
                        width: size.width,
                        height: size.height * getProportionateScreenWidth(.13),
                      ),
                    ),
                  ],
                ),
              ),
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
                    mainAxisSpacing: 13,
                    crossAxisSpacing: 11,
                    childAspectRatio: (itemWidth / 400),
                    physics: new NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: model.staffList.map(
                      (Staff item) {
                        return Container(
                          margin: EdgeInsets.only(top: 15),
                          padding: EdgeInsets.only(top: 15),
                          decoration: BoxDecoration(
                            color: Color(0xffF2F5FA),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: Colors.blue, width: 2),
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
                                              color: Colors.blue,
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              backgroundColor: Colors.red,
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        )
                                      : Image.network(
                                          baseUrl +
                                              "/assets/youth/images/noImage.jpg",
                                        ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        item.lastname + " \n" + item.firstname,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            width: 150,
                                            height: 35,
                                            child: Text(
                                              item.appointment,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 12.5),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Center(
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.phone,
                                            size: 16,
                                            color: Colors.blue,
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            item.phone,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 12.5),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () =>
                                                  _launchCall(item.phone),
                                              child: Container(
                                                padding: EdgeInsets.all(6),
                                                decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                child: Icon(
                                                  Icons.phone,
                                                  size: 16,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
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
