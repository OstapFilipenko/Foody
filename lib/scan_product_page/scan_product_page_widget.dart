import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:foody/Utils/dataUtils.dart';
import 'package:foody/home_page/home_page_widget.dart';
import 'package:foody/product_add_page/product_add_page_widget.dart';
import 'package:foody/translations/locale_keys.g.dart';
import '../backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../main.dart';
import '../product_details_page/product_details_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:scan/scan.dart';
import 'package:easy_localization/easy_localization.dart';

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

  final _formKey = GlobalKey<FormState>();

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
              onPressed: () async {
                await Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.leftToRight,
                      duration: Duration(milliseconds: 300),
                      reverseDuration: Duration(milliseconds: 300),
                      child: NavBarPage(initialPage: 'HomePage'),
                    ),
                  );
              },
            ).animated(
                [animationsMap['floatingActionButtonOnPageLoadAnimation']]),
            FloatingActionButton.extended(
              heroTag: 'fab',
              label: Row(
                children: [
                  Text(LocaleKeys.search.tr()),
                  Icon(
                    Icons.arrow_forward_outlined,
                    color: Colors.white,
                    size: 24,
                  ),
                ],
              ),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
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
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          _buildPopupDialog(context),
                    );
                  }
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
                LocaleKeys.titleScan.tr(),
                style: FlutterFlowTheme.title1.override(
                  fontFamily: 'Poppins',
                ),
              ).animated([animationsMap['textOnPageLoadAnimation']]),
            ),
            Align(
              alignment: Alignment(0, 0),
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Container(
                  width: MediaQuery.of(context).size.width -
                      100, // custom wrap size
                  height: 250,
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
                        showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              _buildPopupDialog(context),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Align(
                alignment: Alignment(0, 0),
                child: Form(
                    key: _formKey,
                    child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        elevation: 5,
                        child: TextFormField(
                          controller: barcodeController,
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: LocaleKeys.barcodeNumber.tr(),
                              labelStyle: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10.0)),
                              filled: true,
                              contentPadding:
                                  EdgeInsets.fromLTRB(10, 10, 10, 10),
                              fillColor: Colors.transparent),
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                          ),
                          validator: (val) {
                            if (val.isEmpty) {
                              return LocaleKeys.emptyBarcodeField.tr();
                            }
                            if (val.length < 2) {
                              return LocaleKeys.shortBarcodeField.tr();
                            }
                            return null;
                          },
                          textAlign: TextAlign.start,
                          maxLines: 1,
                        ))),
              ),
            ).animated([animationsMap['textOnPageLoadAnimation']])
          ],
        ),
      ),
    );
  }

  //TODO text auf dynamisch ändern

  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: Text(LocaleKeys.popUpTitle.tr()),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[Text(LocaleKeys.popUpText.tr())],
      ),
      actions: <Widget>[
        // ignore: deprecated_member_use
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: Text(LocaleKeys.popUpAnswerNo.tr()),
        ),
        // ignore: deprecated_member_use
        new FlatButton(
          onPressed: () async {
            await Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                duration: Duration(milliseconds: 300),
                reverseDuration: Duration(milliseconds: 300),
                child: ProductAddPage(
                  barcodeProduct: barcodeStr,
                ),
              ),
            );
          },
          textColor: Theme.of(context).primaryColor,
          child: Text(LocaleKeys.popUpAnswerYes.tr()),
        ),
      ],
    );
  }
}
