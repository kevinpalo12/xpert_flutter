import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:xpert_flutter/src/features/cat/cubit/cat_cubit.dart';
import 'package:xpert_flutter/src/features/cat/ui/cat_screen.dart';
import 'package:xpert_flutter/src/features/cat/ui/splash_screen.dart';
import 'package:xpert_flutter/utils/bottom_menu.dart';
import 'package:xpert_flutter/utils/injection_dependency.dart';

import 'routes.dart';

class AppRouter {
  static final CatCubit catCubit = sl<CatCubit>();

  static Route? onGenerateRoute(RouteSettings routeSettings) {
    final routes = <String, MaterialPageRoute>{
      "/": MaterialPageRoute(builder: (_) => BottomMenu(catCubit: catCubit)),
      AppRoutes.cats: MaterialPageRoute(
        builder: (_) => CatScreen(catCubit: catCubit),
      ),
      AppRoutes.splash: MaterialPageRoute(builder: (_) => SplashScreen()),
    };
    return routes[routeSettings.name] ??
        MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${routeSettings.name}'),
            ),
          ),
        );
  }
}
