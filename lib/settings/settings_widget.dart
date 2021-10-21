import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:foody/backend/localDatabase.dart';
import 'package:foody/backend/localModels/language.dart';
import 'package:foody/backend/localModels/product_consumed.dart';
import 'package:foody/translations/locale_keys.g.dart';
import 'package:foody/widgets/productTextField.dart';
import 'package:gx_file_picker/gx_file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:flutter_share/flutter_share.dart';

import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

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

  String language;

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

  Future<String> getFilePath() async {
    Directory downloadDir;
    if (Platform.isAndroid) {
      downloadDir = await getExternalStorageDirectory();
    } else {
      downloadDir = await getApplicationDocumentsDirectory();
    }
    final fileName = "FoodyData.txt";
    final filePath = "${downloadDir.path}/$fileName";
    return filePath;
  }

  Future<void> saveFile() async {
    File file = File(await getFilePath());
    List<String> lines = [
      "PersonalKcal:" + kcalController.text + ";",
      "PersonalFats:" + fatsController.text + ";",
      "PersonalCarbohydrates:" + carbohydratesController.text + ";",
      "PersonalProtein:" + proteinController.text + ";",
      "PersonalSugar:" + sugarController.text + ";",
      "PersonalLanguage:" + language + ";",
    ];

    List<ProductConsumed> products = await db.queryAllProducts();
    products.forEach((product) {
      lines.add(product.toString());
    });

    String fileContent = "";
    lines.forEach((line) {
      fileContent += line + "\n";
    });
    await file.writeAsString(fileContent);
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

    await db.queryLanguage().then((double lang) {
      language = lang.toString();
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
                          LocaleKeys.titleSettings.tr(),
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
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                child: Material(
                                  color: Colors.transparent,
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: DropdownButton(
                                      isExpanded: true,
                                      value: this.language,
                                      style: FlutterFlowTheme.title1.override(
                                        fontFamily: 'Poppins',
                                        fontSize: 13,
                                      ),
                                      underline: SizedBox(),
                                      icon: Icon(
                                        Icons.language,
                                        color: FlutterFlowTheme.primaryColor,
                                      ),
                                      items: languages.map((Language lang) {
                                        return DropdownMenuItem<String>(
                                          value: lang.id.toString(),
                                          child: Text(lang.langCode),
                                        );
                                      }).toList(),
                                      onChanged: (val) async {
                                        this.language = val;
                                        await db.updateLanguage(
                                            double.parse(language));
                                        context.setLocale(Locale(languages
                                            .lastWhere((element) =>
                                                element.id.toString() == val)
                                            .langCode));
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                ),
                              ).animated(
                                  [animationsMap['textOnPageLoadAnimation']]),
                              ProductTextField(
                                textController: kcalController,
                                hintText: LocaleKeys.amountKcal.tr(),
                                number: true,
                              ).animated(
                                  [animationsMap['textOnPageLoadAnimation']]),
                              ProductTextField(
                                textController: fatsController,
                                hintText: LocaleKeys.amountFats.tr(),
                                number: true,
                              ).animated(
                                  [animationsMap['textOnPageLoadAnimation']]),
                              ProductTextField(
                                textController: carbohydratesController,
                                hintText: LocaleKeys.amountCarb.tr(),
                                number: true,
                              ).animated(
                                  [animationsMap['textOnPageLoadAnimation']]),
                              ProductTextField(
                                textController: proteinController,
                                hintText: LocaleKeys.amountProtein.tr(),
                                number: true,
                              ).animated(
                                  [animationsMap['textOnPageLoadAnimation']]),
                              ProductTextField(
                                textController: sugarController,
                                hintText: LocaleKeys.amountSugar.tr(),
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
                                    LocaleKeys.save.tr(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 21),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      shape: StadiumBorder()),
                                ),
                              ).animated(
                                  [animationsMap['textOnPageLoadAnimation']]),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    //export data from local device
                                    await saveFile();
                                    await FlutterShare.shareFile(
                                      title: 'Foody app data',
                                      filePath: await getFilePath(),
                                    );
                                    print("Path: " + await getFilePath());
                                  },
                                  child: Text(
                                    "Export",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 21),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      shape: StadiumBorder()),
                                ),
                              ).animated(
                                  [animationsMap['textOnPageLoadAnimation']]),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    //import data from a file

                                    File file = await FilePicker.getFile();
                                  },
                                  child: Text(
                                    "Import",
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
