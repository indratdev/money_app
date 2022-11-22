import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app/data/date_util.dart';
import 'package:money_app/domain/entities/category.dart';
import 'package:money_app/domain/entities/transaction.dart';
import 'package:money_app/presentation/pages/transaction/bloc/transaction_bloc.dart';
import 'package:money_app/presentation/pages/transaction/widgets/transaction_widgets.dart';

import '../../../data/constants.dart';
import '../settings/category/bloc/category_bloc.dart';

class TransactionScreen extends StatelessWidget {
  TransactionScreen({Key? key}) : super(key: key);

  GlobalKey<FormState> formKeyTrx = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController deskriptionController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final stateTheme = Theme.of(context).brightness;
    Transaction transaction =
        Transaction(idCategory: 1, title: "", createdTime: todayTime);

    Category category = Category(
        name: "Bunga",
        iconName: "collect-interest",
        createdTime: "",
        modifieldTime: "",
        isDefault: 1);

    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          context.read<TransactionBloc>().add(ReadTransactionEvent(
              transactionDateTime: DateUtil().getCurrentDate()));
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('transaction'.tr()),
          ),
          body: BlocConsumer<CategoryBloc, CategoryState>(
            listener: (context, state) {
              if (state is SuccessCallbackIconCategory) {
                category = state.value;
                transaction.idCategory = state.value.id!;
              }
            },
            builder: (context, state) {
              return BlocConsumer<TransactionBloc, TransactionState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is SuccessSelectedIsOutcome) {
                    transaction.isOutcome = state.result;
                  }
                  if (state is SuccessSelectedDate) {
                    transaction.createdTime = state.result;
                  }
                  return Container(
                    decoration: (stateTheme == Brightness.light)
                        ? backgroundThemeLight
                        : backgroundThemeDark,
                    child: Form(
                      key: formKeyTrx,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            // section form
                            SectionFormWidget(
                              stateTheme: stateTheme,
                              transaction: transaction,
                              category: category,
                              nameController: nameController,
                              deskriptionController: deskriptionController,
                              amountController: amountController,
                            ),

                            // section button
                            SectionButtonSave(
                              formKeyTrx: formKeyTrx,
                              transaction: transaction,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
