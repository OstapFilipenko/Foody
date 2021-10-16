import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:foody/backend/localDatabase.dart';
import 'package:foody/widgets/productTextField.dart';

import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class SettingsWidget extends StatefulWidget {
  SettingsWidget({Key key}) : super(key: key);

  @override
  _SettingsWidgetState createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget>
    with TickerProviderStateMixin {
  TextEditingController kcalController;
  TextEditingController fatsController;
  TextEditingController carbohydratesController;
  TextEditingController proteinController;
  TextEditingController sugarController;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final animationsMap = {
    'textOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      duration: 500,
      fadeIn: true,
      slideOffset: Offset(5, 0),
    ),
  };
  final db = LocalDatabase();

  @override
  void initState() {
    super.initState();
    startAnimations(
      animationsMap.values
          .where((anim) => anim.trigger == AnimationTrigger.onPageLoad),
      this,
    );

    kcalController = TextEditingController();
    fatsController = TextEditingController();
    carbohydratesController = TextEditingController();
    proteinController = TextEditingController();
    sugarController = TextEditingController();
  }

  Future loadPersonalInfo() async {
    //loading the values from the db to show them in the textfield
    await db.queryKcal().then((double kcal) {
      kcalController.text = kcal.toString();
    });

    await db.queryFats().then((double fats) {
      fatsController.text = fats.toString();
    });

    await db.queryCarbohydrates().then((double carbohydrates) {
      carbohydratesController.text = carbohydrates.toString();
    });

    await db.queryProtein().then((double protein) {
      proteinController.text = protein.toString();
    });

    await db.querySugar().then((double sugar) {
      sugarController.text = sugar.toString();
    });
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
          ),
        ),
        body: FutureBuilder(
          future: loadPersonalInfo(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return SafeArea(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 40),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment(0, -0.9),
                        child: Text(
                          'Settings',
                          style: FlutterFlowTheme.title1.override(
                            fontFamily: 'Poppins',
                          ),
                        ).animated([animationsMap['textOnPageLoadAnimation']]),
                      ),
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: ListView(
                            children: [
                              ProductTextField(
                                textController: kcalController,
                                hintText: "Amount kcal / day",
                                number: true,
                              ).animated(
                                  [animationsMap['textOnPageLoadAnimation']]),
                              ProductTextField(
                                textController: fatsController,
                                hintText: "Amount fats / day",
                                number: true,
                              ).animated(
                                  [animationsMap['textOnPageLoadAnimation']]),
                              ProductTextField(
                                textController: carbohydratesController,
                                hintText: "Amount carbohyd. / day",
                                number: true,
                              ).animated(
                                  [animationsMap['textOnPageLoadAnimation']]),
                              ProductTextField(
                                textController: proteinController,
                                hintText: "Amount protein / day",
                                number: true,
                              ).animated(
                                  [animationsMap['textOnPageLoadAnimation']]),
                              ProductTextField(
                                textController: sugarController,
                                hintText: "Amount sugar / day",
                                number: true,
                              ).animated(
                                  [animationsMap['textOnPageLoadAnimation']]),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (!formKey.currentState.validate()) {
                                      return;
                                    }
                                    //Updating the values in the local db
                                    await db.updateKcal(
                                        double.parse(kcalController.text));
                                    await db.updateFats(
                                        double.parse(fatsController.text));
                                    await db.updateCarbohydrates(double.parse(
                                        carbohydratesController.text));
                                    await db.updateProtein(
                                        double.parse(proteinController.text));
                                    await db.updateSugar(
                                        double.parse(sugarController.text));
                                  },
                                  child: Text(
                                    "Save",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 21),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      shape: StadiumBorder()),
                                ),
                              ).animated(
                                  [animationsMap['textOnPageLoadAnimation']]),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
