import 'dart:collection';

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
import 'package:percent_indicator/percent_indicator.dart';

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
  Map<String, List<ProductFirestore>> productsByDay = {};
  String today;
  String currentDay;
  String displayedCurrentDay;
  int daysLoaded = 5;
  int dayMoveHelper = 0;

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
    currentDay = today;
    displayedCurrentDay = DateFormat("dd.MM.yyyy").format(DateTime.now());
  }

  Future<Map<String, List<ProductFirestore>>> fillCalender() async {
    productsByDay[today] = await getAllConsumed();
    for (int i = 0; i <= daysLoaded; i++) {
      String day = DateFormat("yyyy-MM-dd hh:mm:ss")
          .format(DateTime.now().subtract(Duration(days: i)))
          .split(" ")[0];
      productsByDay[day] = await getAllConsumedByDate(day);
    }
    productsByDay.forEach((key, value) {
      print(key + "------------------------------");
    });
    return productsByDay;
  }

  Future<List<ProductFirestore>> getAllConsumedByDate(
      String dayOfConsumtion) async {
    await db
        .queryAllProductsByDate(dayOfConsumtion)
        .then((List<ProductConsumed> consumedProducts) async {
      for (ProductConsumed element in consumedProducts) {
        await ProductsRecord.collection
            .doc(element.productID)
            .get()
            .then((DocumentSnapshot snapshot) {
          productsByDay[dayOfConsumtion] = [];
          productsByDay[dayOfConsumtion].add(
            new ProductFirestore(
              int.parse(snapshot.get("barcode").toString()),
              snapshot.get("name").toString(),
              double.parse(snapshot.get("calories").toString()) *
                  element.gramm /
                  100,
              double.parse(snapshot.get("carbohydrates").toString()) *
                  element.gramm /
                  100,
              snapshot.get("description").toString(),
              double.parse(snapshot.get("fats").toString()) *
                  element.gramm /
                  100,
              double.parse(snapshot.get("protein").toString()) *
                  element.gramm /
                  100,
              double.parse(snapshot.get("sugar").toString()) *
                  element.gramm /
                  100,
            ),
          );
        });
      }
    });
    return productsByDay[dayOfConsumtion];
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
              double.parse(snapshot.get("calories").toString()) *
                  element.gramm /
                  100,
              double.parse(snapshot.get("carbohydrates").toString()) *
                  element.gramm /
                  100,
              snapshot.get("description").toString(),
              double.parse(snapshot.get("fats").toString()) *
                  element.gramm /
                  100,
              double.parse(snapshot.get("protein").toString()) *
                  element.gramm /
                  100,
              double.parse(snapshot.get("sugar").toString()) *
                  element.gramm /
                  100,
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
      body: FutureBuilder<Map<String, List<ProductFirestore>>>(
        future: fillCalender(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 40),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.keyboard_arrow_left,
                          color: Colors.black,
                          size: 30,
                        ),
                        splashRadius: 20,
                        onPressed: () async {
                          dayMoveHelper++;
                          String day = DateFormat("yyyy-MM-dd hh:mm:ss")
                              .format(DateTime.now()
                                  .subtract(Duration(days: daysLoaded + 1)))
                              .split(" ")[0];
                          productsByDay[day] = await getAllConsumedByDate(day);
                          setState(
                            () {
                              currentDay = DateFormat("yyyy-MM-dd hh:mm:ss")
                                  .format(DateTime.now()
                                      .subtract(Duration(days: dayMoveHelper)))
                                  .split(" ")[0];
                              displayedCurrentDay = DateFormat("dd.MM.yyyy")
                                  .format(DateTime.now());
                            },
                          );
                        },
                      ),
                      Center(
                        child: Text(
                          displayedCurrentDay,
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.black,
                          size: 30,
                        ),
                        splashRadius: 20,
                        onPressed: () {
                          dayMoveHelper--;
                          setState(
                            () {
                              currentDay = DateFormat("yyyy-MM-dd hh:mm:ss")
                                  .format(DateTime.now()
                                      .subtract(Duration(days: dayMoveHelper)))
                                  .split(" ")[0];
                              displayedCurrentDay = DateFormat("dd.MM.yyyy")
                                  .format(DateTime.now());
                            },
                          );
                        },
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircularPercentIndicator(
                              radius: 60.0,
                              lineWidth: 7.0,
                              percent: 0.5,
                              center: Text("100%"),
                              progressColor: Color(0xFF509AF2),
                            ),
                            CircularPercentIndicator(
                              radius: 60.0,
                              lineWidth: 7.0,
                              percent: 0.5,
                              center: Text("100%"),
                              progressColor: Color(0xFF509AF2),
                            ),
                            CircularPercentIndicator(
                              radius: 60.0,
                              lineWidth: 7.0,
                              percent: 0.5,
                              center: Text("100%"),
                              progressColor: Color(0xFF509AF2),
                            ),
                            CircularPercentIndicator(
                              radius: 60.0,
                              lineWidth: 7.0,
                              percent: 0.5,
                              center: Text("100%"),
                              progressColor: Color(0xFF509AF2),
                            ),
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
                        child: productsByDay[currentDay] != null &&
                                productsByDay[currentDay].length != 0
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: productsByDay[currentDay].length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(10, 10, 10, 10),
                                    child: InkWell(
                                      onTap: () async {
                                        await Navigator.pushAndRemoveUntil(
                                          context,
                                          PageTransition(
                                            type:
                                                PageTransitionType.rightToLeft,
                                            duration:
                                                Duration(milliseconds: 300),
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
                                            productsByDay[today][index].name,
                                            style: FlutterFlowTheme.bodyText1
                                                .override(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            productsByDay[today][index]
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
                              )
                            : Center(
                                child: Text("No Data"),
                              ),
                      ),
                    ).animated([animationsMap['textOnPageLoadAnimation']]),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
