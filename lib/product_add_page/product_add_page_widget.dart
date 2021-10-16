import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foody/Utils/dataUtils.dart';
import 'package:foody/backend/schema/products_record.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:foody/flutter_flow/flutter_flow_animations.dart';
import 'package:foody/flutter_flow/flutter_flow_theme.dart';
import 'package:foody/product_details_page/product_details_page_widget.dart';
import 'package:foody/scan_product_page/scan_product_page_widget.dart';
import 'package:foody/widgets/productTextField.dart';
import 'package:page_transition/page_transition.dart';

class ProductAddPage extends StatefulWidget {
  const ProductAddPage({Key key, this.barcodeProduct}) : super(key: key);
  final String barcodeProduct;

  @override
  _ProductAddPageState createState() => _ProductAddPageState();
}

class _ProductAddPageState extends State<ProductAddPage>
    with TickerProviderStateMixin {
  TextEditingController name;
  TextEditingController barcode;
  TextEditingController calories;
  TextEditingController carbohydrates;
  TextEditingController fats;
  TextEditingController protein;
  TextEditingController sugar;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

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

    name = TextEditingController();
    barcode = TextEditingController();
    calories = TextEditingController();
    carbohydrates = TextEditingController();
    fats = TextEditingController();
    protein = TextEditingController();
    sugar = TextEditingController();

    barcode.text = widget.barcodeProduct;
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
        onPressed: () async {
          await Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.rightToLeft,
              duration: Duration(milliseconds: 300),
              reverseDuration: Duration(milliseconds: 300),
              child: ScanProductPageWidget(),
            ),
          );
        },
        backgroundColor: Color(0xFFF0F0F0),
        elevation: 8,
        child: Align(
          alignment: Alignment(0, 0),
          child: Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
            size: 24,
          ),
        ),
      ).animated([animationsMap['floatingActionButtonOnPageLoadAnimation']]),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment(0, -0.9),
                      child: Text(
                        'Add ' + this.barcode.text,
                        style: FlutterFlowTheme.title1.override(
                          fontFamily: 'Poppins',
                        ),
                      ).animated([animationsMap['textOnPageLoadAnimation']]),
                    ),
                    ProductTextField(
                      textController: name,
                      hintText: "Name",
                      number: false,
                    ).animated([animationsMap['textOnPageLoadAnimation']]),
                    ProductTextField(
                      textController: calories,
                      hintText: "Calories",
                      number: true,
                    ).animated([animationsMap['textOnPageLoadAnimation']]),
                    ProductTextField(
                      textController: protein,
                      hintText: "Protein",
                      number: true,
                    ).animated([animationsMap['textOnPageLoadAnimation']]),
                    ProductTextField(
                      textController: carbohydrates,
                      hintText: "Carbohydrates",
                      number: true,
                    ).animated([animationsMap['textOnPageLoadAnimation']]),
                    ProductTextField(
                      textController: sugar,
                      hintText: "Sugar",
                      number: true,
                    ).animated([animationsMap['textOnPageLoadAnimation']]),
                    ProductTextField(
                      textController: fats,
                      hintText: "Fats",
                      number: true,
                    ).animated([animationsMap['textOnPageLoadAnimation']]),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: IconButton(
                        onPressed: () async {
                          if (!formKey.currentState.validate()) {
                            return;
                          }
                          final productsCreateData = createProductsRecordData(
                            sugar: double.parse(sugar.text),
                            barcode: int.parse(barcode.text),
                            calories: double.parse(calories.text),
                            carbohydrates: double.parse(carbohydrates.text),
                            description: " ",
                            fats: double.parse(fats.text),
                            name: name.text,
                            protein: double.parse(protein.text),
                          );
                          await ProductsRecord.collection
                              .doc()
                              .set(productsCreateData);
                          await Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              duration: Duration(milliseconds: 300),
                              reverseDuration: Duration(milliseconds: 300),
                              child: ProductDetailsPageWidget(
                                  docID: await findBarcode(barcode.text), viewProduct: false,),
                            ),
                          );
                        },
                        icon: FaIcon(
                          FontAwesomeIcons.plusCircle,
                          color: FlutterFlowTheme.primaryColor,
                          size: 40,
                        ),
                        iconSize: 40,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
