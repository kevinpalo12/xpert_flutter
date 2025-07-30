import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpert_flutter/src/features/cat/cubit/cat_cubit.dart';
import 'package:xpert_flutter/utils/injection_dependency.dart';

import 'src/core/routes/app_router.dart';
import 'src/core/routes/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => sl<CatCubit>())],
      child: Builder(
        builder: (context) {
          return MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: TextScaler.linear(1.0)),
            child: MaterialApp(
              locale: const Locale('es'),
              title: 'Xpert Flutter',
              debugShowCheckedModeBanner: false,
              initialRoute: AppRoutes.splash,
              onGenerateRoute: AppRouter.onGenerateRoute,
              theme: ThemeData(
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  selectedItemColor: Colors.teal,
                ),
                primaryColor: Colors.teal,
                fontFamily: 'Montserrat',
                useMaterial3: true,
                scrollbarTheme: ScrollbarThemeData(
                  thumbColor: WidgetStateProperty.all(Colors.grey),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
