import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:money_app/data/constants.dart';
import 'package:money_app/data/date_util.dart';
import 'package:money_app/data/repositories/transaction_repository_impl.dart';
import 'package:money_app/domain/entities/calculationE.dart';
import 'package:money_app/domain/entities/transaction.dart';
import 'package:money_app/presentation/pages/chart/bloc/chart_bloc.dart';
import 'package:money_app/presentation/pages/home/widgets/widget_banner.dart';
import 'package:money_app/presentation/pages/settings/category/bloc/category_bloc.dart';
import 'package:money_app/presentation/pages/transaction/bloc/transaction_bloc.dart';
import 'package:money_app/presentation/pages/transaction/transaction_manage_screen.dart';

import '../../widgets/customWidgets.dart';
import '../../widgets/no_data_widget.dart';

import 'widgets/calculation_section.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  List<Transaction>? listTransaction;
  List<CalculationE>? listCalculation;

  String selectedDate = "";

  @override
  Widget build(BuildContext context) {
    final widhtContainer = MediaQuery.of(context).size.width / 3.5;
    final stateTheme = Theme.of(context).brightness;

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: (stateTheme == Brightness.light)
              ? backgroundThemeLight
              : backgroundThemeDark,
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: BlocConsumer<TransactionBloc, TransactionState>(
              listener: (context, state) {
                if (state is FailureReadTransaction) {
                  CustomWidgets.showMessageAlertBasic(
                      context, 'error-read-transaction'.tr(), false);
                }
                if (state is SuccessReadTransaction) {
                  listTransaction =
                      state.result[TransactionEnum.transaction.name];
                  selectedDate =
                      state.result[TransactionEnum.dateselected.name];
                  listCalculation =
                      state.result[TransactionEnum.calculation.name];

                  //reload chart
                  context.read<ChartBloc>().add(ReadChartDefaultEvent(
                      transactionDateTime: DateUtil().getCurrentDate()));
                }
              },
              builder: (context, state) {
                if (state is FailureReadTransaction) {
                  CustomWidgets.showMessageAlertBasic(
                      context, 'error-read-transaction'.tr(), false);
                }
                if (state is SuccessReadTransaction) {
                  listTransaction =
                      state.result[TransactionEnum.transaction.name];
                  selectedDate = state.result[TransactionEnum.dateselected.name]
                      .toString();
                  listCalculation =
                      state.result[TransactionEnum.calculation.name];
                  //reload chart
                  context.read<ChartBloc>().add(ReadChartDefaultEvent(
                      transactionDateTime: DateUtil().getCurrentDate()));
                }
                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          top: 8, right: 8, left: 8, bottom: 20),
                      height: MediaQuery.of(context).size.height / 14,
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            decoration: (stateTheme == Brightness.light)
                                ? arrowDecor
                                : arrowDecorDark,
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              alignment: Alignment.center,
                              child: IconButton(
                                onPressed: () {
                                  String date = DateUtil().operationDate(
                                      selectedDate, OptionDate.days, 0);
                                  context.read<TransactionBloc>().add(
                                      ReadTransactionEvent(
                                          transactionDateTime: date));
                                },
                                icon: const Icon(Icons.arrow_left_sharp),
                              ),
                            ),
                          ),
                          Container(
                            decoration: (stateTheme == Brightness.light)
                                ? arrowDecor
                                : arrowDecorDark,
                            width: MediaQuery.of(context).size.width / 2,
                            height: double.infinity,
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.all(30.0),
                                child: Text(
                                  selectedDate,
                                  softWrap: true,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: (stateTheme == Brightness.light)
                                ? arrowDecor
                                : arrowDecorDark,
                            child: IconButton(
                              onPressed: () {
                                String date = DateUtil().operationDate(
                                    selectedDate, OptionDate.days, 1);

                                context.read<TransactionBloc>().add(
                                    ReadTransactionEvent(
                                        transactionDateTime: date));
                              },
                              icon: const Icon(Icons.arrow_right_sharp),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // container calculation
                    Container(
                      // decoration: calculationDecor,
                      decoration: (stateTheme == Brightness.light)
                          ? calculationDecor
                          : calculationDecorDark,
                      height: MediaQuery.of(context).size.height / 10,
                      margin: const EdgeInsets.only(
                          top: 5, bottom: 20, left: 8, right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          // sizebox pengeluaran
                          CalculationSection(
                            widhtContainer: widhtContainer,
                            listCalculation: listCalculation,
                            labelName: 'expense'.tr(),
                            category: listCalculation?[0].expense ?? 0.0,
                            textColor: redCalculation,
                          ),
                          // container penerimaan
                          CalculationSection(
                            widhtContainer: widhtContainer,
                            listCalculation: listCalculation,
                            labelName: 'income'.tr(),
                            category: listCalculation?[0].income ?? 0.0,
                            textColor: greenCalculation,
                          ),

                          // selisih
                          CalculationSection(
                            widhtContainer: widhtContainer,
                            listCalculation: listCalculation,
                            labelName: 'deviation'.tr(),
                            category: listCalculation?[0].profit ?? 0.0,
                            textColor: (stateTheme == Brightness.light)
                                ? blackDefault
                                : lightWhite,
                          ),
                          // Container(
                        ],
                      ),
                    ),

                    Expanded(
                      child: Container(
                        decoration: (stateTheme == Brightness.light)
                            ? listDataDecor
                            : listDataDecorDark,
                        child: (listTransaction?.length == 0)
                            ? const NoDataWidget()
                            : ListView.separated(
                                shrinkWrap: true,
                                separatorBuilder: (context, index) =>
                                    // const Divider(color: lightWhite),
                                    // (context, index) =>
                                    defaultDivider(context),
                                itemCount: listTransaction?.length ?? 0,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Transaction data =
                                          listTransaction![index];
                                      context.read<CategoryBloc>().add(
                                          ReadCategoryByIdEvent(
                                              idCategory: data.idCategory));
                                      Navigator.of(context, rootNavigator: true)
                                          .pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              TransactionManageScreen(
                                            data: data,
                                          ),
                                        ),
                                      );
                                    },
                                    child: ListTile(
                                      contentPadding: const EdgeInsets.all(8),
                                      leading: CircleAvatar(
                                        radius: 25,
                                        backgroundColor: Colors.white,
                                        child: ClipOval(
                                          child: Image.asset(
                                            'assets/icons/${listTransaction?[index].categoryIconName}.png',
                                            fit: BoxFit.fill,
                                            // color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      title: Text(
                                          "${listTransaction?[index].title.toString()}"),
                                      trailing: Text(
                                        "Rp. ${formatterThousand.format(
                                          double.tryParse(
                                              "${listTransaction?[index].amount}"),
                                        )}",
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                    ),
                    WidgetBanner(),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
