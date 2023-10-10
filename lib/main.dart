import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ui/web/screens/homepage.dart';
import 'package:ui/web/screens/navigationbarview.dart';
import 'package:ui/web/screens/productfrom_screen.dart';
import 'web/screens/form_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            theme: ThemeData(
              useMaterial3: true,
              primaryColor: Colors.green,
            ),
            title: 'Farmer Ally',
            debugShowCheckedModeBanner: false,
            home: TopNavigatiobarviewState(),
          );
        });
  }
}
