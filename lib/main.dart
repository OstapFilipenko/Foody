import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:foody/home_page/home_page_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:foody/scan_product_page/scan_product_page_widget.dart';
import 'package:foody/translations/codegen_loader.g.dart';
import 'package:foody/translations/locale_keys.g.dart';
import 'package:foody/widgets/ProductTextField.dart';
import 'package:page_transition/page_transition.dart';
import 'backend/localDatabase.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'home_page/home_page_widget.dart';
import 'settings/settings_widget.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'package:splashscreen/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    EasyLocalization(
        child: MyApp(),
        supportedLocales: [
          Locale('en'),
          Locale('de'),
        ],
        assetLoader: CodegenLoader(),
        fallbackLocale: Locale('en'),
        path: 'assets/translations'),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      title: 'Foody',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Splash(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Splash extends StatelessWidget {
  Splash({Key key}) : super(key: key);

  final db = LocalDatabase();

  Future<double> loadSettings() async {
    return await db.queryKcal();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<double>(
        future: loadSettings(),
        builder: (context, AsyncSnapshot snapshot) {
          return SplashScreen(
              seconds: 2,
              // ignore: unrelated_type_equality_checks
              navigateAfterSeconds:
                  // ignore: unrelated_type_equality_checks
                  snapshot.data == 0.0
                      ? AddSettingsAtBeginning()
                      : NavBarPage(),
              title: new Text(
                'Welcome To Foody',
                style:
                    new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              image: Image.asset('assets/images/logo.png'),
              backgroundColor: Colors.white,
              styleTextUnderTheLoader: new TextStyle(),
              photoSize: 100.0,
              loaderColor: FlutterFlowTheme.primaryColor);
        });
  }
}

class AddSettingsAtBeginning extends StatefulWidget {
  const AddSettingsAtBeginning({Key key}) : super(key: key);

  @override
  _AddSettingsAtBeginningState createState() => _AddSettingsAtBeginningState();
}

class _AddSettingsAtBeginningState extends State<AddSettingsAtBeginning> {
  TextEditingController kcalController;
  TextEditingController fatsController;
  TextEditingController carbohydratesController;
  TextEditingController proteinController;
  TextEditingController sugarController;

  final formKey = GlobalKey<FormState>();

  final db = LocalDatabase();

  @override
  void initState() {
    super.initState();
    kcalController = TextEditingController();
    fatsController = TextEditingController();
    carbohydratesController = TextEditingController();
    proteinController = TextEditingController();
    sugarController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Scaffold(
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
          body: SafeArea(
              child: ListView(
            padding: EdgeInsets.all(15),
            children: [
              Align(
                alignment: Alignment(0, -0.9),
                child: Text(
                  LocaleKeys.titleSettings.tr(),
                  style: FlutterFlowTheme.title1.override(
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              ProductTextField(
                textController: kcalController,
                hintText: LocaleKeys.amountKcal.tr(),
                number: true,
              ),
              ProductTextField(
                textController: fatsController,
                hintText: LocaleKeys.amountFats.tr(),
                number: true,
              ),
              ProductTextField(
                textController: carbohydratesController,
                hintText: LocaleKeys.amountCarb.tr(),
                number: true,
              ),
              ProductTextField(
                textController: proteinController,
                hintText: LocaleKeys.amountProtein.tr(),
                number: true,
              ),
              ProductTextField(
                textController: sugarController,
                hintText: LocaleKeys.amountSugar.tr(),
                number: true,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (!formKey.currentState.validate()) {
                      return;
                    }
                    //Updating the values in the local db
                    await db.updateKcal(double.parse(kcalController.text));
                    await db.updateFats(double.parse(fatsController.text));
                    await db.updateCarbohydrates(
                        double.parse(carbohydratesController.text));
                    await db
                        .updateProtein(double.parse(proteinController.text));
                    await db.updateSugar(double.parse(sugarController.text));

                    print('asdfasdfasdf');

                    await Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.leftToRight,
                          duration: Duration(milliseconds: 300),
                          reverseDuration: Duration(milliseconds: 300),
                          child: NavBarPage(initialPage: 'HomePage'),
                        ));
                  },
                  child: Text(
                    LocaleKeys.save.tr(),
                    style: TextStyle(color: Colors.white, fontSize: 21),
                  ),
                  style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                ),
              ),
            ],
          )),
        ));
  }
}

class NavBarPage extends StatefulWidget {
  NavBarPage({Key key, this.initialPage}) : super(key: key);

  final String initialPage;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  String _currentPage = 'HomePage';

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage ?? _currentPage;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'HomePage': HomePageWidget(),
      'Settings': SettingsWidget(),
    };
    return Scaffold(
      body: tabs[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_rounded,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
            ),
            label: 'Settings',
          )
        ],
        backgroundColor: Colors.white,
        currentIndex: tabs.keys.toList().indexOf(_currentPage),
        selectedItemColor: FlutterFlowTheme.primaryColor,
        unselectedItemColor: Color(0x8A000000),
        unselectedIconTheme: IconThemeData(size: 22),
        selectedIconTheme: IconThemeData(size: 26),
        onTap: (i) => setState(() => _currentPage = tabs.keys.toList()[i]),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        // Temporary fix for https://github.com/flutter/flutter/issues/84556

        type: BottomNavigationBarType.fixed,
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'fab',
        child: Icon(Icons.add),
        backgroundColor: FlutterFlowTheme.primaryColor,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ScanProductPageWidget()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
