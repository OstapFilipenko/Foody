import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import '../backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../product_details_page/product_details_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class ScanProductPageWidget extends StatefulWidget {
  ScanProductPageWidget({Key key}) : super(key: key);

  @override
  _ScanProductPageWidgetState createState() => _ScanProductPageWidgetState();
}

class _ScanProductPageWidgetState extends State<ScanProductPageWidget>
    with TickerProviderStateMixin {
  TextEditingController barcodeController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String barcode = "";
  final animationsMap = {
    'textOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      duration: 500,
      fadeIn: true,
      slideOffset: Offset(5, 0),
    ),
    'containerOnPageLoadAnimation1': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      duration: 600,
      delay: 30,
      fadeIn: true,
      slideOffset: Offset(5, 0),
    ),
    'containerOnPageLoadAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      duration: 600,
      delay: 100,
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

    barcodeController = TextEditingController();
  }

  Future<String> findBarcode() async {
    String idOfPruduct;
    QuerySnapshot<Map<String, dynamic>> snapshot = await ProductsRecord
        .collection.where("barcode", isEqualTo: int.parse(barcodeController.text)).get();

    List<QueryDocumentSnapshot> docs = snapshot.docs;
    for (var doc in docs) {
      if (doc.data() != null) {
        idOfPruduct = doc.id;
      }
    }

    return idOfPruduct;
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.rightToLeft,
              duration: Duration(milliseconds: 300),
              reverseDuration: Duration(milliseconds: 300),
              child: ProductDetailsPageWidget(docID: await findBarcode()),
            ),
          );
        },
        backgroundColor: Color(0xFFF0F0F0),
        elevation: 8,
        child: Align(
          alignment: Alignment(0, 0),
          child: Icon(
            Icons.arrow_forward_outlined,
            color: Colors.black,
            size: 24,
          ),
        ),
      ).animated([animationsMap['floatingActionButtonOnPageLoadAnimation']]),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 40),
          child: ListView(
            children: [
              Align(
                alignment: Alignment(0, -0.9),
                child: Text(
                  'Scan the product',
                  style: FlutterFlowTheme.title1.override(
                    fontFamily: 'Poppins',
                  ),
                ).animated([animationsMap['textOnPageLoadAnimation']]),
              ),
              Align(
                alignment: Alignment(0, 0),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 35, 0, 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: BoxDecoration(
                      color: Color(0xFFEEEEEE),
                    ),
                  ).animated([animationsMap['containerOnPageLoadAnimation1']]),
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
                    child: Align(
                      alignment: Alignment(0, 0),
                      child: TextFormField(
                        controller: barcodeController,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Barcode Number',
                          labelStyle: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                          ),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          filled: true,
                          contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        ),
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                        ),
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Please enter a barcode number';
                          }
                          if (val.length < 1) {
                            return 'Requires at least 1 characters.';
                          }
                          return null;
                        },
                        textAlign: TextAlign.start,
                        maxLines: 1,
                      ),
                    ),
                  ),
                ).animated([animationsMap['containerOnPageLoadAnimation2']]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
