import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app/data/constants.dart';
import 'package:money_app/data/date_util.dart';
import 'package:money_app/presentation/pages/chart/bloc/chart_bloc.dart';
import 'package:money_app/presentation/pages/settings/category/bloc/category_bloc.dart';
import 'package:money_app/injection.dart' as di;
import 'package:money_app/presentation/pages/transaction/bloc/transaction_bloc.dart';

import 'config/routes/app_routes.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  await di.setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  AppRoutes routes = AppRoutes();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          // create: (context) => CategoryBloc()..add(InitCategory()),
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splash,
        routes: routes.getRoutes,
        theme: ThemeData(
            textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
            appBarTheme: AppBarTheme(color: lightBlue, centerTitle: false)
            // fontFamily: GoogleFonts.poppins(),
            ),
      ),
    );
  }
}
