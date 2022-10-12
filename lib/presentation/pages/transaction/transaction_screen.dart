import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:money_app/domain/entities/category.dart';
import 'package:money_app/domain/entities/transaction.dart';
import 'package:money_app/presentation/pages/transaction/bloc/transaction_bloc.dart';
import 'package:money_app/presentation/widgets/customWidgets.dart';

import '../../../config/routes/app_routes.dart';
import '../../../data/constants.dart';
import '../settings/category/bloc/category_bloc.dart';

class TransactionScreen extends StatelessWidget {
  TransactionScreen({Key? key}) : super(key: key);

  static final _formKey = GlobalKey<FormState>();
  // late FocusNode myFocusNode = FocusNode();
  TextEditingController nameController = TextEditingController();
  TextEditingController deskriptionController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Transaction transaction =
        Transaction(idCategory: 0, title: "", createdTime: todayTime);

    // String selectedImage = "collect-interest";
    Category category = Category(
        name: "Bunga",
        iconName: "collect-interest",
        createdTime: "",
        modifieldTime: "",
        isDefault: 1);

    // int? groupValue = 0;
    // DateTime? dateTime;
    // String selectedImage = "collect-interest";

    // final halfMediaWidth = MediaQuery.of(context).size.width - 10;
    // final mediaHeight = MediaQuery.of(context).size.height / 3;
    // var today = DateTime.now().toString;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaksi"),
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
              return Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      // section form
                      Flexible(
                        flex: 9,
                        child: Container(
                          color: Colors.white,
                          child: SingleChildScrollView(
                            keyboardDismissBehavior:
                                ScrollViewKeyboardDismissBehavior.onDrag,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                // segement control
                                CupertinoSlidingSegmentedControl<int>(
                                  backgroundColor:
                                      CupertinoColors.lightBackgroundGray,
                                  thumbColor: Colors.blue,
                                  padding: const EdgeInsets.all(8),
                                  groupValue: transaction.isOutcome,
                                  children: {
                                    0: buildSegment("Penerimaan"),
                                    1: buildSegment("Pengeluaran"),
                                  },
                                  onValueChanged: (value) {
                                    context.read<TransactionBloc>().add(
                                        SelectedIsOutcomeEvent(
                                            value: value ?? 0));
                                    transaction.isOutcome = value!;
                                  },
                                ),
                                SB_Height20,

                                // tanggal
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Tanggal"),
                                    InkWell(
                                      onTap: () {
                                        showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(1900),
                                                lastDate: DateTime(9999))
                                            .then((value) {
                                          context.read<TransactionBloc>().add(
                                              SelectedDateEvent(
                                                  value: value.toString()));
                                        });
                                      },
                                      child: ListTile(
                                        leading:
                                            const Icon(Icons.calendar_month),
                                        title: Text(DateFormat('dd / MM / yyyy')
                                            .format(DateTime.parse(
                                                transaction.createdTime))),
                                        trailing: const Icon(
                                            Icons.arrow_drop_down_sharp),
                                      ),
                                    ),
                                  ],
                                ),

                                SB_Height30,
                                // kategori
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Kategori"),
                                    SB_Height10,
                                    InkWell(
                                      onTap: () {
                                        context.read<CategoryBloc>().add(
                                            ReadIconCategoryDefault(
                                                isDefault: 0));

                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pushNamed(
                                                AppRoutes.transactionCategory);
                                      },
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          radius: 25,
                                          foregroundColor: Colors.red,
                                          child: ClipOval(
                                            child: Image.asset(
                                              "assets/icons/${category.iconName}.png",
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        title: Text(category.name),
                                        trailing: const Icon(
                                            Icons.arrow_drop_down_sharp),
                                      ),
                                    ),
                                  ],
                                ),

                                // name
                                SB_Height30,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Nama"),
                                    SB_Height10,
                                    TextFormField(
                                      controller: nameController,
                                      // onChanged: (value) {
                                      //   nameController.text = value;
                                      // },
                                      onSaved: (newValue) {
                                        if (newValue!.isNotEmpty ||
                                            newValue != "") {
                                          transaction.title = newValue;
                                        }
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty || value == "") {
                                          return "Nama Tidak Boleh Kosong";
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.text,
                                      decoration: const InputDecoration(
                                        hintText: "Ketikan Nama Transaksi",
                                      ),
                                    ),
                                  ],
                                ),

                                SB_Height30,
                                // Deskripsi
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Deskripsi"),
                                    SB_Height10,
                                    TextFormField(
                                      keyboardType: TextInputType.text,
                                      controller: deskriptionController,
                                      decoration: const InputDecoration(
                                        hintText:
                                            "Ketikan Deskripsi Transaksi (optional)",
                                      ),
                                      onSaved: (newValue) {
                                        transaction.description =
                                            newValue ?? "";
                                      },
                                    ),
                                  ],
                                ),

                                SB_Height30,
                                // nominal
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Nominal"),
                                    SB_Height10,
                                    TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: amountController,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 30,
                                      ),
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
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
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                // action save
                                context.read<TransactionBloc>()
                                  ..add(SaveTransactionNew(value: transaction))
                                  ..add(ReadTransactionEvent());

                                Navigator.pop(context);
                              }
                            },
                            child: const Text("Simpan"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
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
