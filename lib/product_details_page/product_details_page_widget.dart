import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:foody/backend/backend.dart';
import 'package:foody/backend/localDatabase.dart';
import 'package:foody/backend/localModels/product_consumed.dart';
import 'package:intl/intl.dart';

import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class ProductDetailsPageWidget extends StatefulWidget {
  final String docID;
  ProductDetailsPageWidget({Key key, this.docID});

  @override
  _ProductDetailsPageWidgetState createState() =>
      _ProductDetailsPageWidgetState();
}

class _ProductDetailsPageWidgetState extends State<ProductDetailsPageWidget>
    with TickerProviderStateMixin {
  TextEditingController gramController;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final db = LocalDatabase();

  var _productsRecord;
  String _productName = "[NAME]";
  String _productCals = "[CALS]";
  String _productFats = "[FATS]";
  String _productCarbs = "[CARBS]";
  String _productProtein = "[PROTEIN]";

  final animationsMap = {
    'textOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      duration: 500,
      fadeIn: true,
      slideOffset: Offset(5, 0),
    ),
    'floatingActionButtonOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      duration: 600,
      fadeIn: true,
      slideOffset: Offset(5, 0),
    ),
  };

  @override
  void initState() {
    super.initState();
    startAnimations(
      animationsMap.values
          .where((anim) => anim.trigger == AnimationTrigger.onPageLoad),
      this,
    );

    gramController = TextEditingController();
    getInfos();
  }

  void getInfos() async {
    _productsRecord = ProductsRecord.collection
        .doc(widget.docID)
        .get()
        .then((DocumentSnapshot snapshot) {
      setState(() {
        _productName = snapshot.get("name");
        _productCals = snapshot.get("calories").toString();
        _productFats = snapshot.get("fats").toString();
        _productCarbs = snapshot.get("carbohydrates").toString();
        _productProtein = snapshot.get("protein").toString();
      });
    });
  }

  Future<void> insertConsumedProduct(ProductConsumed productConsumed) async {
    await db.insertConsumedProduct(productConsumed.toMap());
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Scaffold(
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
            )),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await insertConsumedProduct(ProductConsumed(
              productID: widget.docID,
              eatenAt: DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now()),
              gramm: int.parse(gramController.text),
            ));
            await Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                duration: Duration(milliseconds: 300),
                reverseDuration: Duration(milliseconds: 300),
                child: NavBarPage(initialPage: 'HomePage'),
              ),
            );
          },
          backgroundColor: Color(0xFFF0F0F0),
          elevation: 8,
          child: Align(
            alignment: Alignment(0, 0),
            child: Icon(
              Icons.check_outlined,
              color: Colors.black,
              size: 24,
            ),
          ),
        ).animated([animationsMap['floatingActionButtonOnPageLoadAnimation']]),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 40),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment(0, -0.9),
                  child: Text(
                    _productName,
                    style: FlutterFlowTheme.title1.override(
                      fontFamily: 'Poppins',
                    ),
                  ).animated([animationsMap['textOnPageLoadAnimation']]),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Material(
                    color: Colors.transparent,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Align(
                        alignment: Alignment(0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                              alignment: Alignment(0, -0.55),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Text(
                                  'Nutritional information per 100g',
                                  style: FlutterFlowTheme.bodyText1.override(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        _productCals,
                                        style:
                                            FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: Color(0xFF509AF2),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        'calories',
                                        style:
                                            FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                          fontSize: 10,
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        _productFats,
                                        style:
                                            FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        'fat',
                                        style:
                                            FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                          fontSize: 10,
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        _productCarbs,
                                        style:
                                            FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        'carbohid.',
                                        style:
                                            FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                          fontSize: 10,
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        _productProtein,
                                        style:
                                            FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        'protein',
                                        style:
                                            FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                          fontSize: 10,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 35, 0, 0),
                  child: Material(
                    color: Colors.transparent,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        controller: gramController,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Enter amount (in g)',
                          labelStyle: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          filled: true,
                          contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        ),
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Please enter your amount';
                          }
                          if (val.length < 1) {
                            return 'Requires at least 1 characters.';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
