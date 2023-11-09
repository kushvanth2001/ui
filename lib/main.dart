import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/web/screens/form_screen%20copy.dart';
import 'web/screens/homepage.dart';
import 'web/screens/navigationbarview.dart';
import 'web/screens/productfrom_screen.dart';

import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
   usePathUrlStrategy();
  runApp(const MainApp());
}
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: '/home',
  
  
  routes: [
    StatefulShellRoute.indexedStack(
      branches:<StatefulShellBranch>[
        StatefulShellBranch(routes: [ GoRoute(
          path: '/home',
        
          pageBuilder: (context, state) {
            return const NoTransitionPage(
              child: HomePage()
            );
          },
        ),
        
      ]),
    StatefulShellBranch(routes:[     GoRoute(
          path: '/enter_crop_screen',
        
          pageBuilder: (context, state) {
            return   NoTransitionPage(
              child: FormScreen()
            );
          },
        ),] ) ,
        
        
        StatefulShellBranch(routes: [ GoRoute(
    
            path: '/enter_product_screen',
            pageBuilder: (context, state) {
              return  NoTransitionPage(child: ProductFormScreen());
            }),]),
        
       
      
    
         ],
      builder: (context, state, navigationShell) {
         return  TopNavigatiobarviewState(
          location: state.uri.toString(),
          child: navigationShell,
        );
      },
    ),
   
]);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp.router(
      debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              primaryColor: Colors.green,
            ),
            title: 'Farmer Ally',
          
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
        });
  }
}
