import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app/config/themes/app_themes.dart';
import 'package:money_app/data/constants.dart';

import 'package:money_app/data/date_util.dart';
import 'package:money_app/data/languages_app.dart';
import 'package:money_app/presentation/pages/chart/bloc/chart_bloc.dart';
import 'package:money_app/presentation/pages/settings/category/bloc/category_bloc.dart';
import 'package:money_app/injection.dart' as di;
import 'package:money_app/presentation/pages/settings/themes/themes_bloc/themes_bloc.dart';
import 'package:money_app/presentation/pages/transaction/bloc/transaction_bloc.dart';

import 'config/routes/app_routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  LanguagesApp _languageApp = LanguagesApp();

  await di.setup();
  runApp(EasyLocalization(
    startLocale: _languageApp.getDefaultLanguage,
    path: locAssetLanguage,
    supportedLocales: _languageApp.getListLanguage,
    fallbackLocale: _languageApp.getDefaultLanguage,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  AppRoutes routes = AppRoutes();

  // bool isDark = false;
  ThemeData? _themeData = appThemeData[AppTheme.lightAppTheme];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.getIt<CategoryBloc>(),
        ),
        BlocProvider(
          create: (context) => di.getIt<TransactionBloc>()
            ..add(ReadTransactionEvent(
                transactionDateTime: DateUtil().getCurrentDate())),
        ),
        BlocProvider(
          create: (context) => di.getIt<ChartBloc>()
            ..add(ReadChartDefaultEvent(
                transactionDateTime: DateUtil().getCurrentDate())),
        ),
        // BlocProvider(
        //   create: (context) => di.getIt<ThemesBloc>()..add(ReadThemesEvent()),
        // ),
        BlocProvider(
          create: (context) => di.getIt<ThemesBloc>()..add(ReadThemesEvent()),
        ),
      ],
      child: BlocBuilder<ThemesBloc, ThemesState>(
        builder: (context, state) {
          // if (state is SuccessReadThemes) {
          //   print("this is state : ${state.result}");
          //   isDark = state.result;
          // }
          if (state is SuccessChangeThemes) {
            _themeData = appThemeData[state.appTheme];
          }
          return MaterialApp(
            // add new language
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            // end add new language
            debugShowCheckedModeBanner: false,
            initialRoute: AppRoutes.splash,
            routes: routes.getRoutes,
            theme: _themeData,
            // theme: ThemesApp.themeData(isDark, context),
            // themeMode: ThemeMode.dark,
            // theme: ThemeData(
            //     textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
            //     appBarTheme: AppBarTheme(color: lightBlue, centerTitle: false)
            //     // fontFamily: GoogleFonts.poppins(),
            //     ),
          );
        },
      ),
    );
  }
}
