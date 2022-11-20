import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:money_app/data/date_util.dart';
import 'package:money_app/domain/entities/category.dart';
import 'package:money_app/domain/entities/transaction.dart';
import 'package:money_app/presentation/pages/transaction/bloc/transaction_bloc.dart';
import 'package:money_app/presentation/widgets/customWidgets.dart';

import '../../../config/routes/app_routes.dart';
import '../../../data/constants.dart';
import '../settings/category/bloc/category_bloc.dart';

class TransactionScreen extends StatelessWidget {
  TransactionScreen({Key? key}) : super(key: key);

  // static final _formKeyTrx = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyTrx = GlobalKey<FormState>();

  // late FocusNode myFocusNode = FocusNode();
  TextEditingController nameController = TextEditingController();
  TextEditingController deskriptionController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Transaction transaction =
        Transaction(idCategory: 1, title: "", createdTime: todayTime);

    // String selectedImage = "collect-interest";
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
              // if (state is SuccessCallbackIconCategory) {
              //   print(">>>> state2: ${state.value}");
              //   category = state.value;
              //   transaction.idCategory = state.value.id!;
              // }
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
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.topLeft,
                        colors: bloomColor,
                      ),
                    ),
                    child: Form(
                      key: formKeyTrx,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            // section form
                            Flexible(
                              flex: 9,
                              child: Container(
                                color: Colors.transparent,
                                child: SingleChildScrollView(
                                  keyboardDismissBehavior:
                                      ScrollViewKeyboardDismissBehavior.onDrag,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      // segement control
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: CupertinoSlidingSegmentedControl<
                                            int>(
                                          backgroundColor:
                                              Colors.white.withOpacity(0.9),
                                          thumbColor:
                                              (transaction.isOutcome == 0)
                                                  ? Colors.green.shade200
                                                  : Colors.redAccent.shade200,
                                          padding: const EdgeInsets.all(8),
                                          groupValue: transaction.isOutcome,
                                          children: {
                                            0: buildSegment('income'.tr()),
                                            1: buildSegment('expense'.tr()),
                                          },
                                          onValueChanged: (value) {
                                            context.read<TransactionBloc>().add(
                                                SelectedIsOutcomeEvent(
                                                    value: value ?? 0));
                                            transaction.isOutcome = value!;
                                          },
                                        ),
                                      ),

                                      // tanggal
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 20),
                                        padding: const EdgeInsets.all(8),
                                        decoration: customCircularBox(
                                            color:
                                                Colors.white.withOpacity(0.9)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            FittedBox(
                                                fit: BoxFit.fitWidth,
                                                child: Text('date'.tr())),
                                            InkWell(
                                              onTap: () {
                                                showDatePicker(
                                                        context: context,
                                                        initialDate: DateTime
                                                            .parse(transaction
                                                                .createdTime),
                                                        firstDate:
                                                            DateTime(1900),
                                                        lastDate:
                                                            DateTime(9999))
                                                    .then((value) {
                                                  (value == null)
                                                      ? context
                                                          .read<
                                                              TransactionBloc>()
                                                          .add(SelectedDateEvent(
                                                              value: transaction
                                                                  .createdTime))
                                                      : context
                                                          .read<
                                                              TransactionBloc>()
                                                          .add(SelectedDateEvent(
                                                              value: value
                                                                  .toString()));
                                                });
                                              },
                                              child: ListTile(
                                                leading: const Icon(
                                                    Icons.calendar_month),
                                                title: Text(
                                                    DateFormat('dd / MM / yyyy')
                                                        .format(DateTime.parse(
                                                            transaction
                                                                .createdTime))),
                                                trailing: const Icon(Icons
                                                    .arrow_drop_down_sharp),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      // kategori
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 20),
                                        padding: const EdgeInsets.all(8),
                                        decoration: customCircularBox(
                                            color:
                                                Colors.white.withOpacity(0.9)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            FittedBox(
                                                fit: BoxFit.fitWidth,
                                                child: Text('category'.tr())),
                                            SB_Height10,
                                            InkWell(
                                              onTap: () {
                                                if (transaction.idCategory >
                                                    0) {
                                                  context
                                                      .read<CategoryBloc>()
                                                      .add(ChangeIconCategory(
                                                          categoryValue:
                                                              category));
                                                }

                                                Navigator.of(context,
                                                        rootNavigator: true)
                                                    .pushNamed(AppRoutes
                                                        .transactionCategory);
                                              },
                                              child: ListTile(
                                                leading: CircleAvatar(
                                                  radius: 25,
                                                  foregroundColor:
                                                      Colors.transparent,
                                                  child: ClipOval(
                                                    child: Image.asset(
                                                      "assets/icons/${category.iconName}.png",
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                                title: Text(category.name),
                                                trailing: const Icon(Icons
                                                    .arrow_drop_down_sharp),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      // name
                                      // SB_Height30,
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 20),
                                        padding: const EdgeInsets.all(8),
                                        decoration: customCircularBox(
                                            color:
                                                Colors.white.withOpacity(0.9)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('name'.tr()),
                                            SB_Height10,
                                            TextFormField(
                                              controller: nameController,
                                              onSaved: (newValue) {
                                                if (newValue!.isNotEmpty ||
                                                    newValue != "") {
                                                  transaction.title = newValue;
                                                }
                                              },
                                              validator: (value) {
                                                if (value!.isEmpty ||
                                                    value == "") {
                                                  return 'name-not-null'.tr();
                                                }
                                                return null;
                                              },
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'type-name'.tr(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      // SB_Height30,
                                      // Deskripsi
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 20),
                                        padding: const EdgeInsets.all(8),
                                        decoration: customCircularBox(
                                            color:
                                                Colors.white.withOpacity(0.9)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('description'.tr()),
                                            SB_Height10,
                                            TextFormField(
                                              keyboardType: TextInputType.text,
                                              controller: deskriptionController,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText:
                                                    'type-description'.tr(),
                                              ),
                                              onSaved: (newValue) {
                                                transaction.description =
                                                    newValue ?? "";
                                              },
                                            ),
                                          ],
                                        ),
                                      ),

                                      // nominal
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 20),
                                        padding: const EdgeInsets.all(8),
                                        decoration: customCircularBox(
                                            color:
                                                Colors.white.withOpacity(0.9)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('amount'.tr()),
                                            SB_Height10,
                                            TextFormField(
                                              keyboardType:
                                                  TextInputType.number,
                                              controller: amountController,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 30,
                                              ),
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                  horizontal: 20,
                                                  vertical: 20,
                                                ),
                                                hintText: "0",
                                              ),
                                              onSaved: (newValue) {
                                                if (newValue!.isNotEmpty ||
                                                    newValue != "") {
                                                  transaction.amount =
                                                      double.parse(newValue);
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            // section button
                            Flexible(
                              flex: 1,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (formKeyTrx.currentState!.validate()) {
                                      formKeyTrx.currentState!.save();
                                      // print(">> transaksi  : $transaction");
                                      // action save
                                      context.read<TransactionBloc>()
                                        ..add(SaveTransactionNew(
                                            value: transaction))
                                        ..add(ReadTransactionEvent(
                                            transactionDateTime:
                                                DateUtil().getCurrentDate()));

                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Text('save'.tr()),
                                ),
                              ),
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

Widget buildSegment(String text) {
  return Container(
    child: Text(
      text,
      style: TextStyle(fontSize: 22, color: Colors.black),
    ),
  );
}
