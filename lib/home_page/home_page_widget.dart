import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foody/backend/localModels/product_consumed.dart';
import 'package:foody/backend/localModels/product_firestore.dart';
import 'package:foody/backend/schema/products_record.dart';
import 'package:intl/intl.dart';

import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../product_details_page/product_details_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:foody/backend/localDatabase.dart';

class HomePageWidget extends StatefulWidget {
  HomePageWidget({Key key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget>
    with TickerProviderStateMixin {
  final animationsMap = {
    'textOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      duration: 500,
      fadeIn: true,
      slideOffset: Offset(5, 0),
    ),
  };
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final db = LocalDatabase();
  List<ProductFirestore> productsToday = [];
  String today;

  @override
  void initState() {
    super.initState();
    startAnimations(
      animationsMap.values
          .where((anim) => anim.trigger == AnimationTrigger.onPageLoad),
      this,
    );
    String now = DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now());
    today = now.split(" ")[0];
  }

  Future<List<ProductFirestore>> getAllConsumed() async {
    productsToday.clear();
    print("Today: " + today);
    await db
        .queryAllProductsByDate(today)
        .then((List<ProductConsumed> consumedProducts) async {
      for (ProductConsumed element in consumedProducts) {
        await ProductsRecord.collection
            .doc(element.productID)
            .get()
            .then((DocumentSnapshot snapshot) {
          productsToday.add(
            new ProductFirestore(
              int.parse(snapshot.get("barcode").toString()),
              snapshot.get("name").toString(),
              double.parse(snapshot.get("calories").toString()) * element.gramm/100,
              double.parse(snapshot.get("carbohydrates").toString()) * element.gramm/100,
              snapshot.get("description").toString(),
              double.parse(snapshot.get("fats").toString()) * element.gramm/100,
              double.parse(snapshot.get("protein").toString()) * element.gramm/100,
              double.parse(snapshot.get("sugar").toString()) * element.gramm/100,
            ),
          );
        });
      }
    });
    return productsToday;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.12),
        child: AppBar(
          backgroundColor: Color(0x00FFFFFF),
          automaticallyImplyLeading: false,
          flexibleSpace: Align(
            alignment: Alignment(0.05, 0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 1,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: Svg(
                    'assets/images/headerS.svg',
                  ),
                ),
                shape: BoxShape.rectangle,
              ),
            ),
          ),
          actions: [],
          elevation: 0,
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 40),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.keyboard_arrow_left,
                  color: Colors.black,
                  size: 30,
                ),
                Text(
                  today,
                  style: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.black,
                  size: 30,
                )
              ],
            ).animated([animationsMap['textOnPageLoadAnimation']]),
            Align(
              alignment: Alignment(0, -0.9),
              child: Text(
                'Activity',
                style: FlutterFlowTheme.title1.override(
                  fontFamily: 'Poppins',
                ),
              ).animated([animationsMap['textOnPageLoadAnimation']]),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 35, 0, 0),
              child: Material(
                color: Colors.transparent,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(3, 3, 3, 3),
                              child: Text(
                                'Results of day',
                                textAlign: TextAlign.start,
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(3, 3, 3, 3),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Weight diffrence',
                                        textAlign: TextAlign.start,
                                        style:
                                            FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        '[-kg]',
                                        style:
                                            FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: Color(0xFF509AF2),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(10, 3, 3, 3),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Tracking days',
                                        textAlign: TextAlign.start,
                                        style:
                                            FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        '[days]',
                                        style:
                                            FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: Color(0xFF509AF2),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 70,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color(0xFF509AF2),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ).animated([animationsMap['textOnPageLoadAnimation']]),
            SizedBox(
              height: 35,
            ),
            Expanded(
              child: Material(
                color: Colors.transparent,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FutureBuilder<List<ProductFirestore>>(
                    future: getAllConsumed(),
                    builder: (context,
                        AsyncSnapshot<List<ProductFirestore>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 60,
                            ),
                          );
                        } else if (snapshot.hasData) {
                          if (productsToday.isEmpty) {
                            return Center(
                              child: Text(
                                "No data",
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          } else {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: productsToday.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: InkWell(
                                    onTap: () async {
                                      await Navigator.pushAndRemoveUntil(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          duration: Duration(milliseconds: 300),
                                          reverseDuration:
                                              Duration(milliseconds: 300),
                                          child: ProductDetailsPageWidget(),
                                        ),
                                        (r) => false,
                                      );
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          productsToday[index].name,
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          productsToday[index]
                                                  .calories
                                                  .toString() +
                                              " kcal",
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        } else {
                          return Center(
                            child: Text(
                              "No data",
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }
                      } else {
                        return Center(
                          child: Text('State: ${snapshot.connectionState}'),
                        );
                      }
                    },
                  ),
                ),
              ).animated([animationsMap['textOnPageLoadAnimation']]),
            ),
          ],
        ),
      ),
    );
  }
}
