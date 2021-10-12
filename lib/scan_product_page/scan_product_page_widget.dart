import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:foody/product_add_page/product_add_page_widget.dart';
import '../backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../product_details_page/product_details_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:scan/scan.dart';

class ScanProductPageWidget extends StatefulWidget {
  ScanProductPageWidget({Key key}) : super(key: key);

  @override
  _ScanProductPageWidgetState createState() => _ScanProductPageWidgetState();
}

class _ScanProductPageWidgetState extends State<ScanProductPageWidget>
    with TickerProviderStateMixin {
  TextEditingController barcodeController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String barcodeStr = "";

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

  ScanController controller = ScanController();

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

  Future<String> findBarcode(String barcode) async {
    String idOfPruduct;
    QuerySnapshot<Map<String, dynamic>> snapshot = await ProductsRecord
        .collection
        .where("barcode", isEqualTo: int.parse(barcode))
        .get();

    if (snapshot.docs.isEmpty) {
      return null;
    }

    List<QueryDocumentSnapshot> docs = snapshot.docs;
    for (var doc in docs) {
      if (doc.data() != null) {
        idOfPruduct = doc.id;
      }
    }

    return idOfPruduct;
  }

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text("No Product"),
      content: Text("This product does not exist in our database :( "),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        ),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              child: Icon(
                Icons.arrow_back_outlined,
                color: Colors.black,
                size: 24,
              ),
              backgroundColor: Color(0xFFF0F0F0),
              elevation: 8,
              onPressed: () {
                Navigator.pop(context);
              },
            ).animated(
                [animationsMap['floatingActionButtonOnPageLoadAnimation']]),
            FloatingActionButton.extended(
              heroTag: 'fab',
              label: Row(
                children: [
                  Text('Search'),
                  Icon(
                    Icons.arrow_forward_outlined,
                    color: Colors.white,
                    size: 24,
                  ),
                ],
              ),
              onPressed: () async {
                barcodeStr = await findBarcode(barcodeController.text);
                if (barcodeStr != null) {
                  await Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      duration: Duration(milliseconds: 300),
                      reverseDuration: Duration(milliseconds: 300),
                      child: ProductDetailsPageWidget(docID: barcodeStr),
                    ),
                  );
                } else {
                  await Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      duration: Duration(milliseconds: 300),
                      reverseDuration: Duration(milliseconds: 300),
                      child: ProductAddPage(
                        barcodeProduct: barcodeController.text,
                      ),
                    ),
                  );
                }
              },
              backgroundColor: FlutterFlowTheme.primaryColor,
              elevation: 8,
            ),
          ],
        ),
      ),
      body: SafeArea(
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
                  width: MediaQuery.of(context).size.width, // custom wrap size
                  height: 300,
                  child: ScanView(
                    controller: controller,
                    scanAreaScale: .9,
                    scanLineColor: FlutterFlowTheme.primaryColor,
                    onCapture: (data) async {
                      barcodeStr = await findBarcode(data);
                      if (barcodeStr != null) {
                        await Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            duration: Duration(milliseconds: 300),
                            reverseDuration: Duration(milliseconds: 300),
                            child: ProductDetailsPageWidget(docID: barcodeStr),
                          ),
                        );
                      } else {
                        await Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            duration: Duration(milliseconds: 300),
                            reverseDuration: Duration(milliseconds: 300),
                            child: ProductAddPage(
                              barcodeProduct: data,
                            ),
                          ),
                        );
                      }
                    },
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
                  child: Align(
                    alignment: Alignment(0, 0),
                    child: TextFormField(
                      controller: barcodeController,
                      obscureText: false,
                      keyboardType: TextInputType.number,
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
              ).animated([animationsMap['textOnPageLoadAnimation']]),
            )
          ],
        ),
      ),
    );
  }
}
