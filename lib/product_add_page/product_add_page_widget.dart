import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foody/backend/schema/products_record.dart';
import 'package:foody/flutter_flow/flutter_flow_theme.dart';
import 'package:foody/product_details_page/product_details_page_widget.dart';
import 'package:foody/widgets/ProductTextField.dart';
import 'package:page_transition/page_transition.dart';

class ProductAddPage extends StatefulWidget {
  const ProductAddPage({Key key, this.barcodeProduct}) : super(key: key);
  final String barcodeProduct;

  @override
  _ProductAddPageState createState() => _ProductAddPageState();
}

class _ProductAddPageState extends State<ProductAddPage> {
  TextEditingController name;
  TextEditingController barcode;
  TextEditingController calories;
  TextEditingController carbohydrates;
  TextEditingController fats;
  TextEditingController protein;
  TextEditingController sugar;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    name = TextEditingController();
    barcode = TextEditingController();
    calories = TextEditingController();
    carbohydrates = TextEditingController();
    fats = TextEditingController();
    protein = TextEditingController();
    sugar = TextEditingController();

    barcode.text = widget.barcodeProduct;
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.primaryColor,
          automaticallyImplyLeading: false,
          title: Text(
            'FoodAdder',
            style: FlutterFlowTheme.title1.override(
              fontFamily: 'Poppins',
              color: Colors.white,
            ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 4,
        ),
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                      child: Text(
                        'Add Food to the DB',
                        style: FlutterFlowTheme.title1.override(
                          fontFamily: 'Poppins',
                          fontSize: 23,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                      child: Text(
                        this.barcode.text,
                        style: FlutterFlowTheme.title1.override(
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                      child: ProductTextField(
                        textController: name,
                        hintText: "Name",
                        number: false,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                      child: ProductTextField(
                        textController: calories,
                        hintText: "Calories",
                        number: true,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                      child: ProductTextField(
                        textController: protein,
                        hintText: "Protein",
                        number: true,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                      child: ProductTextField(
                        textController: carbohydrates,
                        hintText: "Carbohydrates",
                        number: true,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                      child: ProductTextField(
                        textController: sugar,
                        hintText: "Sugar",
                        number: true,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                      child: ProductTextField(
                        textController: fats,
                        hintText: "Fats",
                        number: true,
                      ),
                    ),
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
                                  docID: await findBarcode(barcode.text)),
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
