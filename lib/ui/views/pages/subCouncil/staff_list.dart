import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:youth/core/contants/values.dart';
import 'package:youth/core/models/staff.dart';
import 'package:youth/core/viewmodels/staff_model.dart';
import 'package:youth/ui/components/loader.dart';
import '../../base_view.dart';

class StaffList extends StatefulWidget {
  @override
  _StaffListState createState() => _StaffListState();
}

class _StaffListState extends State<StaffList> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width / 2;

    return BaseView<StaffModel>(
        onModelReady: (model) {
          model.getStaffList();
        },
        builder: (context, model, child) => model.loading
            ? Loader()
            : GridView.count(
                padding: EdgeInsets.all(0),
                crossAxisCount: 2,
                mainAxisSpacing: 13,
                crossAxisSpacing: 11,
                childAspectRatio: (itemWidth / 400),
                controller: new ScrollController(keepScrollOffset: false),
                shrinkWrap: true,
                children: model.staffList.map((Staff item) {
                  return Container(
                    margin: EdgeInsets.only(top: 15),
                    padding: EdgeInsets.only(top: 15),
                    decoration: BoxDecoration(
                      color: Color(0xffF2F5FA),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      children: <Widget>[
                        // Container(
                        //   height: 60,
                        //   width: 60,
                        //   decoration: BoxDecoration(
                        //     color: Colors.blue,
                        //     border: Border.all(color: Colors.blue, width: 2),
                        //     borderRadius: BorderRadius.circular(60),
                        //   ),
                        //   child: CachedNetworkImage(
                        //     imageUrl: baseUrl + item.image,
                        //     imageBuilder: (context, imageProvider) => Container(
                        //       decoration: BoxDecoration(
                        //         color: Colors.blue,
                        //         image: DecorationImage(
                        //           image: imageProvider,
                        //           fit: BoxFit.contain,
                        //         ),
                        //       ),
                        //     ),
                        //     placeholder: (context, url) => Center(
                        //       child: CircularProgressIndicator(
                        //         strokeWidth: 2,
                        //         backgroundColor: Colors.red,
                        //       ),
                        //     ),
                        //     errorWidget: (context, url, error) =>
                        //         Icon(Icons.error),
                        //   ),
                        // ),

                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  item.firstname,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.blue),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                  child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.phone,
                                    size: 16,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    item.phone,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: 12.5),
                                  ),
                                ],
                              )),
                              SizedBox(
                                height: 6,
                              ),
                              Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    // Container(
                                    //   width: 135,
                                    //   height: 50,
                                    //   child: Html(
                                    //     data: item.description.length > 40
                                    //         ? item.description
                                    //                 .substring(0, 40) +
                                    //             '...'
                                    //         : item.position,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(),
                                      // child: InkWell(
                                      //   onTap: () => {},
                                      //   child: Container(
                                      //     padding: EdgeInsets.all(6),
                                      //     decoration: BoxDecoration(
                                      //       color: Colors.grey,
                                      //       borderRadius:
                                      //           BorderRadius.circular(4),
                                      //     ),
                                      //     child: Icon(
                                      //       Icons.mail,
                                      //       size: 16,
                                      //       color: Colors.white,
                                      //     ),
                                      //   ),
                                      // ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Container(),
                                      // child: InkWell(
                                      //   onTap: () => {},
                                      //   child: Container(
                                      //     padding: EdgeInsets.all(6),
                                      //     decoration: BoxDecoration(
                                      //       color: Colors.grey,
                                      //       borderRadius:
                                      //           BorderRadius.circular(4),
                                      //     ),
                                      //     child: Icon(
                                      //       Icons.phone,
                                      //       size: 16,
                                      //       color: Colors.white,
                                      //     ),
                                      //   ),
                                      // ),
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
                }).toList()));
  }
}
