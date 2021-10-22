import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:foody/home_page/home_page_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:foody/scan_product_page/scan_product_page_widget.dart';
import 'package:foody/translations/codegen_loader.g.dart';
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
      home: TestClass(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TestClass extends StatelessWidget {
  const TestClass({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 5,
        navigateAfterSeconds: NavBarPage(),
        title: new Text(
          'Welcome To Foody',
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        image: Image.asset('assets/images/logo.png'),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        loaderColor: FlutterFlowTheme.primaryColor);
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
