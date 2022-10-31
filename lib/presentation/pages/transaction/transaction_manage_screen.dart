import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:money_app/domain/entities/transaction.dart';
import 'package:money_app/presentation/pages/transaction/transaction_screen.dart';
import 'package:money_app/presentation/widgets/customWidgets.dart';

import '../../../config/routes/app_routes.dart';
import '../../../data/constants.dart';
import '../../../data/date_util.dart';
import '../settings/category/bloc/category_bloc.dart';
import 'bloc/transaction_bloc.dart';

class TransactionManageScreen extends StatelessWidget {
  TransactionManageScreen({
    super.key,
    this.data,
  });

  Transaction? data = Transaction(createdTime: '', idCategory: 0, title: '');
  // Transaction? tempData =
  //     Transaction(createdTime: '', idCategory: 0, title: '');
  static final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController deskriptionController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final focusedCtx = FocusManager.instance.primaryFocus!.context;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Ubah Transaksi"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, AppRoutes.home);
            // context.read<TransactionBloc>().add(ReadTransactionEvent(
            //     transactionDateTime: DateUtil().getCurrentDate()));
          },
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                CustomWidgets.showConfirmationDelete(
                    context, "Apakah anda yakin Hapus transaksi ini  ?", () {
                  // delete
                  context
                      .read<TransactionBloc>()
                      .add(DeleteTransactionEvent(idTransaction: data!.id!));
                  // read
                  context.read<TransactionBloc>().add(ReadTransactionEvent(
                      transactionDateTime: DateUtil().getCurrentDate()));

                  Navigator.of(context, rootNavigator: true).pop();
                  Navigator.of(context).popUntil((route) => route.isFirst);
                });
              },
              icon: const Icon(Icons.delete_forever))
        ],
      ),
      body: BlocConsumer<TransactionBloc, TransactionState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is SuccessSelectedIsOutcome) {
            print(">>>> ${state.result}");
            data!.isOutcome = state.result;
          }
          if (state is SuccessSelectedDate) {
            data!.createdTime = state.result;
            data!.modifieldTrxTime = DateUtil().getCurrentDate();
            data!.isModifield = 1;
          }
          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Flexible(
                    flex: 9,
                    child: Container(
                      color: Colors.white,
                      child: SingleChildScrollView(
                        // reverse: true,
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            CupertinoSlidingSegmentedControl<int>(
                              backgroundColor:
                                  CupertinoColors.lightBackgroundGray,
                              thumbColor: Colors.blue,
                              padding: const EdgeInsets.all(8),
                              groupValue: data!.isOutcome,
                              children: {
                                0: buildSegment("Penerimaan"),
                                1: buildSegment("Pengeluaran"),
                              },
                              onValueChanged: (value) {
                                context.read<TransactionBloc>().add(
                                    SelectedIsOutcomeEvent(value: value ?? 0));
                                data!.isOutcome = value!;
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
                                            initialDate: DateTime.parse(
                                                data!.createdTime),
                                            firstDate: DateTime(1900),
                                            lastDate: DateTime(9999))
                                        .then((value) {
                                      (value == null)
                                          ? context.read<TransactionBloc>().add(
                                              SelectedDateEvent(
                                                  value: data!.createdTime))
                                          : context.read<TransactionBloc>().add(
                                              SelectedDateEvent(
                                                  value: value.toString()));
                                    });
                                  },
                                  child: ListTile(
                                    leading: const Icon(Icons.calendar_month),
                                    title: Text(
                                      DateFormat('dd / MM / yyyy').format(
                                        DateTime.parse(
                                          // (data!.modifieldTrxTime.isEmpty)
                                          //     ? data!.createdTime
                                          //     : data!.modifieldTrxTime,
                                          data!.createdTime,
                                        ),
                                      ),
                                    ),
                                    trailing:
                                        const Icon(Icons.arrow_drop_down_sharp),
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
                                        ReadIconCategoryDefault(isDefault: 0));

                                    Navigator.of(context, rootNavigator: true)
                                        .pushNamed(
                                            AppRoutes.transactionCategory);
                                  },
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      radius: 25,
                                      foregroundColor: Colors.red,
                                      child: ClipOval(
                                        child: Image.asset(
                                          "assets/icons/${data!.categoryIconName}.png",
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    title: Text(data!.categoryName.toString()),
                                    trailing:
                                        const Icon(Icons.arrow_drop_down_sharp),
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
                                  controller: nameController
                                    ..text = data!.title,
                                  onSaved: (newValue) {
                                    if (newValue!.isNotEmpty ||
                                        newValue != "") {
                                      data!.title = newValue;
                                    }
                                  },
                                  onFieldSubmitted: (value) {
                                    nameController.text = value;
                                    data!.title = value;
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
                                  controller: deskriptionController
                                    ..text = data?.description ?? "",
                                  decoration: const InputDecoration(
                                    hintText:
                                        "Ketikan Deskripsi Transaksi (optional)",
                                  ),
                                  onSaved: (newValue) {
                                    data!.description = newValue ?? "";
                                  },
                                  onFieldSubmitted: (value) {
                                    deskriptionController.text = value;
                                    data!.description = value;
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
                                  // focusNode: focusedCtx,
                                  // scrollPadding: EdgeInsets.only(
                                  // bottom: MediaQuery.of(context)
                                  //         .viewInsets
                                  //         .bottom +
                                  //     12 * 4),
                                  keyboardType: TextInputType.number,
                                  controller: amountController
                                    ..text = data!.amount.toString(),
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
                                      data!.amount = double.parse(newValue);
                                    }
                                  },
                                  onFieldSubmitted: (value) {
                                    amountController.text = value;
                                    data!.amount = double.parse(value);
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
                            context.read<TransactionBloc>().add(
                                UpdateTransactionEvent(
                                    idTransaction: data!.id!,
                                    valueTransaction: data!));
                          }
                          Navigator.pushReplacementNamed(
                              context, AppRoutes.first);
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
      ),
    );
  }
}
